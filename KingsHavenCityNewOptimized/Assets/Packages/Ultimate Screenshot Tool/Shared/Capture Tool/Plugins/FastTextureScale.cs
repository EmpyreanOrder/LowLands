﻿// Author: Eric Haines(Eric5h5)
// http://wiki.unity3d.com/index.php/TextureScale

// Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)
// https://creativecommons.org/licenses/by-sa/3.0/
// Only works on ARGB32, RGB24 and Alpha8 textures that are marked readable

// Modified: Jacob Hanshaw
// Added the apply parameter.
// Replaced Mathf.Floor with cast to int.
// Expanded out use of ColorLerpUnclamped.
// Use Color32 for greater speed and memory efficiency.

using System.Threading;
using UnityEngine;

public class FastTextureScale
{
    public class ThreadData
    {
        public int start;
        public int end;
        public ThreadData(int s, int e)
        {
            start = s;
            end = e;
        }
    }

    private static Color32[] texColors;
    private static Color32[] newColors;

    //private static Unity.Collections.NativeArray<Color32> texColors;
    //private static Unity.Collections.NativeArray<Color32> newColors;

    private static int w;
    private static float ratioX;
    private static float ratioY;
    private static int w2;
    private static int finishCount;
    private static Mutex mutex;

    public static void Point(Texture2D tex, int newWidth, int newHeight, bool apply = true)
    {
        ThreadedScale(tex, newWidth, newHeight, false, apply);
    }

    public static void Bilinear(Texture2D tex, int newWidth, int newHeight, bool apply = true)
    {
        ThreadedScale(tex, newWidth, newHeight, true, apply);
    }

    private static void ThreadedScale(Texture2D tex, int newWidth, int newHeight, bool useBilinear, bool apply = true)
    {
        texColors = tex.GetPixels32();
        newColors = new Color32[newWidth * newHeight];

        //texColors = tex.GetRawTextureData<Color32>();
        //newColors = new Unity.Collections.NativeArray<Color32>(newWidth * newHeight, Unity.Collections.Allocator.Temp, Unity.Collections.NativeArrayOptions.UninitializedMemory);
        if (useBilinear)
        {
            ratioX = 1.0f / ((float)newWidth / (tex.width - 1));
            ratioY = 1.0f / ((float)newHeight / (tex.height - 1));
        }
        else
        {
            ratioX = ((float)tex.width) / newWidth;
            ratioY = ((float)tex.height) / newHeight;
        }
        w = tex.width;
        w2 = newWidth;
        var cores = Mathf.Min(SystemInfo.processorCount, newHeight);
        var slice = newHeight / cores;

        finishCount = 0;
        if (mutex == null)
        {
            mutex = new Mutex(false);
        }
        if (cores > 1)
        {
            int i = 0;
            ThreadData threadData;
            for (i = 0; i < cores - 1; i++)
            {
                threadData = new ThreadData(slice * i, slice * (i + 1));
                ParameterizedThreadStart ts = useBilinear ? new ParameterizedThreadStart(BilinearScale) : new ParameterizedThreadStart(PointScale);
                Thread thread = new Thread(ts);
                thread.Start(threadData);
            }
            threadData = new ThreadData(slice * i, newHeight);
            if (useBilinear)
            {
                BilinearScale(threadData);
            }
            else
            {
                PointScale(threadData);
            }
            while (finishCount < cores)
            {
                Thread.Sleep(1);
            }
        }
        else
        {
            ThreadData threadData = new ThreadData(0, newHeight);
            if (useBilinear)
            {
                BilinearScale(threadData);
            }
            else
            {
                PointScale(threadData);
            }
        }

        tex.Reinitialize(newWidth, newHeight);
        tex.SetPixels32(newColors);
        //tex.LoadRawTextureData<Color32>(newColors);

        if (apply) tex.Apply(false);

        texColors = null;
        newColors = null;

        //newColors.Dispose();
    }

    public static void BilinearScale(System.Object obj)
    {
        ThreadData threadData = (ThreadData)obj;
        for (var y = threadData.start; y < threadData.end; y++)
        {
            float yScaled = y * ratioY;
            int yFloor = (int)yScaled;
            var y1 = yFloor * w;
            var y2 = (yFloor + 1) * w;
            var yw = y * w2;

            for (var x = 0; x < w2; x++)
            {
                float xScaled = x * ratioX;
                int xFloor = (int)xScaled;
                var xLerp = x * ratioX - xFloor;
                var yLerp = y * ratioY - yFloor;

                Color32 c1 = texColors[y1 + xFloor];
                Color32 c2 = texColors[y1 + xFloor + 1];
                Color32 c3 = texColors[y2 + xFloor];
                Color32 c4 = texColors[y2 + xFloor + 1];
                newColors[yw + x] = new Color32(
                          (byte)((c1.r + (c2.r - c1.r) * xLerp) + ((c3.r + (c4.r - c3.r) * xLerp) - (c1.r + (c2.r - c1.r) * xLerp)) * yLerp),
                          (byte)((c1.g + (c2.g - c1.g) * xLerp) + ((c3.g + (c4.g - c3.g) * xLerp) - (c1.g + (c2.g - c1.g) * xLerp)) * yLerp),
                          (byte)((c1.b + (c2.b - c1.b) * xLerp) + ((c3.b + (c4.b - c3.b) * xLerp) - (c1.b + (c2.b - c1.b) * xLerp)) * yLerp),
                          (byte)((c1.a + (c2.a - c1.a) * xLerp) + ((c3.a + (c4.a - c3.a) * xLerp) - (c1.a + (c2.a - c1.a) * xLerp)) * yLerp));
            }
        }

        mutex.WaitOne();
        finishCount++;
        mutex.ReleaseMutex();
    }

    public static void PointScale(System.Object obj)
    {
        ThreadData threadData = (ThreadData)obj;
        for (var y = threadData.start; y < threadData.end; y++)
        {
            float yScaled = y * ratioY;
            var thisY = (int)yScaled * w;
            var yw = y * w2;
            for (var x = 0; x < w2; x++)
            {
                float index = thisY + ratioX * x;
                newColors[yw + x] = texColors[(int)index];
            }
        }

        mutex.WaitOne();
        finishCount++;
        mutex.ReleaseMutex();
    }
}