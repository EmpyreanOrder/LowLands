//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEditor;
    using DeepSpaceLabs.SAM;

    [CustomEditor(typeof(AddressableSceneChunkStreamer))]
    public class AddressableSceneChunkStreamerEditor : Editor
    {
        AddressableBaseChunkStreamerEditor baseEditor;

        public override void OnInspectorGUI()
        {
            if (baseEditor == null)
                baseEditor = new AddressableBaseChunkStreamerEditor(serializedObject, true, true, false);

            baseEditor.DrawRightAlignedQuestionMarkGuideHelpLink("Chunk Streamers", "Addressable Scene Streamer");

            baseEditor.OnInspectorGUI();

            baseEditor.DrawBoldLabel("Scene Settings (From Addressable Scene Streamer)");

            serializedObject.Update();
            baseEditor.helper.DrawSerializedPropertyField("callUnloadUnusedAssets");
            baseEditor.helper.DrawSerializedPropertyField("relinquishControlASAP");

            baseEditor.helper.DrawSerializedPropertyField("keepScenesIntact");
            baseEditor.helper.DrawSerializedPropertyField("invalidSceneFormatMessageLevel");
            if (serializedObject.hasModifiedProperties)
                serializedObject.ApplyModifiedProperties();
        }
    }
}