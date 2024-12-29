using UnityEngine;

namespace TRS.CaptureTool
{
    public static class ResolutionExtensions
    {
        public static Resolution EmptyResolution()
        {
            return new Resolution { width = 0, height = 0 };
        }

        public static bool HasSize(this Resolution resolution)
        {
            return resolution.width != 0 && resolution.height != 0;
        }

        public static bool IsValid(this Resolution resolution)
        {
#if UNITY_2022_2_OR_NEWER
            return resolution.HasSize() && resolution.refreshRateRatio.value != 0;
#else
            return resolution.HasSize() && resolution.refreshRate != 0;
#endif
        }

        public static Resolution Scale(this Resolution resolution, int scale)
        {
#if UNITY_2022_2_OR_NEWER
            return new Resolution { width = resolution.width * scale, height = resolution.height * scale, refreshRateRatio = resolution.refreshRateRatio };
#else
            return new Resolution { width = resolution.width * scale, height = resolution.height * scale, refreshRate = resolution.refreshRate };
#endif
        }

        public static Resolution Scale(this Resolution resolution, float scale)
        {
#if UNITY_2022_2_OR_NEWER
            return new Resolution { width = (int)(float)(resolution.width * scale), height = (int)(float)(resolution.height * scale), refreshRateRatio = resolution.refreshRateRatio };
#else
            return new Resolution { width = (int)(float)(resolution.width * scale), height = (int)(float)(resolution.height * scale), refreshRate = resolution.refreshRate };
#endif
        }

        public static bool IsSameSizeAs(this Resolution resolution, Resolution otherResolution)
        {
            return resolution.width == otherResolution.width && resolution.height == otherResolution.height;
        }
    }
}
