//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEditor;
    public class AddressableBaseChunkStreamerEditor : ChunkStreamerBaseEditor
    {
        bool useMaxLoadAsyncOpsToCompleteInSingleFrameSettings, usesMaxUnloadAsyncOpsToStartInSingleFrameSettings, usesMaxUnloadAsyncOpsToCompleteInSingleFrameSettings;

        public AddressableBaseChunkStreamerEditor(SerializedObject serializedObject, bool useMaxLoadAsyncOpsToCompleteInSingleFrameSettings, bool usesMaxUnloadAsyncOpsToStartInSingleFrameSettings, bool usesMaxUnloadAsyncOpsToCompleteInSingleFrameSettings) : base(serializedObject)
        {
            this.useMaxLoadAsyncOpsToCompleteInSingleFrameSettings = useMaxLoadAsyncOpsToCompleteInSingleFrameSettings;
            this.usesMaxUnloadAsyncOpsToStartInSingleFrameSettings = usesMaxUnloadAsyncOpsToStartInSingleFrameSettings;
            this.usesMaxUnloadAsyncOpsToCompleteInSingleFrameSettings = usesMaxUnloadAsyncOpsToCompleteInSingleFrameSettings;
        }

        protected sealed override void DrawPostInspector()
        {
            DrawSpace();
            DrawBoldLabel("All Settings Below Are Specific To This Streamer");
            
            DrawSpace();
            DrawBaseChunkStreamerAsyncSettings(true, useMaxLoadAsyncOpsToCompleteInSingleFrameSettings, usesMaxUnloadAsyncOpsToStartInSingleFrameSettings, usesMaxUnloadAsyncOpsToCompleteInSingleFrameSettings);

            DrawSpace();
            DrawBoldLabel("Async Op Settings (From Addressable Base Streamer)");

            helper.DrawSerializedPropertyField("defaultMaxChunksToConfigureInSingleFrame");
            helper.DrawSerializedPropertyField("maxChunksToConfigureKey");
            DrawSpace();

            helper.DrawSerializedPropertyField("defaultMaxAsyncHandlesToReleaseInSingleFrame");
            helper.DrawSerializedPropertyField("maxAsyncHandlesReleaseKey");
            //helper.DrawSerializedPropertyField("asyncLoadStrategy");
            DrawSpace();
            helper.DrawSerializedPropertyField("preCalculateIResourceLocations");

            DrawSpace();
            DrawBoldLabel("Prepended/Appended Data Settings (From Addressable Base Streamer)");
            helper.DrawSerializedPropertyField("prependExtraUserData");
            if(helper.GetPropertyByName("prependExtraUserData").boolValue)
                helper.DrawSerializedPropertyField("prependDataKey");

            helper.DrawSerializedPropertyField("appendExtraUserData");
            if (helper.GetPropertyByName("appendExtraUserData").boolValue)
                helper.DrawSerializedPropertyField("appendDataKey");

            helper.DrawSerializedPropertyField("appendFileExtension");

            DrawSpace();
            DrawBoldLabel("Error Handling Settings (From Addressable Base Streamer)");
            helper.DrawSerializedPropertyField("maxLoadAttempts");
            helper.DrawSerializedPropertyField("errorRepairer");
            helper.DrawSerializedPropertyField("useAltLODFailSafe");
            helper.DrawSerializedPropertyField("usePlaceholderFailSafe");
            helper.DrawSerializedPropertyField("printErrorToConsole");
            helper.DrawSerializedPropertyField("addressableExceptionHandler");
            DrawSpace();
            DrawPostInspector2();
        }

        protected virtual void DrawPostInspector2() { }
    }
}
