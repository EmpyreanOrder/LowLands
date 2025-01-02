//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEngine;
    using System;
    using System.Collections.Generic;
    using UnityEditor.AddressableAssets;
    using UnityEditor.AddressableAssets.Settings;
    using System.Linq;
    using UnityEditor;
    using DeepSpaceLabs.Core;
    using DeepSpaceLabs.EditorCore;
    using DeepSpaceLabs.SAM;

    public class DefaultAddressableSceneAssetManager : SceneBasedAssetManager
    {
        [SAMGuideButton("Scriptable Assets", "Default Addressable Scene Asset Manager")]

        [SerializeField, FieldRename("Settings*", "Addressable Settings asset to use to load assets. Only assign settings here if the settings are not set as the default settings, otherwise the assignment will be redundant, as the asset manager is configured to work with the default settings.")]
        AddressableAssetSettings settings;

        [NonSerialized]
        AddressableAssetSettings settingsToUse;

        protected override string GetFullScenePath(string loadKey)
        {
            if (settings != null)
                settingsToUse = settings;
            else if (settingsToUse == null)
                settingsToUse = AddressableAssetSettingsDefaultObject.Settings;

            if (settingsToUse == null)
                throw new InvalidOperationException($"Could not get the scene path of asset with load key {loadKey} because the Addressable Scene Chunk Streamer does not have access to Addressable Asset Settings. Either assign the settings to the Asset Manager, or setup a default settings in the Addressables Groups window.");

            return GetAssetPath(loadKey);
        }

        string GetAssetPath(string address)
        {
            var entries = from addressableAssetGroup in settingsToUse.groups
                          from entrie in addressableAssetGroup.entries
                          select entrie;

            foreach (var entry in entries)
            {
                var allEntries = new List<AddressableAssetEntry>();
                entry.GatherAllAssets(allEntries, true, true, false);

                for (int i = 0; i < allEntries.Count; i++)
                {
                    var assetEntry = allEntries[i];

                    if (assetEntry.address == address)
                    {
                        return assetEntry.AssetPath;
                    }
                }
            }

            return null;
        }

        public sealed override bool DoesAssetExist(AssetChunkInfo assetChunkInfo)
        {
            if (settings != null)
                settingsToUse = settings;
            else if (settingsToUse == null)
                settingsToUse = AddressableAssetSettingsDefaultObject.Settings;

            if (settingsToUse == null)
                throw new InvalidOperationException($"Could not check if the asset with load key {assetChunkInfo.assetChunkLoadKey} exists because the Addressable Scene Chunk Streamer does not have access to Addressable Asset Settings. Either assign the settings to the Asset Manager, or setup a default settings in the Addressables Groups window.");

            string scenePath = GetFullScenePath(assetChunkInfo.assetChunkLoadKey);
            if (scenePath == null)
                return false;

            return DoesAssetExistInDatabase(scenePath);
        }

        [MenuItem(SAM.GlobalValues.ACTIONS_MENU_PATH + "Regenerate Default Addressable Scene Asset Manager", true)]
        static bool RegenerateDefaultAddressableSceneManagerValidate()
        {
            string filePath = $"{AssetManagerFolder}AddressableSceneChunkStreamer_AssetManager.asset";
            var assetManager = AssetDatabase.LoadAssetAtPath<AssetManager>(filePath);
            return assetManager == null;
        }
        [MenuItem(SAM.GlobalValues.ACTIONS_MENU_PATH + "Regenerate Default Addressable Scene Asset Manager", false)]
        static void RegenerateDefaultAddressableSceneManager()
        {
            string filePath = $"{AssetManagerFolder}AddressableSceneChunkStreamer_AssetManager.asset";
            var asset = ScriptableObjectAssetCreator.CreateAsset<DefaultAddressableSceneAssetManager>(filePath);
            Selection.activeObject = asset;
            EditorGUIUtility.PingObject(asset);
        }
    }
}