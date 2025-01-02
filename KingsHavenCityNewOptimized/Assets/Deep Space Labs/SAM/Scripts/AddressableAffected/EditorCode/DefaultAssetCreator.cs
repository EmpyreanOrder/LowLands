//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using UnityEngine;
    using UnityEditor;
    using DeepSpaceLabs.EditorCore;
    using DeepSpaceLabs.SAM;
    using UnityEngine.SceneManagement;
    using UnityEditor.SceneManagement;
    using System.Collections.Generic;
    using Unity.Collections;
    using System.Threading.Tasks;
    using System.IO;

#if ENABLE_ADDRESSABLES
    using UnityEditor.AddressableAssets.Settings;
    using UnityEditor.AddressableAssets;
#endif

    [HelpURL(GlobalValues.API_URL + "AssetCreator.html")]
    public sealed class DefaultAssetCreator : AssetCreator
    {
        internal enum AssetCreationMode { Only_Prefabs, Only_Scenes, Prefabs_And_Scenes }
        internal enum PrimaryAssets { Prefabs, Scenes }

        //tracks most up to date version
        public const int CURRENT_VERSION = 2;

        [SerializeField]
        int version = 1;//current version of the scriptable asset

        [SerializeField]
        AssetCreationMode assetCreationMode = AssetCreationMode.Prefabs_And_Scenes;

        [SerializeField]
        PrimaryAssets primaryAssets = PrimaryAssets.Prefabs;

        //redundant with version 2
        [SerializeField]
        GameObject[] prefabChunkTemplates;

        [SerializeField]
        string prefabSaveFolder = "/", sceneSaveFolder = "/", terrainDataSaveFolder = "/";

#pragma warning disable 0414
        [SerializeField]
        bool addScenesToBuildSettings = true, spawnPrefabAsInstanceInScene = true, forceEndInsert = false, prefabSectionDropdown = true, sceneSectionDropdown = true, outputToZoneSpecificSubFolder = true, outputToGroupingSpecificSubFolder = true, outputToLODGroupSpecificSubFolder = true;
#pragma warning restore 0414

#if ENABLE_ADDRESSABLES
        [SerializeField]
        bool makePrefabsAddressable, makeScenesAddressable, addLayerAsLabelToPrefabs = true, addRowAsLabelToPrefabs = true, addColumnAsLabelToPrefabs = true, addLayerAsLabelToScenes = true, addRowAsLabelToScenes = true, addColumnAsLabelToScenes = true;

        [SerializeField]
        string prefabAddressPrepend = "", prefabAddressAppend = ".prefab", sceneAddressPrepend = "", sceneAddressAppend = ".unity";

#pragma warning disable 0649
        [SerializeField]
        AddressableAssetSettings prefabSettings, sceneSettings;
#pragma warning restore 0649

        [SerializeField]
        AddressableAssetGroup prefabGroup, sceneGroup;

        [SerializeField]
        string[] prefabLabels, sceneLabels;

        List<ChunkInfo> chunkInfoForScenes;
#endif

        //version 2 additions
        [SerializeField]
        Template[] templates;

        //batch editing stuff
        List<EditorBuildSettingsScene> scenes;
        List<string> prefabsPathsForScenes;//batchCreatedNewScenes;
        //bool batchEditInProgress = false;
        AlphanumComparatorFast sorter;
        string batchPrefabFolder, batchSceneFolder;

        public sealed override bool CanUseWithBatchAssetEditing(LODGroupInfo lodGroupInfo)
        {
            return true;
        }
        public sealed override void StartingBatchEditing(LODGroupInfo lodGroupInfo)
        {
            //batchEditInProgress = true;

            //if we are only editing scenes, there is nothing to do before the batch edit
            if (assetCreationMode == AssetCreationMode.Only_Prefabs)
            {
                batchPrefabFolder = GetFinalFolderSavePath(prefabSaveFolder, lodGroupInfo.ZoneName, lodGroupInfo.GroupingName, lodGroupInfo.LODGroupName);
                return;
            }
            else if (assetCreationMode == AssetCreationMode.Only_Scenes)
                batchSceneFolder = GetFinalFolderSavePath(sceneSaveFolder, lodGroupInfo.ZoneName, lodGroupInfo.GroupingName, lodGroupInfo.LODGroupName);
            else
            {
                batchPrefabFolder = GetFinalFolderSavePath(prefabSaveFolder, lodGroupInfo.ZoneName, lodGroupInfo.GroupingName, lodGroupInfo.LODGroupName);
                batchSceneFolder = GetFinalFolderSavePath(sceneSaveFolder, lodGroupInfo.ZoneName, lodGroupInfo.GroupingName, lodGroupInfo.LODGroupName);
            }

            if (!CoreHelper.EnsureUntitledSceneHasBeenSaved($"The Asset Creator named {name} is attempting to create new scenes, however there is an unsaved/untitled scene currently open that needs to be saved in order for the new scenes to be created. You can choose to save this scene now, or if you choose 'Cancel' the scene will be auto saved at path {AssetManager.ScenePath}."))
                CoreHelper.SaveUntitledSceneAtPath(AssetManager.ScenePath);

            if (assetCreationMode == AssetCreationMode.Prefabs_And_Scenes)
            {
                prefabsPathsForScenes = new List<string>();

#if ENABLE_ADDRESSABLES
                if (makeScenesAddressable)
                    chunkInfoForScenes = new List<ChunkInfo>();
#endif
            }

            //if (assetCreationMode != AssetCreationMode.Only_Prefabs && batchCreatedNewScenes == null)
            //    batchCreatedNewScenes = new List<string>();

            if (addScenesToBuildSettings)
            {
                CleanupBuildSettingRemovedScenes();
                StoreEditorScenes();
            }
        }
        public sealed override void BatchEditingStopped(LODGroupInfo lodGroupInfo)
        {
            if (assetCreationMode == AssetCreationMode.Prefabs_And_Scenes && prefabsPathsForScenes.Count > 0)
            {
                try
                {
                    AssetDatabase.StartAssetEditing();
                    for (int i = 0; i < prefabsPathsForScenes.Count; i++)
                    {
                        GameObject prefab = AssetDatabase.LoadAssetAtPath<GameObject>(prefabsPathsForScenes[i]);
                        string chunkName = prefab.name;

                        if (!CreateSceneFromPrefabAsset(chunkName, prefab, prefab.transform.position, lodGroupInfo.StoredRootState, spawnPrefabAsInstanceInScene, out string fullFilePathOfScene))
                        {
                            Debug.LogError($"Could not create scene asset for {chunkName} using the Default Asset Creator called {name}.");
                        }
                        else
                        {
#if ENABLE_ADDRESSABLES
                            if (makeScenesAddressable)
                            {
                                MakeAssetAddressable(sceneSettings, sceneGroup, sceneLabels, fullFilePathOfScene, chunkName, sceneAddressPrepend, sceneAddressAppend, chunkInfoForScenes[i], addLayerAsLabelToScenes, addRowAsLabelToScenes, addColumnAsLabelToScenes);
                            }
#endif
                            if (addScenesToBuildSettings)
                                AddSceneToBuildSettings(chunkName, fullFilePathOfScene);
                        }
                    }
                }
                finally
                {
                    AssetDatabase.StopAssetEditing();
                    prefabsPathsForScenes.Clear();

#if ENABLE_ADDRESSABLES
                    chunkInfoForScenes.Clear();
#endif
                }
            }

            if (scenes != null && scenes.Count > 0)
            {
                if (addScenesToBuildSettings)
                    EditorBuildSettings.scenes = scenes.ToArray();

                scenes.Clear();
            }
        }
        public sealed override void CreateAssetsForCellChunk(ChunkInfo chunkInfo)
        {
            if (sorter == null)
                sorter = AlphanumComparatorFast.Instance;

            if (DoPreCreateErrorsExist(chunkInfo))
                return;

            bool createPrefabs = assetCreationMode == AssetCreationMode.Only_Prefabs
                || (assetCreationMode == AssetCreationMode.Prefabs_And_Scenes && (!chunkInfo.isTestChunk || primaryAssets == PrimaryAssets.Prefabs));

            bool createScenes = assetCreationMode == AssetCreationMode.Only_Scenes
                || (assetCreationMode == AssetCreationMode.Prefabs_And_Scenes && (!chunkInfo.isTestChunk || primaryAssets == PrimaryAssets.Scenes));

            GameObject chunkTemplate = GetPrefabTemplateForChunk(chunkInfo);
            if (createPrefabs)
            {
                if (!CreatePrefab(chunkTemplate, chunkInfo.chunkName, (Vector3)chunkInfo.chunkPosition, out string fullFilePathOfPrefab))
                {
                    if (assetCreationMode == AssetCreationMode.Prefabs_And_Scenes)
                        Debug.LogError($"Could not create prefab asset for {chunkInfo.chunkName} using Default Asset Creator called {name}. The scene asset will also not be created until the issues preventing the prefab asset creation can be fixed.");
                    else
                        Debug.LogError($"Could not create prefab asset for {chunkInfo.chunkName} using Default Asset Creator called {name}.");

                    return;
                }
                else//prefab creation was successful
                {
                    if (createScenes)
                    {
                        prefabsPathsForScenes.Add(fullFilePathOfPrefab);

#if ENABLE_ADDRESSABLES
                        if (makePrefabsAddressable)
                            chunkInfoForScenes.Add(chunkInfo);
                    }

                    if (makePrefabsAddressable)
                    {
                        MakeAssetAddressable(prefabSettings, prefabGroup, prefabLabels, fullFilePathOfPrefab, chunkInfo.chunkName, prefabAddressPrepend, prefabAddressAppend, chunkInfo, addLayerAsLabelToPrefabs, addRowAsLabelToPrefabs, addColumnAsLabelToPrefabs);
                    }
#else
                    }
#endif
                }
            }

            //make the scene asset only if create prefabs is disabled, otherwise the scene will be created after batch editing ends
            if (createScenes && !createPrefabs)
            {
                bool sceneCreationSuccessfull;
                string fullFilePathOfScene;

                //since the chunk template is not an Asset Chunk itself, we will not make the spawned instance an instance of the prefab!
                if (chunkTemplate != null)
                    sceneCreationSuccessfull = CreateSceneFromPrefabAsset(chunkInfo.chunkName, chunkTemplate, (Vector3)chunkInfo.chunkPosition, chunkInfo.storedRootState, false, out fullFilePathOfScene);
                else
                    sceneCreationSuccessfull = CreateSceneWithEmptyObject(chunkInfo.chunkName, (Vector3)chunkInfo.chunkPosition, chunkInfo.storedRootState, out fullFilePathOfScene);

                if (!sceneCreationSuccessfull)
                {
                    Debug.LogError($"Could not create scene asset for {chunkInfo.chunkName} using the Default Asset Creator called {name}.");
                    return;
                }
                else//scene creation was successful
                {
#if ENABLE_ADDRESSABLES
                    if (makeScenesAddressable)
                    {
                        MakeAssetAddressable(sceneSettings, sceneGroup, sceneLabels, fullFilePathOfScene, chunkInfo.chunkName, sceneAddressPrepend, sceneAddressAppend, chunkInfo, addLayerAsLabelToScenes, addRowAsLabelToScenes, addColumnAsLabelToScenes);
                    }
#endif
                    if (addScenesToBuildSettings)
                        AddSceneToBuildSettings(chunkInfo.chunkName, fullFilePathOfScene);
                }
            }
        }

        bool DoPreCreateErrorsExist(ChunkInfo chunkInfo)
        {
            bool errorsExist = false;
#if ENABLE_ADDRESSABLES
            bool issueWithPrefabAddressableSettings = false;
            if (assetCreationMode != AssetCreationMode.Only_Scenes && makePrefabsAddressable)
                issueWithPrefabAddressableSettings = !VerifyAddressableSettings(prefabSettings, prefabGroup, "Prefab", chunkInfo.chunkName);

            bool issueWithSceneAddressableSettings = false;
            if (assetCreationMode != AssetCreationMode.Only_Prefabs && makeScenesAddressable)
                issueWithSceneAddressableSettings = !VerifyAddressableSettings(sceneSettings, sceneGroup, "Scene", chunkInfo.chunkName);

            if (issueWithPrefabAddressableSettings)
            {
                if (issueWithSceneAddressableSettings)
                    Debug.LogError($"Could not create assets for {chunkInfo.chunkName} using Default Asset Creator called {name} becuase there are issues with both the Prefab and Scene Addressable Settings.");
                else
                    Debug.LogError($"Could not create assets for {chunkInfo.chunkName} using Default Asset Creator called {name} becuase there are issues with the Prefab Addressable Settings.");
            }
            else if (issueWithSceneAddressableSettings)
                Debug.LogError($"Could not create assets for {chunkInfo.chunkName} using Default Asset Creator called {name} becuase there are issues with the Scene Addressable Settings.");

            if (issueWithPrefabAddressableSettings || issueWithSceneAddressableSettings)
                errorsExist = true;
#endif

            if (assetCreationMode != AssetCreationMode.Only_Prefabs)
            {
                if (SceneManager.GetSceneByName(chunkInfo.chunkName).IsValid())
                {
                    Debug.LogError($"Could not create any assets for {chunkInfo.chunkName} because a scene with that name is currently open. Close the scene and retry to recreate the asset.");
                    errorsExist = true;
                }

#if UNITY_2021_2_OR_NEWER
                var stage = PrefabStageUtility.GetCurrentPrefabStage();
#else
                var stage = UnityEditor.Experimental.SceneManagement.PrefabStageUtility.GetCurrentPrefabStage();
#endif
                if (stage != null)
                {
                    Debug.LogError($"Could not create any assets for {chunkInfo.chunkName} because a prefab instance is currently being edited. Scenes cannot be created while a prefab instance is being edited. Close the prefab editor scene and retry the operation again.");
                    errorsExist = true;
                }
            }

            return errorsExist;
        }

        List<Template> possibleTemplates = new List<Template>();
        GameObject GetPrefabTemplateForChunk(ChunkInfo chunkInfo)
        {
            GameObject[] templates = GetPrefabTemplatesToUse(chunkInfo);
            if (templates == null || templates.Length == 0)
                return null;
            else
            {
                int templateIndex = chunkInfo.LOD - 1;
                if (templateIndex < 0)
                    templateIndex = 0;
                else if (templateIndex >= templates.Length)
                    templateIndex = templates.Length - 1;

                return templates[templateIndex];
            }
        }
        GameObject[] GetPrefabTemplatesToUse(ChunkInfo chunkInfo)
        {
            if (version == 1)
            {
                if (prefabChunkTemplates != null && prefabChunkTemplates.Length > 0)
                {
                    return prefabChunkTemplates;
                }
            }
            else
            {
                if (templates != null && templates.Length >= 0)
                {
                    possibleTemplates.AddRange(templates);
                    //first round tries to match zone, grouping, and LOD
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.groupingName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if(!string.Equals(template.groupingName, chunkInfo.groupingName))
                        {
                            //template cannot be applied to this asset chunk, since the group name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        if (template.zoneName.IsNullOrWhiteSpace())
                            continue;
                        else if(!string.Equals(template.zoneName, chunkInfo.zoneName))
                        {
                            //template cannot be applied to this asset chunk, since the zone name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        if (template.lodGroups == null || template.lodGroups.Length == 0)//skip template without LOD specifications
                            continue;

                        for (int lod = 0; lod < template.lodGroups.Length; lod++)
                        {
                            if (template.lodGroups[lod] == chunkInfo.LOD)
                                return template.chunkPrefabs;
                        }

                        //if the template contains LOD specifications, but none match this asset chunk, remove the template since 
                        //it cannot be applied to this asset chunk at all
                        possibleTemplates.RemoveAt(i);
                    }

                    //second round tries to match zone and grouping
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.groupingName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if (!string.Equals(template.groupingName, chunkInfo.groupingName))
                        {
                            //template cannot be applied to this asset chunk, since the group name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        if (template.zoneName.IsNullOrWhiteSpace())
                            continue;
                        else if (!string.Equals(template.zoneName, chunkInfo.zoneName))
                        {
                            //template cannot be applied to this asset chunk, since the zone name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        //any template with matching LODs would already have been found in round 1.
                        //so if the template has LODs, they cannot be matches! in this case, we can remove the template as a possible match (else statement)
                        if (template.lodGroups == null || template.lodGroups.Length == 0)//skip template without LOD specifications
                            return template.chunkPrefabs;
                        else
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                    }

                    //third round tries to match grouping and LOD
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.lodGroups == null || template.lodGroups.Length == 0)
                            continue;

                        if (template.groupingName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if (!string.Equals(template.groupingName, chunkInfo.groupingName))
                        {
                            //template cannot be applied to this asset chunk, since the group name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        for (int lod = 0; lod < template.lodGroups.Length; lod++)
                        {
                            if (template.lodGroups[lod] == chunkInfo.LOD)
                            {
                                if (!template.zoneName.IsNullOrWhiteSpace())
                                    break;
                                else
                                    return template.chunkPrefabs;
                            }
                        }

                        possibleTemplates.RemoveAt(i);//remove to reduce workload later
                    }

                    //fourth round tries to match zone and LOD
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.lodGroups == null || template.lodGroups.Length == 0)
                            continue;

                        if (template.zoneName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if (!string.Equals(template.zoneName, chunkInfo.zoneName))
                        {
                            //template cannot be applied to this asset chunk, since the group name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        for (int lod = 0; lod < template.lodGroups.Length; lod++)
                        {
                            if (template.lodGroups[lod] == chunkInfo.LOD)
                            {
                                if (!template.groupingName.IsNullOrWhiteSpace())
                                    break;
                                else
                                    return template.chunkPrefabs;
                            }
                        }

                        possibleTemplates.RemoveAt(i);//remove to reduce workload later
                    }

                    //fifth round tries to match grouping
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.groupingName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if (!string.Equals(template.groupingName, chunkInfo.groupingName))
                        {
                            //template cannot be applied to this asset chunk, since the group name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        //if the template has a Zone Name specified, it cannot be a match to this chunk, since it would have been 
                        //matched in round 2. Similarly, if the template has LODs specified, it also cannot be a match (would have been found in round 1)

                        if (template.zoneName.IsNullOrWhiteSpace() && (template.lodGroups == null || template.lodGroups.Length == 0))
                            return template.chunkPrefabs;
                        else
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                    }

                    //sixth round tries to match zone
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if (template.zoneName.IsNullOrWhiteSpace())
                            continue;//if template group name is empty, it's not a match, but it might be a match down the road
                        else if (!string.Equals(template.zoneName, chunkInfo.zoneName))
                        {
                            //template cannot be applied to this asset chunk, since the zoneName name is different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        //if the template has a Grouping Name specified, it cannot be a match to this chunk, since it would have been 
                        //matched in round 3. Similarly, if the template has LODs specified, it also cannot be a match (would have been found in round 1)

                        if (template.groupingName.IsNullOrWhiteSpace() && (template.lodGroups == null || template.lodGroups.Length == 0))
                            return template.chunkPrefabs;
                        else
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                    }

                    //seventh round tries to match LOD only
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if(template.lodGroups == null || template.lodGroups.Length == 0) 
                            continue;

                        if (!template.zoneName.IsNullOrWhiteSpace())
                        {
                            //template cannot be applied to this asset chunk, since the zoneName must be different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        if (!template.groupingName.IsNullOrWhiteSpace())
                        {
                            //template cannot be applied to this asset chunk, since the groupingName must be different.
                            possibleTemplates.RemoveAt(i);//remove to reduce workload later
                            continue;
                        }

                        for (int lod = 0; lod < template.lodGroups.Length; lod++)
                        {
                            if (template.lodGroups[lod] == chunkInfo.LOD)
                                return template.chunkPrefabs;
                        }

                        //template had LODs that did not match, so we can remove the template
                        possibleTemplates.RemoveAt(i);
                    }

                    //eight and final round looks for a template without any specifications
                    for (int i = possibleTemplates.Count - 1; i > -1; i--)
                    {
                        var template = possibleTemplates[i];

                        if ((template.lodGroups == null || template.lodGroups.Length == 0) 
                            && template.zoneName.IsNullOrWhiteSpace() 
                            && template.groupingName.IsNullOrWhiteSpace()) return template.chunkPrefabs;
                    }
                }
            }

            return null;
        }

        bool CreatePrefab(GameObject prefabTemplate, string assetName, Vector3 position, out string fullFilePathOfPrefab)
        {
            fullFilePathOfPrefab = batchPrefabFolder + assetName + ".prefab";

            if (prefabTemplate != null)
                return DuplicatePrefabAsset(prefabTemplate, assetName, position, fullFilePathOfPrefab);
            else
                return CreateEmptyPrefab(assetName, position, fullFilePathOfPrefab);
        }

        //method currently changes the GUID if there is an existing asset. Look to overwrite prefab asset (which preserves the 
        //GUID) instead.
        bool DuplicatePrefabAsset(GameObject prefabTemplate, string duplicatePrefabName, Vector3 position, string fullFilePathOfDuplicatePrefab)
        {
            GameObject prefab;
            string pathOfPrefabToDuplicate = AssetDatabase.GetAssetPath(prefabTemplate);
            if (prefabTemplate.GetComponent<Terrain>() != null)
            {
                string fullFilePathOfDuplicatePrefabTerrainData = terrainDataSaveFolder;
                fullFilePathOfDuplicatePrefabTerrainData = EnsureFolderExist(fullFilePathOfDuplicatePrefabTerrainData);
                fullFilePathOfDuplicatePrefabTerrainData += duplicatePrefabName + "_Terrain_Data.asset";

                string pathOfPrefabToDuplicateTerrainData = AssetDatabase.GetAssetPath(prefabTemplate.GetComponent<Terrain>().terrainData);
                prefab = TerrainDuplication.DuplicatePrefabWithTerrain(pathOfPrefabToDuplicate, pathOfPrefabToDuplicateTerrainData, fullFilePathOfDuplicatePrefab, fullFilePathOfDuplicatePrefabTerrainData);

                if (prefab != null)
                {
                    if (!prefab.activeSelf)
                        prefab.SetActive(true);

                    prefab.transform.position = position;
                    prefab = PrefabUtility.SavePrefabAsset(prefab);
                }
            }
            else
            {
                CheckForObsoleteTerrainData(fullFilePathOfDuplicatePrefab);

                prefab = (GameObject)PrefabUtility.InstantiatePrefab(AssetDatabase.LoadAssetAtPath<GameObject>(pathOfPrefabToDuplicate));
                if (prefab != null)
                {
                    if (!prefab.activeSelf)
                        prefab.SetActive(true);

                    prefab.transform.position = position;
                    PrefabUtility.UnpackPrefabInstance(prefab, PrefabUnpackMode.OutermostRoot, InteractionMode.AutomatedAction);
                    PrefabUtility.SaveAsPrefabAssetAndConnect(prefab, fullFilePathOfDuplicatePrefab, InteractionMode.AutomatedAction);
                }
            }

            if (prefab != null)
            {
                if (prefab.scene.IsValid())
                {
                    Debug.Log("Prefab was in scene, destroying");
                    DestroyImmediate(prefab);
                }
                return true;
            }
            else
                return false;
        }

        bool CreateEmptyPrefab(string prefabName, Vector3 position, string fullFilePathOfEmptyPrefab)
        {
            CheckForObsoleteTerrainData(fullFilePathOfEmptyPrefab);

            GameObject prefab = new GameObject(prefabName);
            prefab.transform.position = position;
            PrefabUtility.SaveAsPrefabAssetAndConnect(prefab, fullFilePathOfEmptyPrefab, InteractionMode.AutomatedAction);
            DestroyImmediate(prefab);
            return true;
        }

        void CheckForObsoleteTerrainData(string prefabPath)
        {
            GameObject existingPrefab = AssetDatabase.LoadAssetAtPath<GameObject>(prefabPath);
            if (existingPrefab == null)
                return;

            Terrain t = existingPrefab.GetComponent<Terrain>();
            if (t == null)
                return;

            string dataPath = AssetDatabase.GetAssetPath(t.terrainData);
            if (EditorUtility.DisplayDialog("Cleanup Terrain Data", $"The Asset Creator {name} is about to replace the Terrain Prefab at {prefabPath}, which is currently using the Terrain Data asset at {dataPath}. The new Prefab it is being replaced with does not use Terrain, therefore it's possible the old Terrain Data at {dataPath} will not be associated with any Terrain (however, if you have other terrain using this asset, you can keep it!). Would you like for this asset to be removed?", "Remove Asset", "Keep Asset"))
                AssetDatabase.DeleteAsset(dataPath);
        }

        bool CreateSceneFromPrefabAsset(string assetName, GameObject prefabAsset, Vector3 position, bool storedRootState, bool spawnPrefabAsInstanceInScene, out string fullFilePathOfScene)
        {
            fullFilePathOfScene = batchSceneFolder + assetName + ".unity";
            //batchCreatedNewScenes.Add(fullFilePathOfScene);

            var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive);
            scene.name = assetName;
            GameObject placedObject;
            if (spawnPrefabAsInstanceInScene)
            {
                placedObject = (GameObject)PrefabUtility.InstantiatePrefab(prefabAsset, scene);
                placedObject.name = assetName;
            }
            else
            {
                placedObject = Instantiate(prefabAsset);
                placedObject.name = assetName;
                SceneManager.MoveGameObjectToScene(placedObject, scene);
            }

            if(!storedRootState)
                placedObject.SetActive(false);

            placedObject.transform.position = position;
            bool sceneCreated = EditorSceneManager.SaveScene(scene, fullFilePathOfScene);
            EditorSceneManager.CloseScene(scene, true);

            return sceneCreated;
        }

        bool CreateSceneWithEmptyObject(string sceneName, Vector3 position, bool storedRootState, out string fullFilePathOfScene)
        {
            fullFilePathOfScene = batchSceneFolder + sceneName + ".unity";
            //batchCreatedNewScenes.Add(fullFilePathOfScene);

            var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Additive);
            scene.name = sceneName;
            GameObject placedObject = new GameObject();
            placedObject.name = sceneName;
            SceneManager.MoveGameObjectToScene(placedObject, scene);
            
            if(!storedRootState)
                placedObject.SetActive(false);
            placedObject.transform.position = position;
            bool sceneCreated = EditorSceneManager.SaveScene(scene, fullFilePathOfScene);
            EditorSceneManager.CloseScene(scene, true);

            //if (!batchEditInProgress)
            //AssetDatabase.ImportAsset(fullFilePathOfScene);

            return sceneCreated;
        }

        void AddSceneToBuildSettings(string sceneName, string fullFilePathOfScene)
        {
            //note that sceneIndex is the build index, which may contain less values than the number of scenes in build settings (if build 
            //settings contains disabled scenes)
            int sceneIndex = SceneUtility.GetBuildIndexByScenePath(fullFilePathOfScene);
            if (sceneIndex != -1)//indicates the scene is already added to the build settings. Replace the scene in case it is invalid
            {
                for (int j = sceneIndex; j < scenes.Count; j++)
                {
                    if (scenes[j].path.Equals(fullFilePathOfScene))
                    {
                        scenes[j] = new EditorBuildSettingsScene(fullFilePathOfScene, true);
                        break;
                    }
                }
            }
            else
            {
                int i = 0;
                if (forceEndInsert)
                {
                    i = scenes.Count;
                }
                else
                {
                    //length of .unity = 6
                    var charsToTrim = (sceneName + ".unity").ToCharArray();

                    //say full path is Assets/Kyle/TheBest/something.asset
                    //charsInAssetName = 15
                    string justFolderPath = fullFilePathOfScene.TrimEnd(charsToTrim);

                    for (; i < scenes.Count; i++)
                    {
                        if (scenes[i].path.StartsWith(justFolderPath))
                        {
                            if (sorter.Compare(fullFilePathOfScene, scenes[i].path) < 0)
                                break;
                            else
                            {
                                i = GetInsertIndex(i + 1, justFolderPath, fullFilePathOfScene);
                                break;
                            }
                        }
                    }
                }

                var newBuildSettingScene = new EditorBuildSettingsScene(fullFilePathOfScene, true);

                if (i == scenes.Count)
                    scenes.Add(newBuildSettingScene);
                else
                    scenes.Insert(i, newBuildSettingScene);
            }
        }

        int GetInsertIndex(int startIndex, string sceneFolderPath, string fullFilePathOfScene)
        {
            int i = startIndex;
            for (; i < scenes.Count; i++)
            {
                if (!scenes[i].path.StartsWith(sceneFolderPath))
                    return i;//means the next scene is not part of the same group, so insert the new scene here at the end

                if (sorter.Compare(fullFilePathOfScene, scenes[i].path) < 0)
                    return i;
            }
            return i;
        }

        string EnsureFolderExist(string folder)
        {
            if (!folder.EndsWith("/"))
                folder += "/";

            string folderApplicationPath = Application.dataPath + folder;
            if (!folderApplicationPath.SystemPathExists())
                folder = folderApplicationPath.CreateUnityFolder();
            else
                folder = folder.ConvertRelativePathToAbsolutePath(true);

            return folder;
        }

        void CleanupBuildSettingRemovedScenes()
        {
            StoreEditorScenes();

            NativeArray<bool> scenePresent = new NativeArray<bool>(scenes.Count, Allocator.Temp, NativeArrayOptions.UninitializedMemory);
            Parallel.For(0, scenePresent.Length, (i) =>
            {
                scenePresent[i] = File.Exists(scenes[i].path);
            });

            bool somethingRemoved = false;
            for (int i = scenes.Count - 1; i > -1; i--)
            {
                if (!scenePresent[i])
                {
                    somethingRemoved = true;
                    scenes.RemoveAt(i);
                }
            }

            if (somethingRemoved)
                EditorBuildSettings.scenes = scenes.ToArray();

            scenes.Clear();
            scenePresent.Dispose();
        }

        void StoreEditorScenes()
        {
            var editorScenes = EditorBuildSettings.scenes;
            if (scenes == null)
                scenes = new List<EditorBuildSettingsScene>(editorScenes);
            else
            {
                scenes.Clear();
                scenes.AddRange(editorScenes);
            }
        }

