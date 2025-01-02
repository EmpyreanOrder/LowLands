//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine.AddressableAssets;
    using UnityEngine;
    using System;
    using System.Collections.Generic;
    using UnityEngine.ResourceManagement.AsyncOperations;
    using UnityEngine.ResourceManagement.ResourceLocations;
    using UnityEngine.ResourceManagement.ResourceProviders;
    using UnityEngine.SceneManagement;
    using DeepSpaceLabs.Core;

    /// <summary>
    /// Default implementation of addressable scene chunk streamer. Should work in 90% of cases when using addressable scenes.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Chunk Streamers/Addressable Scene Chunk Streamer")]
    [HelpURL(GlobalValues.API_URL + "AddressableSceneChunkStreamer.html")]
    public class AddressableSceneChunkStreamer : AddressableBaseChunkStreamer
    {
        #region Inspector Fields
        [SerializeField, FieldRename("Call Unload Unused Assets*", "Call Unload Unused Assets\n\nIf enabled, the streamer will call Resources.UnloadUnusedAssets after unloading all scenes for a given group of World Cells.\n\nThis may be necessary as there is chance certain assets will not be unloaded automatically when unloading scenes via the Addressable System, depending on how your Addressable Groups are setup/packed.\n\nTherefore, you should monitor the memory usage of your game while using the streamer to see if you can get away with not calling this method, or alternatively, leave this option disabled and call this method yourself.\n\nNote that because Resources.UnloadUnusedAssets is only called after unloading all of the Asset Chunk Scenes, enabling this option may slow down the World's update speed a bit. The benefit is usually that more memory can be freed before loading new assets, resulting in less memory pressure.\n\nHowever, in most situations, Resources.UnloadUnusedAssets has a significant performance impact and should be avoided by configuring your Addressable Groups so that only assets that are loaded/unloaded together are packed together into asset bundles.")]
        bool callUnloadUnusedAssets = true;

        [SerializeField, FieldRename("Relinquish Control ASAP*", "callUnloadUnusedAssets", true, "Relinquish Control ASAP\n\nIf enabled, control will be returned to calling code (usually a Chunk Manager) as soon as all addressable scene assets are unloaded and their handles released.\n\nThe Streamer will still call Resources.UnloadUnusedAssets, however it will not wait for it to complete.")]
        bool relinquishControlASAP = false;

        [SerializeField, FieldRename("Keep Scenes Intact*", "Keep Scenes Intact\n\nNormally, it's beneficial to load the addressable scenes containing chunk assets and move the chunk assets into the main scene. In some rare circumstances, this strategy may be problematic and in those cases you can enable this option.\n\nEnabling this option will keep the original loaded scenes intact so that the chunk asset will not be moved out of that scene by the streamer.\n\nDo note that if using a Hiearchy Organizer, it will almost certainly move the chunk asset out of the scene when it reparents the asset, which is counter intuitive. As such, enabling this option while using a Hierarchy Organizer is not advised. Only enable this option if you are absolutely sure you need to!")]
        bool keepScenesIntact = false;

        [SerializeField, FieldRename("Invalid Scene Format\nMessage Level*", "Invalid Scene Format Message Level\n\nHow invalid scene formats are logged when discovered by this Addressable Scene Chunk Streamer. An invalid scene format is one where the scene contains more or less than 1 root game object, or one with a single root game object that is not in the state indicated by the Root State setting for the LOD Group (on the Streamable Grid asset) that is making use of the scene.")]
        InvalidSceneFormatMessageLevel invalidSceneFormatMessageLevel;
        #endregion

        #region Non Inspector Fields
        ConditionalMembers conditionalMembers;
        List<GameObject> reusableObjList = new List<GameObject>(1);
        Action<GameObject, Scene> MoveChunkOrDont;
        #endregion

        #region Properties


        /// <summary>
        /// Gets or Sets the Call Unload Unused Assets value.
        /// </summary>
        /// <type>bool</type>
        public bool CallUnloadUnusedAssets { get { return callUnloadUnusedAssets; } set { callUnloadUnusedAssets = value; } }

        /// <summary>
        /// This property, along with the LoadAndAttachChunksToCellsInSingleFrame method, 
        /// will throw an InvalidOperationException if queried, so don't! The Addressable System is unable to load scenes 
        /// in a synchronous manner, therefore use of 'Initialize on Awake' (via the Component Manager) is not allowed, as that will 
        /// query this Property as well as call the LoadAndAttachChunksToCellsInSingleFrame method. Instead, disable 'Initialize on Awake' and 
        /// call the InitializeGradually method of the Component Manager manually.
        /// </summary>
        /// <type>bool</type>
        public sealed override bool IsSingleFrameAttachmentPreloadRequired { get { throw new InvalidOperationException("Using the Addressable Scene Chunk Streamer with Two Frame Initialization is not allowed, as the Addressable System does not support two frame loading of Addressable Scenes. If using the SAM Initializer's Initialize On Startup option, please change the Initialization Type to Gradual, or else manually trigger gradual loading by calling SAMInitializer.InitializeSAM_Gradual or ComponentManager.InitializeGradually"); } }

        /// <summary>
        /// Gets the Keep Scenes Intact value set in the inspector.
        /// </summary>
        /// <type>bool</type>
        public bool KeepScenesIntact { get { return keepScenesIntact; } }

        protected sealed override string FileExtension { get { return ".unity"; } }

        /// <summary>
        /// Gets or Sets the Relinquish Control ASAP When Unloading value.
        /// </summary>
        /// <type>bool</type>
        public bool RelinquishControlASAPWhenUnloading { get { return relinquishControlASAP; } set { relinquishControlASAP = value; } }

        /// <summary>
        /// Gets or sets the InvalidSceneFormatMessageLevel used by this Scene Streamer.
        /// </summary>
        /// <type link="InvalidSceneFormatMessageLevel.html">InvalidSceneFormatMessageLevel</type>
        public InvalidSceneFormatMessageLevel InvalidSceneFormatMessageLevel { get { return invalidSceneFormatMessageLevel; } set { invalidSceneFormatMessageLevel = value; } }
        #endregion

        #region Overriden Methods

        /// <summary>
        /// Awake related logic.
        /// </summary>
        /// <displayName id="AwakeExtended2">
        /// AwakeExtended2()
        /// </displayName>
        /// <syntax>
        /// protected sealed override void AwakeExtended2()
        /// </syntax>
        protected sealed override void AwakeExtended2()
        {
            conditionalMembers = ConditionalMembers.GetConditionalMembers();
            ReusableEnumerators.AddUser<AddressablesDetachAndUnloadSceneChunksFromCellsEnumerator>();

            if (keepScenesIntact)
            {
                MoveChunkOrDont = (chunk, scene) => { };
            }
            else
            {
                MoveChunkOrDont = (chunk, scene) =>
                {
                    SceneManager.MoveGameObjectToScene(chunk, scene);
                };
            }
        }

        /// <summary>
        /// OnDestroy related logic.
        /// </summary>
        /// <displayName id="OnDestroyExtended">
        /// OnDestroyExtended()
        /// </displayName>
        /// <syntax>
        /// protected sealed override void OnDestroyExtended()
        /// </syntax>
        protected sealed override void OnDestroyExtended()
        {
            ReusableEnumerators.RemoveUser<AddressablesDetachAndUnloadSceneChunksFromCellsEnumerator>();
        }

        /// <summary>
        /// Creates a new AddressableSceneLoaderUser object, which implements behaviour needed to load scene addressable assets.
        /// </summary>
        /// <param name="zoneLODGroup" type="IZoneLODGroup" link="IZoneLODGroup.html">
        /// The Zone LOD Group being registered.
        /// </param>
        /// <returns type="type">
        /// A new AddressablePrefabLoaderUser user object created using the zoneGrouping as input.
        /// </returns>
        /// <displayName id="CreateAddressableLoaderUser">
        /// CreateAddressableLoaderUser(IZoneLODGroup)
        /// </displayName>
        /// <syntax>
        /// protected sealed override AddressableSceneLoaderUser CreateAddressableLoaderUser(IZoneLODGroup zoneLODGroup)
        /// </syntax>
        protected sealed override AddressableStreamerBaseUser CreateAddressableLoaderUser(IZoneLODGroup zoneLODGroup)
        {
            return new AddressableSceneChunkStreamerUser(this, zoneLODGroup);
        }

        /// <summary>
        /// Detaches and unloads the chunks associated with the input world cells over a period of frames using the associated 
        /// ChunkDestroyer, or GameObject.Destroy if no destroyer is present.
        /// </summary>
        /// <param name="cells" type = "List&lt;WorldCell&gt;" link="WorldCell.html">
        /// The World Cells whose objects need to be detached and unloaded.
        /// </param>
        /// <param name="userID" type = "int">
        /// The ID of the user requesting the unload and detachment.
        /// </param>
        /// <displayName id = "DetachAndUnloadChunksFromCells">
        /// DetachAndUnloadChunksFromCells(List&lt;WorldCell&gt;, int)
        /// </displayName>
        /// <syntax>
        /// public sealed override IEnumerator&lt;YieldInstruction&gt; DetachAndUnloadChunksFromCells(List&lt;WorldCell&gt; cells, int userID)
        /// </syntax>
        /// <returns type = "IEnumerator&lt;YieldInstruction&gt;">
        /// An IEnumerator&lt;YieldInstruction&gt; that can be iterated over or used as a coroutine. See the 
        /// <see href="YieldInstruction.html">YieldInstruction</see> page for more info.
        /// </returns>
        public sealed override IEnumerator<YieldInstruction> DetachAndUnloadChunksFromCells(List<WorldCell> cells, int userID)
        {
            return ReusableEnumerators.GetEnumeratorNotInUse<AddressablesDetachAndUnloadSceneChunksFromCellsEnumerator>().PrepareForIteration(this, cells, (AddressableSceneChunkStreamerUser)RegisteredUsers[userID]);
        }
        #endregion

        #region Scene Streamer User
        class AddressableSceneChunkStreamerUser : AddressableStreamerBaseUser
        {
            AddressableSceneChunkStreamer parent;
            bool expectedRootState;
            Scene userScene;

            public sealed override bool CanReuseAddressables { get { return false; } }

            protected sealed override Type FileType { get { return typeof(SceneInstance); } }

            protected sealed override int MaxConcurrentAsyncLoads { get { return 0; } }

            #region Methods


            protected sealed override bool IsLowestQualityLODStreamerCompatible(ChunkStreamer streamerOfLowestQualityLODAssets)
            {
                return streamerOfLowestQualityLODAssets is AddressableSceneChunkStreamer;
            }

            public sealed override int GetNonReusableAssetKey(AsyncOperationHandle handle)
            {
                var sceneHandle = handle.Convert<SceneInstance>();
                var scene = sceneHandle.Result.Scene;
                scene.GetRootGameObjects(parent.reusableObjList);
                int key = parent.reusableObjList[0].GetInstanceID();
                parent.reusableObjList.Clear();
                return key;
            }

            public AddressableSceneChunkStreamerUser(AddressableSceneChunkStreamer parent, IZoneLODGroup zoneLODGroup) : base(parent, zoneLODGroup)
            {
                this.parent = parent;

                if (ZoneGrouping.World.HierarchyOrganizer != null)
                    userScene = ZoneGrouping.World.HierarchyOrganizer.gameObject.scene;
                else
                    userScene = ZoneGrouping.World.gameObject.scene;

                if (ZoneGrouping.GridLODDetails.RootState == RootState.Deactivated)
                    expectedRootState = false;
                else
                    expectedRootState = true;
            }

            public sealed override void CheckForLoadAndAttachChunksToCellsInSingleFrameExceptions()
            {
                throw new InvalidOperationException("Using the Addressable Scene Streamer with Two Frame Initialization (via the SAM Initializer) is not allowed, as the Addressable System does not support Two Frame loading of Addressable Scenes. Please change the Initialization Type to 'Gradual', or switch to using Addressable Prefabs.\n\nIf you are initializing SAM manually via the SAM Initializer or Component Manager (i.e., Initialize On Startup is disabled), please make sure to use the InitializeSAM_Gradual method rather than the InitializeSAM_Immediate method!");
            }

            public sealed override AsyncOperationHandle LoadNewAssetAsyncUsingLocation(IResourceLocation location, out bool requiresActivation)
            {
                requiresActivation = true;
                return Addressables.LoadSceneAsync(location, LoadSceneMode.Additive, false);
            }

            public sealed override AsyncOperationHandle LoadNewAssetAsyncUsingKey(string key, out bool requiresActivation)
            {
                requiresActivation = true;
                return Addressables.LoadSceneAsync(key, LoadSceneMode.Additive, false);
            }

            public sealed override void ActivateHandleResult(AsyncOperationHandle handle)
            {
                handle.Convert<SceneInstance>().Result.ActivateAsync();
            }

            public sealed override bool IsActivatedHandleReady(AsyncOperationHandle handle)
            {
                //annoying we need to call activate again, but really this is just setting allow activation to true and returning the 
                //Async Operation (this is the only way to access the internal AsyncOperation), so there's no harm
                return handle.Convert<SceneInstance>().Result.ActivateAsync().isDone;
            }

            public sealed override object SetupChunkFromLoadHandle(ReadyOp readyOp, AsyncOperationHandle handle, out ChunksPositioned chunksPositioned)
            {
                var typedHandle = handle.Convert<SceneInstance>();
                var scene = typedHandle.Result.Scene;
                scene.GetRootGameObjects(parent.reusableObjList);

                var messageLevel = parent.InvalidSceneFormatMessageLevel;
                if (messageLevel != InvalidSceneFormatMessageLevel.NoMessage)
                {
                    string error = null;
                    if (parent.reusableObjList.Count > 1)
                        error = $"Invalid Scene Format Detected ({scene.name})\n\n1) More than one root object was found in the scene. This is not allowed!! Only the first root object will be attached to the cell.";

                    if (parent.reusableObjList[0].activeSelf != expectedRootState)
                    {
                        if (parent.reusableObjList[0].activeSelf)
                        {
                            if (error == null)
                                error = $"Invalid Scene Format Detected ({scene.name})\n\n1) The root object in the scene is in an activated state, however you have configured the LOD Group for this scene (LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} from Streamable Grid {ZoneGrouping.GridLODDetails.StreamableGrid.name}, which is being used on Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex} on the World with ID {ZoneGrouping.World.ID}, on Game Object {ZoneGrouping.World.gameObject.name}) as using a Deactivated Root State. Either change the Root State setting to Activated or change the scene's root object to the deactivated game object state (if you see this error for multiple scenes, you can use a Scene Formatter asset to batch change the scenes).";
                            else
                                error += $"\n\n2) The root object in the scene is in an active state, however you have configured the LOD Group for this scene (LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} from Streamable Grid {ZoneGrouping.GridLODDetails.StreamableGrid.name}, which is being used on Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex} on the World with ID {ZoneGrouping.World.ID}, on Game Object {ZoneGrouping.World.gameObject.name}) as using a Deactivated Root State. Either change the Root State setting to Activated or change the scene's root object to the deactivated game object state (if you see this error for multiple scenes, you can use a Scene Formatter asset to batch change the scenes).";
                        }
                        else
                        {
                            if (error == null)
                                error = $"Invalid Scene Format Detected ({scene.name})\n\n1) The root object in the scene is in a deactivated state, however you have configured the LOD Group for this scene (LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} from Streamable Grid {ZoneGrouping.GridLODDetails.StreamableGrid.name}, which is being used on Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex} on the World with ID {ZoneGrouping.World.ID}, on Game Object {ZoneGrouping.World.gameObject.name}) as using an Activated Root State. Either change the Root State setting to Deactivated or change the scene's root object to the activated game object state (if you see this error for multiple scenes, you can use a Scene Formatter asset to batch change the scenes).";
                            else
                                error += $"\n\n2) The root object in the scene is in a deactivated state, however you have configured the LOD Group for this scene (LOD Group {ZoneGrouping.GridLODDetails.LevelOfDetail} from Streamable Grid {ZoneGrouping.GridLODDetails.StreamableGrid.name}, which is being used on Zone {ZoneGrouping.ZoneIndex}, World Grouping {ZoneGrouping.WorldGroupingIndex} on the World with ID {ZoneGrouping.World.ID}, on Game Object {ZoneGrouping.World.gameObject.name}) as using an Activated Root State. Either change the Root State setting to Deactivated or change the scene's root object to the activated game object state (if you see this error for multiple scenes, you can use a Scene Formatter asset to batch change the scenes).";
                        }
                    }

                    if (error != null)
                    {
                        if (messageLevel == InvalidSceneFormatMessageLevel.Warning)
                            Debug.LogWarning(error);
                        else
                            Debug.LogError(error);
                    }
                }

                if (parent.reusableObjList.Count > 1)
                    Debug.LogError("More than one root object was found in the loaded scene " + scene.name + ". This is not allowed!! Attaching only the first root object to the cell.");

                GameObject obj = parent.reusableObjList[0];
                parent.reusableObjList.Clear();

                parent.MoveChunkOrDont(obj, userScene);
                //SceneManager.MoveGameObjectToScene(obj, userScene);

                chunksPositioned = ChunksPositioned.Maybe;
                obj.name = readyOp.LoadedAsyncOpInfo.chunkName;

                return obj;
            }

            #endregion
        }
        #endregion

        #region enumerator classes

        class AddressablesDetachAndUnloadSceneChunksFromCellsEnumerator : YieldEnumeratorWithParent_RefOnly<AddressableSceneChunkStreamer, List<WorldCell>, AddressableSceneChunkStreamerUser>
        {
            struct SceneHandleCellData
            {
                public WorldCell worldCell;
                public int chunkIndex;
            }

            Action<AsyncOperationHandle<SceneInstance>> onSceneUnloadComplete;
            Dictionary<SceneInstance, SceneHandleCellData> handleRelatedDatas = new Dictionary<SceneInstance, SceneHandleCellData>();
            Queue<AsyncOperationHandle<SceneInstance>> handlesReadyToBeReleased = new Queue<AsyncOperationHandle<SceneInstance>>();

            int chunkIndex, cellIndex, unloadOpsStartedThisFrame, unloadingScenes;

            protected sealed override void PerformAdditionalIterationPreparation()
            {
                Phase = 4;
                chunkIndex = 0;//incremented immediately so will become 1 at first execution
                cellIndex = 0;
                unloadingScenes = 0;
                unloadOpsStartedThisFrame = 0;

                if (onSceneUnloadComplete == null)
                    onSceneUnloadComplete = OnSceneUnloadComplete_Internal;
            }

            protected override bool MoveNextImplementation()
            {
                switch (Phase)
                {
                    case 1:
                        {
                            chunkIndex++;

                            if (chunkIndex <= r1[cellIndex].NumChunks)
                            {
                                WorldCell cell = r1[cellIndex];
                                GameObject obj = (GameObject)cell.DetachChunksFromCell(chunkIndex);
                                var asyncLoadOpInfoKey = obj.GetInstanceID();

                                if (!r2.TryGetAssetLoadInfo(asyncLoadOpInfoKey, out LoadedAsyncOperationInfo addressableInfo))
                                    throw new MissingAssetException($"Attempting to unload an addressable asset that was loaded by the Addressable Scene Streamer, however we were unable to locate the Async Operation Handle used to load the asset. This should not happen. Please contact the creator of this package at support@deepspacelabs.net with the totality of this error message. More Info:\n\nWorld ID: {cell.World.ID}\nWorld Game Object Name: {cell.World.gameObject.name}\nZone: {cell.ZoneIndex}\nWorld Grouping: {cell.WorldGroupingIndex}\nLOD: {cell.LevelOfDetail}\nStreamable Grid Cell Index: {cell.CellOnStreamableGrid}\nEndless Grid Cell Index: {cell.CellOnEndlessGrid}\nChunk Index: {chunkIndex}.");

                                var sceneHandle = addressableInfo.handle.Convert<SceneInstance>();
                                handleRelatedDatas.Add(sceneHandle.Result, new SceneHandleCellData() { worldCell = cell, chunkIndex = chunkIndex });
                                Parent.MoveChunkOrDont(obj, sceneHandle.Result.Scene);
                                unloadingScenes++;
                                Parent.conditionalMembers.OnInitiatingAssetChunkUnload(cell, chunkIndex);
                                Addressables.UnloadSceneAsync(sceneHandle, false).Completed += onSceneUnloadComplete;
                                Parent.conditionalMembers.OnAssetChunkUnloadInitiated(cell, chunkIndex);
                                r2.RemoveLoadedAsyncOpInfo(asyncLoadOpInfoKey, addressableInfo);

                                if (++unloadOpsStartedThisFrame < r2.MaxAsyncUnloadOpsToStartInSingleFrame)
                                    goto case 1;
                                else
                                {
                                    unloadOpsStartedThisFrame = 0;
                                    return true;
                                }
                            }
                            else
                            {
                                cellIndex++;
                                if (cellIndex < r1.Count)
                                {
                                    chunkIndex = 0;
                                    goto case 1;
                                }
                                else
                                {
                                    Phase = 2;

                                    if (unloadOpsStartedThisFrame > 0)
                                        return true;
                                    else
                                        goto case 2;
                                }
                            }
                        }
                    case 2:
                        {
                            if (unloadingScenes == 0 && handlesReadyToBeReleased.Count == 0)//done!
                            {
                                if (Parent.callUnloadUnusedAssets)
                                {
                                    if (!Parent.relinquishControlASAP)
                                    {
                                        Current = Resources.UnloadUnusedAssets();
                                        Phase = 3;
                                        return true;
                                    }
                                    else
                                        Resources.UnloadUnusedAssets();
                                }

                                goto case 3;
                            }
                            else if (handlesReadyToBeReleased.Count > 0)
                            {
                                int handlesToRelease = handlesReadyToBeReleased.Count < r2.MaxAsyncHandlesToReleaseInSingleFrame ? handlesReadyToBeReleased.Count : r2.MaxAsyncHandlesToReleaseInSingleFrame;

                                for (int i = 0; i < handlesToRelease; i++)
                                {
                                    var h = handlesReadyToBeReleased.Dequeue();
                                    var handleRelatedData = handleRelatedDatas[h.Result];
                                    handleRelatedDatas.Remove(h.Result);
                                    Parent.conditionalMembers.OnReleasingAssetChunkHandle(handleRelatedData.worldCell, handleRelatedData.chunkIndex);
                                    Addressables.Release(h);
                                    Parent.conditionalMembers.OnAssetChunkHandleReleased(handleRelatedData.worldCell, handleRelatedData.chunkIndex);
                                }
                            }

                            return true;//just yield for a frame
                        }
                    case 3://ending case
                        {
                            return false;
                        }
                    case 4://waiting case
                        {
                            if (r2.IsWaitingOnJob)
                                return true;
                            else
                            {
                                Phase = 1;
                                goto case 1;
                            }
                        }
                    default:
                        throw new YieldEnumeratorException("AddressablesDetachAndUnloadSceneChunksFromCellsEnumerator_SlowRelinquisher", "Prefab Instantiator Async component", "Parent.gameObject.name", Phase);
                }
            }

            void OnSceneUnloadComplete_Internal(AsyncOperationHandle<SceneInstance> h)
            {
                unloadingScenes--;
                var handleRelatedData = handleRelatedDatas[h.Result];
                Parent.conditionalMembers.OnAssetChunkUnloaded(handleRelatedData.worldCell, handleRelatedData.chunkIndex);
                handlesReadyToBeReleased.Enqueue(h);
            }
        }


        #endregion
    }
}