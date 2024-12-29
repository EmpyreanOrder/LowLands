using UnityEngine;
using UnityEngine.UI;
using System.Collections.Generic;

namespace TRS.CaptureTool
{
    public class ToggleScreenshotShaderDemoScript : MonoBehaviour
    {
        public ScreenshotScript screenshotScript;

        public Shader[] shaders;
        public string[] shaderNames;

        ShaderTextureTransformation shaderTextureTransformation;
        int shaderIndex = -1;
        
        Text text;

        void Start()
        {
            if (shaders.Length != shaderNames.Length)
                Debug.LogError("Shader names count: " + shaderNames.Length + " does not match shader count: " + shaders.Length);

            text = GetComponentInChildren<Text>();
        }

        public void OnClick()
        {
            shaderIndex += 1;
            if (shaderIndex >= shaders.Length)
            {
                Reset();
                return;
            }

            if (shaderTextureTransformation == null)
            {
                List<TextureTransformation> captureTransformations = new List<TextureTransformation>(screenshotScript.captureTransformations);
                shaderTextureTransformation = TextureTransformation.ShaderTextureTransformation(shaders[shaderIndex]);
                captureTransformations.Add(shaderTextureTransformation);
                screenshotScript.captureTransformations = captureTransformations.ToArray();
            }
            else
                shaderTextureTransformation.shader = shaders[shaderIndex];

            text.text = "Shader: " + shaderNames[shaderIndex];
        }

        public void Reset()
        {
            shaderIndex = -1;
            text.text = "Shader: None";

            if(shaderTextureTransformation != null)
            {
                List<TextureTransformation> captureTransformations = new List<TextureTransformation>(screenshotScript.captureTransformations);
                captureTransformations.Remove(shaderTextureTransformation);
                screenshotScript.captureTransformations = captureTransformations.ToArray();
                shaderTextureTransformation = null;
            }
        }
    }
}