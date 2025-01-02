//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEditor;
    using DeepSpaceLabs.SAM;

    [CustomEditor(typeof(AddressablePrefabChunkStreamer))]
    public class AddressablePrefabChunkStreamerEditor : Editor
    {
        AddressableBaseChunkStreamerEditor baseEditor;

        public override void OnInspectorGUI()
        {
            if (baseEditor == null)
                baseEditor = new AddressableBaseChunkStreamerEditor(serializedObject, true, false, false);

            baseEditor.DrawRightAlignedQuestionMarkGuideHelpLink("Chunk Streamers", "Addressable Prefab Streamer");

            baseEditor.OnInspectorGUI();

            baseEditor.DrawBoldLabel("General Settings (From Addressable Prefab Streamer)");

            serializedObject.Update();
            baseEditor.helper.DrawSerializedPropertyField("loadInDeactivatedState");
            baseEditor.helper.DrawSerializedPropertyField("memoryFreeingStrategy");
            if ((MemoryFreeingStrategy)baseEditor.helper.GetPropertyByName("memoryFreeingStrategy").intValue != MemoryFreeingStrategy.DontFreeMemory)
                baseEditor.helper.DrawSerializedPropertyField("waitOnFinalMemoryFreeingOp");

            baseEditor.helper.DrawSerializedPropertyField("chunkDestroyer");
            if (serializedObject.hasModifiedProperties)
                serializedObject.ApplyModifiedProperties();
        }
    }
}