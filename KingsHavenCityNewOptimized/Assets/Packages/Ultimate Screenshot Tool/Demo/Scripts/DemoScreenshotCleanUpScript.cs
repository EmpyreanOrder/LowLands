using System.Collections.Generic; // Used within preprocessor directive
using UnityEngine;

namespace TRS.CaptureTool
{
    /*  There is no direct access to media saved to a mobile gallery or to the
     *  desktop from a web build, so we need our own persisted file to access 
     *  (and upload/share) these screenshots.
     *  
     *  This script cleans up screenshots saved to these temporary directories.
     *
     *  It does this by:
     *  1.) Emptying out the Temp folder on each open.
     *  2.) Tracking and deleting any screenshots saved while this script is
     *      active.
     * 
     *  It also forces the screenshot script to use these temporary directories.
     *     
     */

    public class DemoScreenshotCleanUpScript : MonoBehaviour
    {
        public ScreenshotScript screenshotScript;

#if !UNITY_EDITOR && (UNITY_IOS || UNITY_ANDROID || UNITY_WEBGL)
        const string TEMP_DIRECTORY = "TRS_Temp";

        bool originalWebPersistValue;
        string originalwebRelativeDirectory;

        bool originalMobilePersistValue;
        string originaliosRelativeDirectory;
        string originalandroidRelativeDirectory;

        List<string> createdMediaFiles = new List<string>();

        void OnEnable()
        {
            originalWebPersistValue = screenshotScript.fileSettings.persistLocallyWeb;
            originalwebRelativeDirectory = screenshotScript.fileSettings.webRelativeDirectory;

            originalMobilePersistValue = screenshotScript.fileSettings.persistLocallyMobile;
            originalandroidRelativeDirectory = screenshotScript.fileSettings.androidRelativeDirectory;
            originaliosRelativeDirectory = screenshotScript.fileSettings.iosRelativeDirectory;

            screenshotScript.fileSettings.persistLocallyWeb = true;
            screenshotScript.fileSettings.webRelativeDirectory = TEMP_DIRECTORY;

            screenshotScript.fileSettings.persistLocallyMobile = true;
            screenshotScript.fileSettings.androidRelativeDirectory = TEMP_DIRECTORY;
            screenshotScript.fileSettings.iosRelativeDirectory = TEMP_DIRECTORY;

            foreach (string filePath in System.IO.Directory.GetFiles(screenshotScript.fileSettings.directory))
                System.IO.File.Delete(filePath);

            ScreenshotScript.ScreenshotSaved += ScreenshotSaved;
        }

        void OnDisable()
        {
            ScreenshotScript.ScreenshotSaved -= ScreenshotSaved;

            foreach (string mediaFilePath in createdMediaFiles)
                System.IO.File.Delete(mediaFilePath);

            screenshotScript.fileSettings.persistLocallyWeb = originalWebPersistValue;
            screenshotScript.fileSettings.webRelativeDirectory = originalwebRelativeDirectory;

            screenshotScript.fileSettings.persistLocallyMobile = originalMobilePersistValue;
            screenshotScript.fileSettings.androidRelativeDirectory = originalandroidRelativeDirectory;
            screenshotScript.fileSettings.iosRelativeDirectory = originaliosRelativeDirectory;
        }

        void ScreenshotSaved(ScreenshotScript screenshotScript, string filePath)
        {
            createdMediaFiles.Add(filePath);
        }
#endif
    }
}