#if ENABLE_ADDRESSABLES
        bool VerifyAddressableSettings(AddressableAssetSettings settings, AddressableAssetGroup group, string assetType, string assetName)
        {
            if (settings == null)
                settings = AddressableAssetSettingsDefaultObject.Settings;

            if (settings == null)
            {
                Debug.LogError($"Could not create {assetType} asset {assetName} because you have indicated it should be made into an addressable asset, however there is no Addressable Asset Setting in this project. Have you deleted it by accident? Check Assets/AddressableAssetsData for an asset called DefaultObject. If it does not exist, try reimporting the Addressable Package.");
                return false;
            }

            if (group == null)
            {
                Debug.LogError($"Could not create {assetType} asset {assetName} because you have indicated it should be made into an addressable asset, however there is Addressable Asset Group selected. Please verify your group selection on the Asset Creator asset.");
                return false;
            }

            //verify the group is actually still part of the selected asset settings
            group = settings.FindGroup(group.Name);
            if (group == null)
            {
                Debug.LogError($"Could not create {assetType} asset {assetName} because you have indicated it should be made into an addressable asset, however the selected Addressable Asset Group is no longer a part of the Addressable Asset Setting you are using. Please verify your group selection on the Asset Creator asset.");
                return false;
            }

            return true;
        }
        void MakeAssetAddressable(AddressableAssetSettings settings, AddressableAssetGroup group, string[] labels, string assetFilePath, string assetName, string prepend, string append, ChunkInfo chunkInfo, bool addLayerLabel, bool addRowLabel, bool addColumnLabel)
        {
            if (settings == null)
            {
                settings = AddressableAssetSettingsDefaultObject.Settings;
                if (settings == null)
                {
                    Debug.LogError($"Unable to make one or more assets created via the {name} Asset Creator addressable, as there is no default Addressable Settings asset located in the project. Open the Groups window via Window -> Asset Management -> Addressables -> Groups to create/set an addressable settings asset.");
                    return;
                }
            }

            AddMissingLabels(settings, labels, chunkInfo, addLayerLabel, addRowLabel, addColumnLabel);
            group = settings.FindGroup(group.Name);
            string guid = AssetDatabase.AssetPathToGUID(assetFilePath);
            var assetEntry = group.GetAssetEntry(guid);

            if (assetEntry == null)
                assetEntry = settings.CreateOrMoveEntry(guid, group, false);

            string address = $"{prepend}{assetName}{append}";
            if (assetEntry.address == null || !assetEntry.address.Equals(address))
                assetEntry.SetAddress(address);

            if (addLayerLabel)
                assetEntry.SetLabel($"L{chunkInfo.streamableGridCellOfChunk.Layer}", true);

            if (addRowLabel)
                assetEntry.SetLabel($"R{chunkInfo.streamableGridCellOfChunk.Row}", true);

            if (addColumnLabel)
                assetEntry.SetLabel($"C{chunkInfo.streamableGridCellOfChunk.Column}", true);

            if (labels != null && labels.Length > 0)
            {
                for (int i = 0; i < labels.Length; i++)
                    assetEntry.SetLabel(labels[i], true);
            }
        }
        void AddMissingLabels(AddressableAssetSettings settings, string[] labelsToAdd, ChunkInfo chunkInfo, bool addLayerLabel, bool addRowLabel, bool addColumnLabel)
        {
            if (addLayerLabel)
                settings.AddLabel($"L{chunkInfo.streamableGridCellOfChunk.Layer}");

            if (addRowLabel)
                settings.AddLabel($"R{chunkInfo.streamableGridCellOfChunk.Row}");

            if (addColumnLabel)
                settings.AddLabel($"C{chunkInfo.streamableGridCellOfChunk.Column}");

            if (labelsToAdd != null && labelsToAdd.Length > 0)
            {
                for (int i = 0; i < labelsToAdd.Length; i++)
                    settings.AddLabel(labelsToAdd[i]);
            }
        }
#endif

        string GetFinalFolderSavePath(string rootFolder, string zoneName, string groupingName, string LODGroupName)
        {
            string folder = rootFolder;
            if(outputToZoneSpecificSubFolder)
            {
                if (!folder.EndsWith("/"))
                    folder += $"/{zoneName}";
                else
                    folder += zoneName;
            }

            if (outputToGroupingSpecificSubFolder)
            {
                if (!folder.EndsWith("/"))
                    folder += $"/{groupingName}";
                else
                    folder += groupingName;
            }

            if (outputToLODGroupSpecificSubFolder)
            {
                if (!folder.EndsWith("/"))
                    folder += $"/{LODGroupName}";
                else
                    folder += LODGroupName;
            }

            return EnsureFolderExist(folder);
        }

        [System.Serializable]
        class Template
        {
            [SerializeField]
            public string zoneName = "";

            [SerializeField]
            public string groupingName = "";

            [SerializeField]
            public int[] lodGroups;

            [SerializeField]
            public GameObject[] chunkPrefabs;
        }
    }
}