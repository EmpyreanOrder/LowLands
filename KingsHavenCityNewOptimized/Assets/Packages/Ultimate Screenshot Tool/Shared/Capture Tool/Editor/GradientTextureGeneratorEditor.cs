﻿using UnityEngine;
using UnityEditor;

using TRS.CaptureTool.Extras;
namespace TRS.CaptureTool
{
    [ExecuteInEditMode]
    [CustomEditor(typeof(GradientTextureGenerator))]
    public class GradientTextureGeneratorEditor : Editor
    {
        const float MAX_HEIGHT = 250.0F;

        Texture2D preview;

        public override void OnInspectorGUI()
        {
            GUI.enabled = !EditorApplication.isCompiling && !EditorApplication.isUpdating;
            serializedObject.Update();

            if(preview != null)
            {
                float previewScale = EditorGUIUtility.currentViewWidth / (float)preview.width;
                Rect position = EditorGUILayout.GetControlRect(false, Mathf.Min(preview.height * previewScale, MAX_HEIGHT));
                if (Event.current.type.Equals(EventType.Repaint))
                    GUI.DrawTexture(position, preview, ScaleMode.ScaleToFit);
            }

            CustomEditorGUILayout.PropertyField(serializedObject.FindProperty("gradient"));

            CustomEditorGUILayout.PropertyField(serializedObject.FindProperty("direction"));

            CustomEditorGUILayout.PropertyField(serializedObject.FindProperty("width"));
            CustomEditorGUILayout.PropertyField(serializedObject.FindProperty("height"));

            bool showSaveSettings = CustomEditorGUILayout.BoldFoldoutForProperty(serializedObject, "showSaveSettings", "Save Settings");
            if (showSaveSettings)
            {
                SerializedProperty fileSettingsProperty = serializedObject.FindProperty("fileSettings");
                FileSettingsEditorHelper.ScreenshotFileSettingsFields(((GradientTextureGenerator)target).fileSettings, fileSettingsProperty, true, false, false);
            }
            serializedObject.ApplyModifiedProperties();

            if (GUILayout.Button("Update Preview", GUILayout.MinHeight(40)))
            {
                preview = ((GradientTextureGenerator)target).Texture();
                preview.Apply();
            }

            if (GUILayout.Button("Save", GUILayout.MinHeight(40)))
                ((GradientTextureGenerator)target).Save();

            EditorGUILayout.Space();

            OpenFileOrFolderButtons();
        }

        protected void OpenFileOrFolderButtons()
        {
            string filePath = serializedObject.FindProperty("lastSaveFilePath").stringValue;
            SerializedProperty captureFileSettingsProperty = serializedObject.FindProperty("fileSettings");
            string folderPath = captureFileSettingsProperty.FindPropertyRelative("cachedEditorDirectory").stringValue;

            bool originalGUIEnabled = GUI.enabled;
            GUI.enabled &= !string.IsNullOrEmpty(filePath);
            if (GUILayout.Button("View Last Gradient", GUILayout.MinHeight(40)))
            {
                Application.OpenURL("file:///" + System.Uri.EscapeUriString(filePath));
                Debug.Log("Opening File " + filePath);
            }

            GUI.enabled = originalGUIEnabled && !string.IsNullOrEmpty(folderPath);
            if (GUILayout.Button("View Gradients Folder", GUILayout.MinHeight(60)))
            {
                Application.OpenURL("file:///" + System.Uri.EscapeUriString(folderPath));
                Debug.Log("Opening Directory " + folderPath);
            }
            GUI.enabled = originalGUIEnabled;
        }
    }
}