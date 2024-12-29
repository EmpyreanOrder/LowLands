using UnityEngine;
using UnityEngine.UI;

namespace TRS.CaptureTool
{
    public class ToggleScreenshotPreviewModeDemoScript : MonoBehaviour
    {
        public ScreenshotScript screenshotScript;
        public SaveScreenshotUIScript saveScreenshotUIScript;
        public MemeScreenshotUIScript memeScreenshotUIScript;

        public Button takeScreenshotButton;
        bool showPreview = false;
        bool createMeme = false;

        Text text;

        void Start()
        {
            text = GetComponentInChildren<Text>();
            Reset();
        }

        public void OnClick()
        {
            if (!showPreview) showPreview = true;
            else if (!createMeme) createMeme = true;
            else
            {
                showPreview = false;
                createMeme = false;
            }

            UpdateButton();
        }

        public void Reset()
        {
            showPreview = false;
            createMeme = false;
            UpdateButton();
        }

        void UpdateButton()
        {
            // Also remove the persistent listener (set in Editor).
            takeScreenshotButton.onClick = new Button.ButtonClickedEvent();
            takeScreenshotButton.onClick.AddListener(() => { screenshotScript.TakeSingleScreenshot(!showPreview); });
            saveScreenshotUIScript.displayAutomatically = showPreview && !createMeme;
            memeScreenshotUIScript.displayAutomatically = createMeme;

            if (createMeme)
                text.text = "Save Mode: Meme";
            else if (showPreview)
                text.text = "Save Mode: Preview";
            else
                text.text = "Save Mode: Instant";
        }
    }
}