using UnityEngine;

namespace TRS.CaptureTool.Extras
{
    public class DemoHotKeyPreviewScript : MonoBehaviour
    {
        public ScreenshotScript screenshotScript;

        public HotKeySet takeSingleScreenshotWithPreviewKeySet = new HotKeySet
        {
#if UNITY_2019_2_OR_NEWER && ENABLE_INPUT_SYSTEM
            key = UnityEngine.InputSystem.Key.E,
#endif
#if ENABLE_LEGACY_INPUT_MANAGER
            keyCode = KeyCode.E,
#endif
        };
#if UNITY_EDITOR || UNITY_STANDALONE || UNITY_WEBGL
        protected void Update()
        {
            if (FlexibleInput.AnyKey() && !UIStatus.InputFieldFocused())
            {
                // The preview window listens for the screenshot event and is automatically displayed.
                bool takeSingleScreenshotWithPreview = takeSingleScreenshotWithPreviewKeySet.MatchesInput();
                if(takeSingleScreenshotWithPreview)
                    screenshotScript.TakeSingleScreenshot(false);
            }
        }
#endif
    }
}
