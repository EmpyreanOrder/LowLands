//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using DeepSpaceLabs.Core;
    using System;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEngine.AddressableAssets;
    using UnityEngine.ResourceManagement.AsyncOperations;
    using UnityEngine.ResourceManagement.ResourceLocations;
    using UnityEngine.SceneManagement;

    /// <summary>
    /// Default implementation of addressable prefab chunk streamer. Should work in 90% of cases when using addressable prefabs.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Chunk Streamers/Addressable Prefab Chunk Streamer")]
    [HelpURL(GlobalValues.API_URL + "AddressablePrefabChunkStreamer.html")]
    public sealed class AddressablePrefabChunkStreamer : AddressableBaseChunkStreamer
    {
        #region Inspector Fields
        [SerializeField, FieldRename("Load In Deactivated State*", "Load In Deactivated State\n\nIf enabled, the loaded assets will be loaded into a deactivated state. This can be useful for normalizing different asset types; for example, you may be also using scenes for other assets which are usually loaded in a deactivated state. By loading the addressable prefabs in a deactivated state, you can ensure that the different asset types' Awake and Start methods are called at the same time.\n\nIf your assets are by default in a deactivated state, there is no need to enable this option.")]
        bool loadInDeactivatedState = true;

        [SerializeField, FieldRename("Memory Freeing Strategy*", "Memory Freeing Strategy\n\nControls if and when memory is freed when destroying chunks.\n\nNote, this method makes use of Resources.UnloadUnusedAssets, which typically Unity discourages from being used with the Addressable system. Therefore, you should only free memory when you notice an issue with memory sticking around when it shouldn't. In most instance, the Don't Free Memory should be used.\n\nAlso note that Resources.UnloadUnusedAssets will automatically call GC.Collect, so you should not use GC.Collect yourself.\n\nThis strategy only controls whether Resources.UnloadUnusedAssets is called after destroying the chunks (or their children). Some memory may not be reclaimable until after the underlying Addressable asset is released, which is only done after destroying all asset chunks during an unload operation.\n\nUse the separate 'Free Memory After Releasing Handles' setting to control whether Resources.UnloadUnusedAssets is called after releasing handles!")]
        MemoryFreeingStrategy memoryFreeingStrategy = MemoryFreeingStrategy.DontFreeMemory;

        [SerializeField, FieldRename("Post Handle Release\nMemory Freeing Strategy*", "Post Handle Release Memory Freeing Strategy\n\nControls whether Resources.UnloadUnusedAssets is called after the streamer attemps to release the Addressable Resource Handles for destroyed Asset Chunks.\n\n'Dont Free Memory' means the method won't be called.\n\n'Free Only If Handles Released' will only call the method if at least one handle is released during a given unload operation.\n\n'Free If Memory Freeing Strategy Is Dont Free' is special. If at least one handle is released, it will result in the method being called. If no handles are released, the method will be called only if Memory Freeing Strategy (above) is set to Dont Free Memory. This gives you a way to gaurantee the memory will be freed after destroying asset chunks, so that you can have the streamer only need to call Resources.UnloadUnusedAssets once.")]
        PostHandleReleaseMemoryFreeingStrategy postHandleReleaseMemoryFreeingStrategy = PostHandleReleaseMemoryFreeingStrategy.DontFreeMemory;

        enum PostHandleReleaseMemoryFreeingStrategy { DontFreeMemory, FreeOnlyIfHandlesReleased, FreeIfMemoryFreeingStrategyIsDontFree }

        [SerializeField, FieldRename("Wait On Final\nMemory Freeing Op*", "Wait On Final Memory Freeing Op\n\nWhen destroying chunks, if after destroying all chunks a memory freeing operation is needed, this setting determines whether control will be returned to the calling Chunk Manager immediately or only after the memory freeing operation completes.\n\nDisabling this might speed up the World Update speed a little bit, however doing so may also result in performance issues, so you should profile to find the best option.\n\nIf Memory Freeing Strategy is set to 'Dont Free Memory', this setting is ignored.\n\nAlso note that when using a Chunk Destroyer, the Addressable Handles and Resource are only unloaded after all Asset Chunks are destroyed. Because of this, a memory freeing op is always performed after all Asset Chunks are destroyed, so long as Memory Freeing Strategy is not set to 'Dont Free Memory'.")]
        bool waitOnFinalMemoryFreeingOp = false;

        [SerializeField, FieldRename("Chunk Destroyer*", "Chunk Destroyer\n\nBy default, when DetatchAndUnloadChunksFromCells is called, the streamer calls GameObject.Destroy for each chunk/cell object that needs to be removed from the scene, decrements the count of loaded instances for the addressable associated with the chunk/cell object, and then Releases the addressable handle which should free memory.\n\nIf your chunk/cell object has many children, you may wish to use a custom Chunk Destroyer in order to destroy the children across several frames to avoid FPS spikes.\n\nDo keep in mind, unlike other Chunk Streamers that make use of the Chunk Destroyer class, this streamer will use the destroyers DestroyChunk method rather than its DestroyChunksOnCells method. The reason for doing so is that after destroying each chunk/cell object, the count of loaded instances for the addressable associated with the chunk/cell object needs to be decremented, so that its handle can be released when the count reaches 0.")]
        ChunkDestroyer chunkDestroyer;
        #endregion

        #region Non Inspector Fields
        bool usingChunkDestroyer;
        ConditionalMembers conditionalMembers;
        Transform loadParent = null;
        #endregion

        #region Properties

        /// <summary>
        /// Gets the Chunk Destroyer associated with this component.
        /// <para>
        /// By default, when DetatchAndUnloadChunksFromCells is called, the streamer calls GameObject.Destroy for each chunk/cell object that needs to be 
        /// removed from the scene, decrements the count of loaded instances for the addressable associated with the chunk/cell object, and then Releases 
        /// the addressable handle which should free memory.
        /// </para>
        /// <para>
        /// If your chunk/cell object has many children, you may wish to use a custom Chunk Destroyer in order to destroy the children across several 
        /// frames to avoid FPS spikes.
        /// </para>
        /// <para>
        /// Do keep in mind, unlike other Chunk Streamers that make use of the Chunk Destroyer class, this streamer will use the destroyers DestroyChunk method 
        /// rather than its DestroyChunksOnCells method. The reason for doing so is that after destroying each chunk/cell object, the count of loaded instances 
        /// for the addressable associated with the chunk/cell object needs to be decremented, so that its handle can be released when the count reaches 0.
        /// </para>
        /// </summary>
        /// <type link="ChunkDestroyer.html">ChunkDestroyer (protected)</type>
        public ChunkDestroyer ChunkDestroyer { get { return chunkDestroyer; } }

        /// <summary>
        /// The strategy for freeing memory. If you create a custom class deriving from Chunk Manager, 
        /// you can choose to ignore the strategy or enforce it. Memory freeing 
        /// is simply calling Resources.UnloadUnusedAssets (which can be used like any other coroutine!)
        /// </summary>
        /// <type link="MemoryFreeingStrategy.html">MemoryFreeingStrategy</type>
        public MemoryFreeingStrategy MemoryFreeingStrategy { get { return memoryFreeingStrategy; } }

        /// <summary>
        /// Because Instantiated prefabs do not need a frame to "process", pre-loading is not required, and so this
        /// property is overridden to return false.
        /// </summary>
        /// <type>bool</type>
        public sealed override bool IsSingleFrameAttachmentPreloadRequired { get { return false; } }

        /// <summary>
        /// File extension that is appended to addresses.
        /// </summary>
        /// <type>string</type>
        protected sealed override string FileExtension { get { return ".prefab"; } }
        #endregion

        #region Overriden Methods

        /// <summary>
        /// Awake logic.
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

            if (chunkDestroyer == null)
            {
                usingChunkDestroyer = false;
                ReusableEnumerators.AddUser<AddressablesDetachAndUnloadPrefabCellChunksFromCellsEnumerator>();
            }
            else
            {
                usingChunkDestroyer = true;
                ReusableEnumerators.AddUser<AddressablesDetachAndUnloadPrefabCellChunksFromCellsUsingChunkDestroyerEnumerator>();
            }
            //in order to load the prefabs in a deactivated state, we load them as children of a deactivated parent.
            //then we deactivate the state of the prefabs, and finally we set their parent to null
            if (loadInDeactivatedState)
            {
                GameObject parentObject = GameObject.Find("SAM_DeactivatedLoadParent_DoNotDelete");

                if (parentObject == null)
                {
                    parentObject = new GameObject("SAM_DeactivatedLoadParent_DoNotDelete");

                    //ensure this game object is in the same scene as the Prefab Chunk Streamer
                    if (parentObject.scene != gameObject.scene)
                        SceneManager.MoveGameObjectToScene(parentObject, gameObject.scene);

                    parentObject.AddComponent<Readme>().info = "This game object is used to load prefabs in a deactivated state when using Prefab Chunk Streamers or Addressable Prefab Chunk Streamer with the 'Load In Deactivated State' option enabled. It contains a single deactivated child which the prefabs are made children of upon load, which ensures they are loaded in a deactivated state. Please do not destroy it!";
                    var parentObjectTransform = parentObject.transform;
                    parentObjectTransform.position = Vector3.zero;

                    GameObject child = new GameObject("DeactivatedPrefabs");
                    child.AddComponent<Readme>().info = "The prefabs loaded by Prefab based Chunk Streamers with 'Load In Deactivated State' enabled are loaded as children of this game object, which ensures they are deactivated upon load. Please do not destroy it!";
                    child.transform.parent = parentObjectTransform;
                    child.SetActive(false);
                    loadParent = child.transform;
                }
                else
                    loadParent = parentObject.transform.GetChild(0);
            }
        }

        /// <summary>
        /// OnDestroy logic.
        /// </summary>
        /// <displayName id="OnDestroyExtended">
        /// OnDestroyExtended()
        /// </displayName>
        /// <syntax>
        /// protected sealed override void OnDestroyExtended()
        /// </syntax>
        protected sealed override void OnDestroyExtended()
        {
            if (!usingChunkDestroyer)
                ReusableEnumerators.RemoveUser<AddressablesDetachAndUnloadPrefabCellChunksFromCellsEnumerator>();
            else
                ReusableEnumerators.RemoveUser<AddressablesDetachAndUnloadPrefabCellChunksFromCellsUsingChunkDestroyerEnumerator>();
        }

        /// <summary>
        /// Creates a new AddressablePrefabLoaderUser object, which implements behaviour needed to load prefab addressable assets.
        /// </summary>
        /// <param name="zoneLODGroup" type="IZoneLODGroup" link="IZoneLODGroup.html">
        /// The Zone LOD Group being registered.
        /// </param>
        /// <returns>A new AddressablePrefabLoaderUser user object created using the zoneGrouping as input.</returns>
        protected sealed override AddressableStreamerBaseUser CreateAddressableLoaderUser(IZoneLODGroup zoneLODGroup)
        {
            return new AddressablePrefabChunkStreamerUser(this, zoneLODGroup);
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
            if (usingChunkDestroyer)
            {
                return ReusableEnumerators.GetEnumeratorNotInUse<AddressablesDetachAndUnloadPrefabCellChunksFromCellsUsingChunkDestroyerEnumerator>().PrepareForIteration(this, cells, (AddressablePrefabChunkStreamerUser)RegisteredUsers[userID], chunkDestroyer);
            }
            else
            {
                return ReusableEnumerators.GetEnumeratorNotInUse<AddressablesDetachAndUnloadPrefabCellChunksFromCellsEnumerator>().PrepareForIteration(this, cells, (AddressablePrefabChunkStreamerUser)RegisteredUsers[userID]);
            }
        }
        #endregion

        #region Prefab Streamer User
        class AddressablePrefabChunkStreamerUser : AddressableStreamerBaseUser
        {
            AddressablePrefabChunkStreamer parent;

            public sealed override bool CanReuseAddressables { get { return true; } }

            protected sealed override Type FileType { get { return typeof(GameObject); } }

            protected sealed override int MaxConcurrentAsyncLoads { get { return MaxAsyncLoadOpsToCompleteInSingleFrame; } }

            /// <summary>
            /// Creates a new instance of a AddressablePrefabChunkStreamerUser object.
            /// </summary>
            /// <param name="parent" type="AddressablePrefabChunkStreamer">
            /// The parent that created this instance.
            /// </param>
            /// <param name="zoneLODGroup" type="IZoneLODGroup">
            /// The Zone LOD Group associated with the user.
            /// </param>
            public AddressablePrefabChunkStreamerUser(AddressablePrefabChunkStreamer parent, IZoneLODGroup zoneLODGroup) : base(parent, zoneLODGroup)
            {
                this.parent = parent;
            }

            #region Methods
            //called whenever MaxAsyncLoadOpsToCompleteInSingleFrame changes
            protected sealed override void OnMaxAsyncLoadOpsToCompleteInSingleFrameChanged()
            {
                //tells the base addressable chunk streamer that the value of MaxConcurrentAsyncLoads has changed (since the value used is 
                //MaxAsyncLoadOpsToCompleteInSingleFrame).
                OnMaxConcurrentAsyncLoadsChanged();
            }
            protected sealed override bool IsLowestQualityLODStreamerCompatible(ChunkStreamer streamerOfLowestQualityLODAssets)
            {
                return streamerOfLowestQualityLODAssets is AddressablePrefabChunkStreamer;
            }



            public sealed override void CheckForLoadAndAttachChunksToCellsInSingleFrameExceptions()
            {
                if (Application.platform == RuntimePlatform.WebGLPlayer)
                    throw new InvalidOperationException("Using the Addressable Prefab Chunk Streamer with Two Frame Initialization is not allowed on WebGL, as WebGL does not support single frame loading of Addressable Assets. Please switch to Gradual Initialization, which can be done on the SAM Initializer component by switching the Initialization Type to Gradual, or by manually calling SAMInitializer.InitializeSAM_Gradual.");
            }

            public sealed override AsyncOperationHandle LoadNewAssetAsyncUsingLocation(IResourceLocation location, out bool requiresActivation)
            {
                requiresActivation = false;
                return Addressables.LoadAssetAsync<GameObject>(location);
            }

            public sealed override AsyncOperationHandle LoadNewAssetAsyncUsingKey(string key, out bool requiresActivation)
            {
                requiresActivation = false;
                return Addressables.LoadAssetAsync<GameObject>(key);
            }

            public sealed override object SetupChunkFromLoadHandle(ReadyOp readyOp, AsyncOperationHandle handle, out ChunksPositioned chunksPositioned)
            {
                var typedHandle = handle.Convert<GameObject>();
                var source = typedHandle.Result;

                GameObject obj;

                if (parent.loadInDeactivatedState)
                {
                    obj = Instantiate(source, (Vector3)readyOp.Cell.PositionOfChunks, source.transform.rotation, parent.loadParent);
                    obj.SetActive(false);
                }
                else
                    obj = Instantiate(source, (Vector3)readyOp.Cell.PositionOfChunks, source.transform.rotation);
                chunksPositioned = ChunksPositioned.Yes;
                obj.name = readyOp.LoadedAsyncOpInfo.ChunkName;

                return obj;
            }
            #endregion
        }
        #endregion

        #region enumerator classes

        class AddressablesDetachAndUnloadPrefabCellChunksFromCellsEnumerator : YieldEnumeratorWithParent_RefOnly<AddressablePrefabChunkStreamer, List<WorldCell>, AddressablePrefabChunkStreamerUser>
        {
            bool atLeastOneHandleReleased;
            int cellIndex, chunkIndex, handlesReleasedThisFrame;
            WorldCell currentCell;

            protected sealed override void PerformAdditionalIterationPreparation()
            {
                Phase = 10;
                cellIndex = 0;
                chunkIndex = 1;
                currentCell = r1[0];
                atLeastOneHandleReleased = false;
            }

            protected override bool MoveNextImplementation()
            {
                switch (Phase)
                {
                    case 1:
                        {
                            GameObject chunk = (GameObject)currentCell.DetachChunksFromCell(chunkIndex);

                            //if its null, it must have been destroyed somewhere else. We still need to reduce the
                            //instantiation count
                            if (chunk == null)
                            {
                                //r2.RemoveUserOfReusableAsset(currentCell, chunkIndex);
                                goto case 2;
                            }
                            else
                            {
                                Parent.conditionalMembers.OnDestroyingAssetChunkOrChildren(currentCell, chunkIndex);
                                Destroy(chunk);
                                Parent.conditionalMembers.OnAssetChunkOrChildrenDestroyed(currentCell, chunkIndex);
                                //r2.RemoveUserOfReusableAsset(currentCell, chunkIndex);
                                goto case 3;
                            }
                        }
                    case 2://with these, only yield if a memory freeing op is needed
                        {
                            chunkIndex++;
                            if (chunkIndex > currentCell.NumChunks)
                            {
                                cellIndex++;
                                if (cellIndex >= r1.Count)//no more cells
                                {
                                    goto case 4;
                                }
                                else//finished processing one cell, but there are more
                                {
                                    currentCell = r1[cellIndex];
                                    chunkIndex = 1;
                                    if (Parent.memoryFreeingStrategy == MemoryFreeingStrategy.FreeAfterEachCell)
                                    {
                                        Current = Resources.UnloadUnusedAssets();
                                        return true;
                                    }
                                    else
                                        goto case 1;
                                }
                            }
                            else//there are more chunks for this cell
                            {
                                if (Parent.memoryFreeingStrategy == MemoryFreeingStrategy.FreeAfterEachChunk)
                                {
                                    Current = Resources.UnloadUnusedAssets();
                                    return true;
                                }
                                else
                                    goto case 1;
                            }
                        }
                    case 3://same as case 2 except it will yield a frame if a memory op is not needed (to give the chunk a chance to be destroyed)
                        {
                            chunkIndex++;
                            if (chunkIndex > currentCell.NumChunks)
                            {
                                cellIndex++;
                                if (cellIndex >= r1.Count)
                                {
                                    goto case 4;
                                }
                                else
                                {
                                    currentCell = r1[cellIndex];
                                    chunkIndex = 1;
                                    Current = Parent.memoryFreeingStrategy == MemoryFreeingStrategy.FreeAfterEachCell ? Resources.UnloadUnusedAssets() : null;
                                    return true;
                                }
                            }
                            else
                            {
                                Current = Parent.memoryFreeingStrategy == MemoryFreeingStrategy.FreeAfterEachChunk ? Resources.UnloadUnusedAssets() : null;
                                return true;
                            }
                        }
                    case 4:
                        {
                            if (Parent.memoryFreeingStrategy == MemoryFreeingStrategy.FreeAfterAllCells)
                            {
                                Current = Resources.UnloadUnusedAssets();
                                Phase = 5;
                                return true;
                            }

                            goto case 5;
                        }
                    case 5:
                        {
                            cellIndex = 0;
                            chunkIndex = 1;
                            currentCell = r1[0];
                            handlesReleasedThisFrame = 0;
                            Phase = 6;
                            Current = null;//yielding will yield a frame
                            goto case 6;
                        }
                    case 6:
                        {
                            r2.RemoveUserOfReusableAsset(currentCell, chunkIndex, out bool handleReleased);
                            if (handleReleased)
                            {
                                atLeastOneHandleReleased = true;
                                if (++handlesReleasedThisFrame >= r2.MaxAsyncHandlesToReleaseInSingleFrame)
                                {
                                    handlesReleasedThisFrame = 0;
                                    Phase = 7;
                                    return true;
                                }
                            }

                            goto case 7;
                        }
                    case 7://with these, only yield if a memory freeing op is needed
                        {
                            chunkIndex++;
                            if (chunkIndex > currentCell.NumChunks)
                            {
                                cellIndex++;
                                if (cellIndex >= r1.Count)//no more cells
                                {
                                    goto case 8;
                                }
                                else//finished processing one cell, but there are more
                                {
                                    currentCell = r1[cellIndex];
                                    chunkIndex = 1;
                                }
                            }

                            goto case 6;
                        }
                    case 8:
                        {
                            if (Parent.postHandleReleaseMemoryFreeingStrategy != PostHandleReleaseMemoryFreeingStrategy.DontFreeMemory && (atLeastOneHandleReleased || (Parent.MemoryFreeingStrategy == MemoryFreeingStrategy.DontFreeMemory && Parent.postHandleReleaseMemoryFreeingStrategy == PostHandleReleaseMemoryFreeingStrategy.FreeIfMemoryFreeingStrategyIsDontFree)))
                            {
                                if (Parent.waitOnFinalMemoryFreeingOp)
                                {
                                    Current = Resources.UnloadUnusedAssets();
                                    Phase = 9;
                                    return true;
                                }
                                else
                                    Resources.UnloadUnusedAssets();
                            }

                            goto case 9;
                        }
                    case 9://execution complete
                        {
                            return false;
                        }
                    case 10://first case, just waits for any pending jobs to complete
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
                        throw new YieldEnumeratorException("AddressablesDetachAndUnloadPrefabCellChunksFromCellsEnumerator", "Prefab Instantiator Async component", "Parent.gameObject.name", Phase);
                }
            }

            protected override void ResetImplementation()
            {
                currentCell = null;
            }
        }

        class AddressablesDetachAndUnloadPrefabCellChunksFromCellsUsingChunkDestroyerEnumerator : YieldEnumeratorWithParent_RefOnly<AddressablePrefabChunkStreamer, List<WorldCell>, AddressablePrefabChunkStreamerUser, ChunkDestroyer>
        {
            bool atLeastOneHandleReleased;
            int cellIndex, chunkIndex, handlesReleasedThisFrame;
            WorldCell currentCell;
            IEnumerator<YieldInstruction> destroyerEn;

            protected sealed override void PerformAdditionalIterationPreparation()
            {
                Phase = 7;
                cellIndex = 0;
                chunkIndex = 1;
                currentCell = r1[0];
                atLeastOneHandleReleased = false;
                handlesReleasedThisFrame = 0;
            }

            protected override bool MoveNextImplementation()
            {
                switch (Phase)
                {
                    case 1:
                        {
                            destroyerEn = r3.DestroyChunksOnCells(r1, Parent.memoryFreeingStrategy, r2, Parent.waitOnFinalMemoryFreeingOp);
                            Phase = 2;
                            goto case 2;
                        }
                    case 2:
                        {
                            if (destroyerEn.MoveNext())
                            {
                                Current = destroyerEn.Current;
                                return true;
                            }
                            else
                            {
                                Current = null;
                                goto case 3;
                            }
                        }
                    case 3:
                        {
                            r2.RemoveUserOfReusableAsset(currentCell, chunkIndex, out bool handleReleased);
                            if (handleReleased)
                            {
                                atLeastOneHandleReleased = true;
                                if (++handlesReleasedThisFrame >= r2.MaxAsyncHandlesToReleaseInSingleFrame)
                                {
                                    handlesReleasedThisFrame = 0;
                                    Phase = 4;
                                    return true;
                                }
                            }

                            goto case 4;
                        }
                    case 4://with these, only yield if a memory freeing op is needed
                        {
                            chunkIndex++;
                            if (chunkIndex > currentCell.NumChunks)
                            {
                                cellIndex++;
                                if (cellIndex >= r1.Count)//no more cells
                                {
                                    goto case 5;
                                }
                                else//finished processing one cell, but there are more
                                {
                                    currentCell = r1[cellIndex];
                                    chunkIndex = 1;
                                }
                            }

                            goto case 3;
                        }
                    case 5:
                        {
                            if (Parent.postHandleReleaseMemoryFreeingStrategy != PostHandleReleaseMemoryFreeingStrategy.DontFreeMemory && (atLeastOneHandleReleased || (Parent.MemoryFreeingStrategy == MemoryFreeingStrategy.DontFreeMemory && Parent.postHandleReleaseMemoryFreeingStrategy == PostHandleReleaseMemoryFreeingStrategy.FreeIfMemoryFreeingStrategyIsDontFree)))
                            {
                                if (Parent.waitOnFinalMemoryFreeingOp)
                                {
                                    Current = Resources.UnloadUnusedAssets();
                                    Phase = 6;
                                    return true;
                                }
                                else
                                    Resources.UnloadUnusedAssets();
                            }

                            goto case 6;
                        }
                    case 6://execution complete
                        {
                            return false;
                        }
                    case 7://waiting case
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
                        throw new YieldEnumeratorException("AddressablesDetachAndUnloadPrefabCellChunksFromCellsUsingChunkDestroyerEnumerator", "Prefab Instantiator Async component", "Parent.gameObject.name", Phase);
                }
            }

            protected override void ResetImplementation()
            {
                currentCell = null;
                destroyerEn = null;
            }
        }


        #endregion
    }
}