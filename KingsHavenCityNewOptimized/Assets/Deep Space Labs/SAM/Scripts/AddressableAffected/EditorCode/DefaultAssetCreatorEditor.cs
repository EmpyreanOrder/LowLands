//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEditor;
    using UnityEngine;
    using DeepSpaceLabs.EditorCore;
    using DeepSpaceLabs.SAM;

#if ENABLE_ADDRESSABLES
    using UnityEditor.AddressableAssets.Settings;
    using UnityEditor.AddressableAssets;
    using System;
#endif

    [CustomEditor(typeof(DefaultAssetCreator))]
    public class DefaultAssetCreatorEditor : Editor
    {
        DefaultAssetCreatorBaseEditor baseEditor;

        public override void OnInspectorGUI()
        {
            if (baseEditor == null)
                baseEditor = new DefaultAssetCreatorBaseEditor(serializedObject);

            baseEditor.OnInspectorGUI();
        }

        [MenuItem(GlobalValues.ASSET_CREATION_PATH + "Default Asset Creator", false, 2)]
        public static void CreateDefaultAssetCreatorFile()
        {
            ScriptableObjectAssetCreator.GenerateScriptableObjectAssetAtSelectedFolder<DefaultAssetCreator>("DefaultAssetCreator");
        }
    }

    public class DefaultAssetCreatorBaseEditor : BaseEditor
    {
        bool atLeastOnePrefabPresent, atLeatOnePrefabHasTerrain;

#if ENABLE_ADDRESSABLES
        bool canDrawAddressableSettings;
        string[] prefabAssetGroups, sceneAssetGroups;
        int prefabGroupChoice, sceneGroupChoice;
        double timeSinceLastDraw;
#endif
        public DefaultAssetCreatorBaseEditor(SerializedObject serializedObject) : base(serializedObject)
        {
#if ENABLE_ADDRESSABLES
            timeSinceLastDraw = -10d;//set it to this to trigger an addressable group options update the first time the inspector is drawn
#endif

            if(serializedObject.FindProperty("version").intValue == 1)
            {
                serializedObject.Update();

                var prefabChunkTemplatesProp = serializedObject.FindProperty("prefabChunkTemplates");
                int prefabChunkTemplates = prefabChunkTemplatesProp.arraySize;
                if (prefabChunkTemplates > 0)
                {
                    var templatesProp = serializedObject.FindProperty("templates");
                    templatesProp.arraySize = 1;
                    var templateProp = templatesProp.GetArrayElementAtIndex(0);
                    var chunkPrefabsProp = templateProp.FindPropertyRelative("chunkPrefabs");

                    chunkPrefabsProp.arraySize = prefabChunkTemplates;
                    for(int i = 0; i < prefabChunkTemplates;i++)
                    {
                        chunkPrefabsProp.GetArrayElementAtIndex(i).objectReferenceValue = prefabChunkTemplatesProp.GetArrayElementAtIndex(i).objectReferenceValue;
                    }

                    prefabChunkTemplatesProp.arraySize = 0;//clear original prefabChunkTemplates array
                    Debug.Log($"Upgraded the Default Asset Creator {serializedObject.targetObject.name} to Version 2 in order to make use of the new Asset Creator Template system. You can now add multiple Chunk Templates targeting specific Zones, World Groupings, and/or LOD Groups, allowing you to make use of a single Default Asset Creator on multiples LOD Groups across different Zones and/or World Groupings.");
                }

                serializedObject.FindProperty("version").intValue = 2;
                serializedObject.ApplyModifiedPropertiesWithoutUndo();
            }

            CheckPrefabTemplates_Light();
        }

        protected override void DrawInspector()
        {
            DrawRightAlignedQuestionMarkGuideHelpLink("World Designer Tool", "Asset Creators");

#if ENABLE_ADDRESSABLES
            canDrawAddressableSettings = AddressableAssetSettingsDefaultObject.Settings != null;

            if (canDrawAddressableSettings)
            {
                double currentTime = EditorApplication.timeSinceStartup;
                if (currentTime - timeSinceLastDraw > 1d)
                {
                    UpdateAddressableGroupOptions("prefabSettings", "prefabGroup", true, ref prefabAssetGroups, ref prefabGroupChoice);
                    UpdateAddressableGroupOptions("sceneSettings", "sceneGroup", true, ref sceneAssetGroups, ref sceneGroupChoice);
                }
                timeSinceLastDraw = currentTime;
            }
            else
                EditorGUILayout.HelpBox("The Addressables Package has been detected in your project, however no Default Addressable Settings asset was found.\n\nPlease create one if you would like to enable addressable features on this Asset Creator. The simplest way to do this is to open the Addressable Groups window via Window -> Asset Management -> Addressables -> Groups, where you will see a prompt to create the settings.", MessageType.Warning);
#endif
            helper.DrawSerializedPropertyField("assetCreationMode", assetCreationModeLabel);

            var creationMode = (DefaultAssetCreator.AssetCreationMode)helper.GetPropertyByName("assetCreationMode").intValue;

            if (creationMode == DefaultAssetCreator.AssetCreationMode.Prefabs_And_Scenes)
            {
                helper.DrawSerializedPropertyField("primaryAssets", primaryAssetsLabel);
                EditorGUILayout.Space();
            }

            if (creationMode != DefaultAssetCreator.AssetCreationMode.Only_Scenes)
            {
                DrawPrefabSettings(creationMode);
                EditorGUILayout.Space();
            }

            if (creationMode != DefaultAssetCreator.AssetCreationMode.Only_Prefabs)
            {
                DrawSceneSettings();
                EditorGUILayout.Space();
            }
            
#if ENABLE_ADDRESSABLES
            if (canDrawAddressableSettings)
            {
                EditorGUILayout.Space();
                if (creationMode == DefaultAssetCreator.AssetCreationMode.Prefabs_And_Scenes && helper.GetPropertyByName("makePrefabsAddressable").boolValue && helper.GetPropertyByName("makeScenesAddressable").boolValue)
                    EditorGUILayout.HelpBox("When using the addressable system, it is generally a good idea to only make the Scenes addressable when those scenes contain Prefab Instances, however you are free to make both the prefabs and scenes addressable if that is your desire.", MessageType.Warning);
            }
#endif

            EditorGUI.BeginChangeCheck();
            helper.DrawSerializedPropertyArrayField("templates", chunkTemplatesLabel);
            if (EditorGUI.EndChangeCheck())
                CheckPrefabTemplates_Heavy();

            EditorGUILayout.Space();
            DrawOutputSubFolderOptions();
            EditorGUILayout.Space();

            if (atLeastOnePrefabPresent)
            {
                EditorGUI.indentLevel++;
                if (atLeatOnePrefabHasTerrain)
                {
                    DrawRelativeFolderOption("terrainDataSaveFolder", terrainDataSaveFolderLabel, "Terrain Data Save Folder");

                    EditorGUILayout.HelpBox("Terrain Prefab Detected!\n\nWhen CreateAssetsForCellChunk is called, the Chunk Prefabs with terrain components will be duplicated, and a new Terrain Data asset will be generated and stored in the folder above.\n\nThis process only works for the Terrain Component on the root prefab (not child game objects)! Material and Terrain Layer assets are not duplicated, nor are other assets on any components on the prefab (such as materials, sound files, etc).", MessageType.Warning);
                }
                else
                    EditorGUILayout.HelpBox("Assets referenced on your Chunk Prefabs (like Scriptabel Objects) will still be referenced on the new duplicated prefab, however note that the assets themselves are not duplicated. If you need to duplicate raw assets (other than Terrain Data, which is duplicated), you will need to create a custom Asset Creator.", MessageType.Warning);
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.HelpBox("In order to ensure the asset name matches the name passed to the CreateAssetsForCellChunk method, any existing assets (in any of the save folders specified) that match the name of an asset that would be generated using CreateAssetsForCellChunk will be overwritten!\n\nHowever, do note that GUIDs will be preserved when overwriting assets, so any references to the prefab/terrain data should still work.", MessageType.Warning);
        }

        void DrawOutputSubFolderOptions()
        {
            EditorGUILayout.LabelField(outputZoneSubFolderLabel1);
            helper.DrawSerializedPropertyField("outputToZoneSpecificSubFolder", outputZoneSubFolderLabel2);

            EditorGUILayout.LabelField(outputGroupingSubFolderLabel1);
            helper.DrawSerializedPropertyField("outputToGroupingSpecificSubFolder", outputGroupingSubFolderLabel2);

            EditorGUILayout.LabelField(outputLODGroupSubFolderLabel1);
            helper.DrawSerializedPropertyField("outputToLODGroupSpecificSubFolder", outputLODGroupSubFolderLabel2);
        }

        void DrawPrefabSettings(DefaultAssetCreator.AssetCreationMode creationMode)
        {
            if (!helper.DrawSerializedPropertyFoldoutField("prefabSectionDropdown", "Prefab Asset Settings", true))
                return;

            if (creationMode == DefaultAssetCreator.AssetCreationMode.Prefabs_And_Scenes)
            {
                EditorGUILayout.LabelField(spawnPrefabAsInstanceLabel1);
                helper.DrawSerializedPropertyField("spawnPrefabAsInstanceInScene", spawnPrefabAsInstanceLabel2);
            }

            DrawRelativeFolderOption("prefabSaveFolder", prefabSaveFolderLabel, "Prefab Save Folder");

#if ENABLE_ADDRESSABLES
            if (canDrawAddressableSettings)
            {
                EditorGUILayout.Space();
                helper.DrawSerializedPropertyField("makePrefabsAddressable", makePrefabsAddressableLabel);
                if (helper.GetPropertyByName("makePrefabsAddressable").boolValue)
                {
                    EditorGUI.indentLevel++;
                    EditorGUI.BeginChangeCheck();
                    helper.DrawSerializedPropertyField("prefabSettings", prefabSettingsLabel);
                    if (EditorGUI.EndChangeCheck())
                        UpdateAddressableGroupOptions("prefabSettings", "prefabGroup", true, ref prefabAssetGroups, ref prefabGroupChoice);

                    if (helper.GetPropertyByName("prefabSettings").objectReferenceValue == null)
                        EditorGUILayout.HelpBox("When no Addressable Settings asset is assigned, the Default Asset in the project is used to make the prefabs addressable. You should only assign a different asset if you don't wish to use this Default Asset for prefabs created with this Asset Creator.", MessageType.Info);

                    DrawGroupChoice("prefabSettings", "prefabGroup", "Prefab Group", ref prefabAssetGroups, ref prefabGroupChoice);

                    DrawAddressablePrependOption("prefabAddressPrepend", prefabPrependLabel);
                    helper.DrawSerializedPropertyField("prefabAddressAppend", prefabAppendLabel);

                    DrawSpace();
                    helper.DrawSerializedPropertyField("addLayerAsLabelToPrefabs", addLayerLabelsToPrefabsLabel);
                    helper.DrawSerializedPropertyField("addRowAsLabelToPrefabs", addRowLabelsToPrefabsLabel);
                    helper.DrawSerializedPropertyField("addColumnAsLabelToPrefabs", addColumnLabelsToPrefabsLabel);
                    DrawSpace();

                    helper.DrawSerializedPropertyArrayField("prefabLabels", prefabLabelsLabel);
                    EditorGUI.indentLevel--;
                }
            }
#endif
        }

        void CheckPrefabTemplates_Heavy()
        {
            atLeastOnePrefabPresent = false;
            atLeatOnePrefabHasTerrain = false;

            var templatesProp = helper.GetPropertyByName("templates");
            int templates = templatesProp.arraySize;
            for (int t = 0; t < templates; t++)
            {
                var prefabChunkTemplatesProp = templatesProp.GetArrayElementAtIndex(t).FindPropertyRelative("chunkPrefabs");
                int prefabChunkTemplates = prefabChunkTemplatesProp.arraySize;
                for (int i = 0; i < prefabChunkTemplates; i++)
                {
                    GameObject prefabTemplate = prefabChunkTemplatesProp.GetArrayElementAtIndex(i).objectReferenceValue as GameObject;
                    if (prefabTemplate != null)
                    {
                        if (prefabTemplate.GetComponent<Terrain>() != null)
                        {
                            atLeatOnePrefabHasTerrain = true;
                            atLeastOnePrefabPresent = true;
                        }
                        else if (prefabTemplate.GetComponentInChildren<Terrain>() != null)
                        {
                            Debug.LogError("At this time, it is not possible to use a Prefab Chunk with a Terrain component located on a child of the root prefab. If you'd like to use a prefab with a Terrain, the Terrain component must be located directly on the prefab parent you are dragging onto the Prefab Chunks array field.");

                            prefabChunkTemplatesProp.GetArrayElementAtIndex(i).objectReferenceValue = null;
                        }
                        else
                            atLeastOnePrefabPresent = true;
                    }
                }
            }
        }

        void CheckPrefabTemplates_Light()
        {
            atLeastOnePrefabPresent = false;
            atLeatOnePrefabHasTerrain = false;

            var templatesProp = helper.GetPropertyByName("templates");
            int templates = templatesProp.arraySize;
            for (int t = 0; t < templates; t++)
            {
                var prefabChunkTemplatesProp = templatesProp.GetArrayElementAtIndex(t).FindPropertyRelative("chunkPrefabs");
                int prefabChunkTemplates = prefabChunkTemplatesProp.arraySize;
                for (int i = 0; i < prefabChunkTemplates; i++)
                {
                    GameObject prefabTemplate = prefabChunkTemplatesProp.GetArrayElementAtIndex(i).objectReferenceValue as GameObject;
                    if (prefabTemplate != null)
                    {
                        atLeastOnePrefabPresent = true;
                        if (prefabTemplate.GetComponent<Terrain>() != null)
                        {
                            atLeatOnePrefabHasTerrain = true;
                            break;
                        }
                    }
                }
            }
        }

        void DrawSceneSettings()
        {
            if (!helper.DrawSerializedPropertyFoldoutField("sceneSectionDropdown", "Scene Asset Settings", true))
                return;

            DrawRelativeFolderOption("sceneSaveFolder", sceneSaveFolderLabel, "Scene Save Folder");

#if ENABLE_ADDRESSABLES
            if (canDrawAddressableSettings && helper.GetPropertyByName("makeScenesAddressable").boolValue)
            {
                EditorGUILayout.LabelField("Add Scenes To Build Settings (No) - Disable 'Make");
                EditorGUILayout.LabelField("Scenes Addressable' to add scenes to build settings.");
            }
            else
            {
                helper.DrawSerializedPropertyField("addScenesToBuildSettings", addToBuildSettingsLabel);
                if (!helper.GetPropertyByName("addScenesToBuildSettings").boolValue)
                    EditorGUILayout.HelpBox("If you are using this creator with an LOD Group that is set to be loaded by a Scene Chunk Streamer, disabling this option will likely cause various World Designer Tool operations to fail, as the scenes must be added to Build Settings in order for the Tool to identify and load them.\n\nIf you are using Addressables and an Addressable Scene Chunk Streamer, this is not a concern, as that Streamer does not use Build Setting scenes.", MessageType.Warning);

            }
#else
            helper.DrawSerializedPropertyField("addScenesToBuildSettings", addToBuildSettingsLabel);
            if(!helper.GetPropertyByName("addScenesToBuildSettings").boolValue)
                    EditorGUILayout.HelpBox("If you are using this creator with an LOD Group that is set to be loaded by a Scene Chunk Streamer, disabling this option will likely cause various World Designer Tool operations to fail, as the scenes must be added to Build Settings in order for the Tool to identify and load them.", MessageType.Warning);
#endif
            if (helper.GetPropertyByName("addScenesToBuildSettings").boolValue)
            {
                EditorGUI.indentLevel++;
                helper.DrawSerializedPropertyField("forceEndInsert", forceEndInsertLabel);
                EditorGUI.indentLevel--;
            }
#if ENABLE_ADDRESSABLES
            if (canDrawAddressableSettings)
            {
                EditorGUILayout.Space();
                if (helper.GetPropertyByName("addScenesToBuildSettings").boolValue)
                {
                    EditorGUILayout.LabelField("Make Scenes Addressable (No) - Disable 'Add Scenes");
                    EditorGUILayout.LabelField("'To Build Settings' to make scenes addressable.");
                }
                else
                    helper.DrawSerializedPropertyField("makeScenesAddressable", makeScenesAddressableLabel);

                if (helper.GetPropertyByName("makeScenesAddressable").boolValue)
                {
                    EditorGUI.indentLevel++;
                    EditorGUI.BeginChangeCheck();
                    helper.DrawSerializedPropertyField("sceneSettings", sceneSettingsLabel);
                    if (EditorGUI.EndChangeCheck())
                        UpdateAddressableGroupOptions("sceneSettings", "sceneGroup", true, ref sceneAssetGroups, ref sceneGroupChoice);

                    if (helper.GetPropertyByName("sceneSettings").objectReferenceValue == null)
                        EditorGUILayout.HelpBox("When no Addressable Settings asset is assigned, the Default Asset in the project is used to make the scenes addressable. You should only assign a different asset if you don't wish to use this Default Asset for scenes created with this Asset Creator.", MessageType.Info);

                    DrawGroupChoice("sceneSettings", "sceneGroup", "Scene Group", ref sceneAssetGroups, ref sceneGroupChoice);
                    DrawAddressablePrependOption("sceneAddressPrepend", scenePrependLabel);
                    helper.DrawSerializedPropertyField("sceneAddressAppend", sceneAppendLabel);

                    DrawSpace();
                    helper.DrawSerializedPropertyField("addLayerAsLabelToScenes", addLayerLabelsToScenesLabel);
                    helper.DrawSerializedPropertyField("addRowAsLabelToScenes", addRowLabelsToScenesLabel);
                    helper.DrawSerializedPropertyField("addColumnAsLabelToScenes", addColumnLabelsToScenesLabel);
                    DrawSpace();

                    helper.DrawSerializedPropertyArrayField("sceneLabels", sceneLabelsLabel);
                    //if (helper.GetPropertyByName("addScenesToBuildSettings").boolValue)
                    //    EditorGUILayout.HelpBox("Generally it is not necessary to add scenes to your build settings when also using them with the addressable system, so it is recommended to disable that option (however, it's up to you!).", MessageType.Warning);
                    EditorGUI.indentLevel--;
                }
            }
#endif
        }

        void DrawRelativeFolderOption(string folderPropertyName, GUIContent folderLabel, string errorLabel)
        {
            var folderProperty = helper.GetPropertyByName(folderPropertyName);
            string oldSceneSaveFolder = folderProperty.stringValue;
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(folderLabel);
            bool buttonPressed = DrawCopyRelativeFolderButton(copyFolderLabel, folderPropertyName);
            EditorGUILayout.EndHorizontal();

            EditorGUI.BeginChangeCheck();
            EditorGUILayout.DelayedTextField(folderProperty, GUIContent.none);
            bool folderValueChanged = EditorGUI.EndChangeCheck();

            if (buttonPressed || folderValueChanged)
            {
                if (!folderProperty.stringValue.StartsWith("/"))
                {
                    EditorUtility.DisplayDialog("Incorrect File Path", $"The {errorLabel} specified is not in the correct format. Please enter a valid format that begins with '/'. Note that this path is relative to the Assets folder, so a value of only '/' points to the root Assets folder.", "Ok");
                    folderProperty.stringValue = oldSceneSaveFolder;
                }
            }
        }

#if ENABLE_ADDRESSABLES
        void DrawGroupChoice(string settingsPropertyName, string groupSelectionPropertyName, string label, ref string[] groupOptions, ref int groupChoice)
        {
            int newChoice = EditorGUILayout.Popup(label, groupChoice, groupOptions);
            if (newChoice != groupChoice)
            {
                groupChoice = newChoice;
                var settings = GetSettingsFromProperty(settingsPropertyName);
                if (groupChoice >= settings.groups.Count)
                {
                    //this indicates we have an invalid options array
                    UpdateAddressableGroupOptions(settingsPropertyName, groupSelectionPropertyName, false, ref groupOptions, ref groupChoice);
                    groupChoice = settings.groups.Count - 1;
                }
                helper.GetPropertyByName(groupSelectionPropertyName).objectReferenceValue = settings.groups[groupChoice];
            }
        }

        void UpdateAddressableGroupOptions(string settingsPropertyName, string groupSelectionPropertyName, bool validateGroupChoice, ref string[] groupOptions, ref int groupChoice)
        {
            var settings = GetSettingsFromProperty(settingsPropertyName);
            if (settings == null)
                return;

            if (groupOptions == null)
                groupOptions = new string[settings.groups.Count];
            else if (groupOptions.Length != settings.groups.Count)
                Array.Resize(ref groupOptions, settings.groups.Count);

            for (int i = 0; i < groupOptions.Length; i++)
                groupOptions[i] = settings.groups[i].Name;

            //now make sure the selected group is valid, and get its index
            if (!validateGroupChoice)
                return;

            SerializedProperty groupProp = helper.GetPropertyByName(groupSelectionPropertyName);
            AddressableAssetGroup selectedGroup = groupProp.objectReferenceValue as AddressableAssetGroup;
            if (selectedGroup != null)
            {
                string groupName = selectedGroup.Name;
                for (int i = 0; i < groupOptions.Length; i++)
                {
                    if (groupOptions[i].Equals(groupName))
                    {
                        groupChoice = i;
                        return;
                    }
                }
            }

            groupChoice = 0;
            groupProp.objectReferenceValue = settings.groups[0];
        }
        AddressableAssetSettings GetSettingsFromProperty(string settingsPropertyName)
        {
            AddressableAssetSettings settings = helper.GetPropertyByName(settingsPropertyName).objectReferenceValue as AddressableAssetSettings;
            if (settings == null)
                settings = AddressableAssetSettingsDefaultObject.Settings;

            return settings;
        }
        void DrawAddressablePrependOption(string prependPropertyName, GUIContent label)
        {
            var prependProperty = helper.GetPropertyByName(prependPropertyName);
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.LabelField(label);
            if (DrawCopyAbsoluteFolderButton(copyFolderLabel, prependPropertyName))
            {
                prependProperty.stringValue = prependProperty.stringValue + "/";
            }
            EditorGUILayout.EndHorizontal();
            EditorGUILayout.DelayedTextField(prependProperty, GUIContent.none);
        }
#endif
        #region GUIContent

        readonly GUIContent addToBuildSettingsLabel = new GUIContent("Add To Build Settings*", "Add To Build Settings\n\nIf enabled, when Create Assets For Cell Chunk is called, the scene asset that is created will automatically be added to the build settings.");

        readonly GUIContent assetCreationModeLabel = new GUIContent("Asset Creation Mode*", "Asset Creation Mode\n\nThe type of assets that the creator will create. You can chose to create only prefabs, only scenes, or both prefabs and scenes.\n\nIf you choose Only Scenes, a scene will be generated with a game object whose activated/deactivated state that matches the Root State setting found on the Streamable Grid/LOD Group that the scene is being created for (with the same name as the scene).\n\nIf you choose Only Prefabs, an activated prefab will be generated\n\nWhen Prefabs And Scenes is chosen, both a prefab asset (in an activated state) and a scene containing that prefab (with state matching Root State) will be created. You can make the spawned prefab in the scene an instance of the generated prefab asset or make it disconnected from the prefab asset.\n\nThe actual game object prefab created, or object in the scene that is created, is based on the Chunk Prefabs found in a matching Template for each Asset Chunk. If no Template can be matched, or the Chunk Prefab in the Template for the Asset Chunk's Chunk Number is null, an empty game object will be used.");

        readonly GUIContent copyFolderLabel = new GUIContent("Copy Selected Folder*", "Copies the folder you have selected in the left Project Hierarchy pane to the field below.");

        readonly GUIContent forceEndInsertLabel = new GUIContent("Add Scene To End of Build Settings*", "Add Scene To End of Build Settings\n\nIf enabled, the new scene created for each call to CreateAssetsForCellChunk will be added to the end of the Build Settings list of scenes.\n\nIf disabled, the creator will attempt to add the scene within the same group of related assets, however note that this will force all scenes after its insert point to have their scene build index incremented by 1.\n\nIf you are loading scenes by scene build index, the change in scene build indexes may result in issues!");

        readonly GUIContent primaryAssetsLabel = new GUIContent("Primary Assets*", "Primary Assets\n\nWhen creating both prefabs and scenes, the Creator needs to know which of the two are the primary assets. The primary assets are the ones that are going to be immediately used by the World Designer Tool/Asset Manager after the Creator creates the assets for the chunk.\n\nThis information is used when creating test assets for the Tool, which is done to ensure the Creator has been configured correctly to work with whatever Chunk Streamer/Asset Manager will be used to manage the asset chunks.\n\nTo determine the Primary Assets, check which kind of Chunk Streamer will be used at runtime to load and unload the LOD Groups asset chunks. If it's a scene based Chunk Streamer, choose Scenes, but if it's a Prefab based Chunk Streamer, set this value to Prefabs.\n\nNote that if using scene based assets and you have 'Edit Prefab Roots When Possible' enabled, you would still select Scenes as the Primary Assets!");

        readonly GUIContent chunkTemplatesLabel = new GUIContent("Chunk Templates*", "Chunk Templates\n\nChunk Templates to use to create new assets.\n\nAll fields but the Chunk Prefabs array are optional. When an optional field is specified (Zone Name for instance), the template will only be used if the Asset Chunk being created matches the data. You can specify any combination of optional fields. If an Asset Chunk matches with multiple Templates, priority is given to the Template matching more data points. Further 'ties' are broken in favor of a matching Grouping Name first, then Zone Name, then LOD Group.\n\nIf the LOD Group using this Asset Creator does not utilize multi chunking, or if you would like all chunks to use the same prefab template, you only need to assign a single prefab to the Chunk Prefabs array.\n\nHowever, if you wish for each chunk to use a different prefab, you can assign as many as you'd like and the prefab whose chunk number mathes the array index will be used (Chunk 1 matches to array index 0, 2 matches 1, and so on). The final chunk template is always used if a Chunk Prefab does not exist that matches the input Chunk Number.\n\nEach new prefab asset that is created will be an exact replica of the template used (but with a different name).\n\nIf you leave an index null in the Chunk Prefabs array, when an asset is created for a chunk with the same number as the null field, an empty game object will be created for the asset.");

        readonly GUIContent prefabSaveFolderLabel = new GUIContent("Root Prefab Save Folder*", "Root Prefab Save Folder\n\nThe root location, relative to the Assets folder, to use for prefab asset creation. If one of the 'Output To Zone/Grouping/LOD Group Specific Sub Folder' options IS NOT enabled, the prefab assets will be placed directly in this root folder. If one of those options IS ENABLED, the prefabs will not be placed inside this folder; instead they will be placed in one or more sub folders which are children of this root folder.\n\n'/' will use the Assets folder as the root, while something like '/Prefabs' would use the Assets/Prefabs folder as the root.\n\nThe folder and any required subfolders are created automatically if they don't already exist.");

        readonly GUIContent sceneSaveFolderLabel = new GUIContent("Root Scene Save Folder*", "Root Scene Save Folder\n\nThe root location, relative to the Assets folder, to use for scene asset creation. If one of the 'Output To Zone/Grouping/LOD Group Specific Sub Folder' options IS NOT enabled, the scene assets will be placed directly in this root folder. If one of those options IS ENABLED, the scenes will not be placed inside this folder; instead they will be placed in one or more sub folders which are children of this root folder.\n\n'/' will use the Assets folder as the root, while something like '/Scenes' would use the Assets/Scenes folder as the root.\n\nThe folder and any required subfolders are created automatically if they don't already exist.");

        readonly GUIContent outputZoneSubFolderLabel1 = new GUIContent("Output To Zone", "Output To Zone Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the Zone the Asset Chunk belongs to (as set on your World component).\n\nThe Zone sub folder is always placed directly under the root folder.");

        readonly GUIContent outputZoneSubFolderLabel2 = new GUIContent("Specific Sub Folder*", "Output To Zone Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the Zone the Asset Chunk belongs to (as set on your World component).\n\nThe Zone sub folder is always placed directly under the root folder.");

        readonly GUIContent outputGroupingSubFolderLabel1 = new GUIContent("Output To Grouping", "Output To Grouping Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the World Grouping the Asset Chunk belongs to (as set on your World component).\n\nThe Grouping sub folder is always placed directly under the Zone specific sub folder if 'Output To Zone Specific Sub Folder' is enabled, or directly under the root folder if that option is disabled.");

        readonly GUIContent outputGroupingSubFolderLabel2 = new GUIContent("Specific Sub Folder", "Output To Grouping Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the World Grouping the Asset Chunk belongs to (as set on your World component).\n\nThe Grouping sub folder is always placed directly under the Zone specific sub folder if 'Output To Zone Specific Sub Folder' is enabled, or directly under the root folder if that option is disabled.");

        readonly GUIContent outputLODGroupSubFolderLabel1 = new GUIContent("Output To LOD Group", "Output To LOD Group Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the LOD Group the Asset Chunk belongs to (as set on your Streamable Grid).\n\nThe LOD Group sub folder is always placed directly under the Grouping specific sub folder if 'Output To Grouping Specific Sub Folder' is enabled, or directly under the Zone sub folder if that option is disabled but 'Output To Zone Specific Sub Folder' is enabled. If both of those options are disabled, it is placed directly under the root folder.");

        readonly GUIContent outputLODGroupSubFolderLabel2 = new GUIContent("Specific Sub Folder", "Output To LOD Group Specific Sub Folder\n\nIf enabled, Asset Chunks will be generated in a sub folder of the root prefab/scene save folder which is named after the LOD Group the Asset Chunk belongs to (as set on your Streamable Grid).\n\nThe LOD Group sub folder is always placed directly under the Grouping specific sub folder if 'Output To Grouping Specific Sub Folder' is enabled, or directly under the Zone sub folder if that option is disabled but 'Output To Zone Specific Sub Folder' is enabled. If both of those options are disabled, it is placed directly under the root folder.");

        readonly GUIContent spawnPrefabAsInstanceLabel1 = new GUIContent("Spawn Prefab In", "Spawn Prefab In Scene As Instance\n\nIf enabled, the prefab created when Create Assets For Cell Chunk is called will be added to the created scene as a prefab instance. Generally this is the recommended approach.");

        readonly GUIContent spawnPrefabAsInstanceLabel2 = new GUIContent("Scene As Instance*", "Spawn Prefab In Scene As Instance\n\nIf enabled, the prefab created when Create Assets For Cell Chunk is called will be added to the created scene as a prefab instance. Generally this is the recommended approach.");

        readonly GUIContent terrainDataSaveFolderLabel = new GUIContent("Terrain Data Save Folder*", "Terrain Data Save Folder\n\nOne or more Chunk Prefabs you have provided contain a Terrain component. When CreateAssetsForCellChunk is called and that Chunk Prefab is used, a new terrain will be created which is based on the chunk prefab, and a new TerrainData asset will be created. This controls where that data asset is saved.");

#if ENABLE_ADDRESSABLES
        readonly GUIContent addLayerLabelsToPrefabsLabel = new GUIContent("Add Layer Labels*", "Add Layer Labels\n\nIf enabled, will add a label called L# to each created Addressable Asset Chunk Prefab, where # is replaced by the layer of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.\n\nNote that even if you are using a Two Dimensional Streamable Grid, each cell still has a Layer value of 1. However, if you know FOR SURE that you will never use a Three Dimensional Streamable Grid, and thus EVERY cell will have a layer value of 1, adding the Layer Label will just add unecessary data to your addressable builds!");

        readonly GUIContent addRowLabelsToPrefabsLabel = new GUIContent("Add Row Labels*", "Add Row Labels\n\nIf enabled, will add a label called R# to each Addressable Asset Chunk Prefab, where # is replaced by the row of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.");

        readonly GUIContent addColumnLabelsToPrefabsLabel = new GUIContent("Add Column Labels*", "Add Column Labels\n\nIf enabled, will add a label called C# to each Addressable Asset Chunk Prefab, where # is replaced by the column of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.");

        readonly GUIContent addLayerLabelsToScenesLabel = new GUIContent("Add Layer Labels*", "Add Layer Labels\n\nIf enabled, will add a label called L# to each created Addressable Asset Chunk Scene, where # is replaced by the layer of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.\n\nNote that even if you are using a Two Dimensional Streamable Grid, each cell still has a Layer value of 1. However, if you know FOR SURE that you will never use a Three Dimensional Streamable Grid, and thus EVERY cell will have a layer value of 1, adding the Layer Label will just add unecessary data to your addressable builds!");

        readonly GUIContent addRowLabelsToScenesLabel = new GUIContent("Add Row Labels*", "Add Row Labels\n\nIf enabled, will add a label called R# to each Addressable Asset Chunk Scene, where # is replaced by the row of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.");

        readonly GUIContent addColumnLabelsToScenesLabel = new GUIContent("Add Column Labels*", "Add Column Labels\n\nIf enabled, will add a label called C# to each Addressable Asset Chunk Scene, where # is replaced by the column of the Cell the Asset Chunk belongs to.\n\nThis can be useful for organizing asset chunks into groups for use with the Pack Together By Label packing strategy.");

        readonly GUIContent makePrefabsAddressableLabel = new GUIContent("Make Prefabs Addressable*", "Make Prefabs Addressable\n\nIf enabled, each prefab asset that is generated will be marked as addressable.");

        readonly GUIContent prefabSettingsLabel = new GUIContent("Addressable Settings*", "Addressable Settings\n\nThe settings object with the group you want to add the prefab assets to. If you leave it null, the Default Settings object will be used.");

        readonly GUIContent prefabPrependLabel = new GUIContent("Address Prepend String*", "Address Prepend String\n\nA string of text that will be prepended to the address of each prefab asset created with this Asset Creator. Usually this is the folder that the prefab assets are in, in the form of 'Assets/Folder/SubFolder/.../.\n\nThis is only necessary when using multiple addressable assets with the same name.\n\nYou must ensure this string matches what's exepcted by your Addressable Prefab Loader!");

        readonly GUIContent prefabAppendLabel = new GUIContent("Address Append String*", "Address Prepend String\n\nA string of text that will be appended to the end of the address of each prefab asset created with this Asset Creator. For prefabs, this will typically be '.prefab' however you are free to use another string if you desire, or no string.\n\nYou must ensure this string matches what's exepcted by your Addressable Prefab Loader!");

        readonly GUIContent prefabLabelsLabel = new GUIContent("Prefab Labels To Add*", "Prefab Labels To Add\n\nLabels which can be added to each prefab asset created. If a label does not exist, it will be added.");

        readonly GUIContent makeScenesAddressableLabel = new GUIContent("Make Scenes Addressable*", "Make Scenes Addressable\n\nIf enabled, each scene asset that is generated will be marked as addressable.");

        readonly GUIContent sceneSettingsLabel = new GUIContent("Addressable Settings*", "Addressable Settings\n\nThe settings object with the group you want to add the scene assets to. If you leave it null, the Default Settings object will be used.");

        readonly GUIContent scenePrependLabel = new GUIContent("Address Prepend String*", "Address Prepend String\n\nA string of text that will be prepended to the address of each scene asset created with this Asset Creator. Usually this is the folder that the scene assets are in, in the form of 'Assets/Folder/SubFolder/.../.\n\nThis is only necessary when using multiple addressable assets with the same name.\n\nYou must ensure this string matches what's exepcted by your Addressable Scene Loader!");

        readonly GUIContent sceneAppendLabel = new GUIContent("Address Append String*", "Address Prepend String\n\nA string of text that will be appended to the end of the address of each scene asset created with this Asset Creator. For scenes, this will typically be '.unity' however you are free to use another string if you desire, or no string.\n\nYou must ensure this string matches what's exepcted by your Addressable Scene Loader!");

        readonly GUIContent sceneLabelsLabel = new GUIContent("Scene Labels To Add*", "Scene Labels To Add\n\nLabels which can be added to each scene asset created. If a label does not exist, it will be added.");


#endif

        #endregion
    }
}