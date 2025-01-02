//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine;
    using Unity.Profiling;
    using System;

    public class ConditionalMembersImplementation : ConditionalMembers
    {
#if UNITY_EDITOR || DEVELOPMENT_BUILD
        [NonSerialized]
        TimingDataTracker timingDataTracker;

        public sealed override void OnSAMInitializing()
        {
            timingDataTracker = FindObjectOfType<TimingDataTracker>();
        }

        static readonly ProfilerMarker initiatingLoadMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.InitiateAsyncLoadOfAssetChunk");
        public sealed override void OnInitiatingAssetChunkLoad(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            initiatingLoadMarker.Begin();
        }

        public sealed override void OnAssetChunkLoadInitiated(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            initiatingLoadMarker.End();
        }

        public sealed override void OnInitiatingAssetChunkIntegrate(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            
        }

        public sealed override void OnAssetChunkLoaded(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            
        }

        static readonly ProfilerMarker configuringMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.ConfigureAssetChunk");
        public sealed override void OnConfiguringAssetChunk(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            configuringMarker.Begin();
            if (timingDataTracker != null)
                timingDataTracker.OnConfiguringAssetChunk(worldCellOfChunk, chunkIndex);
        }

        public sealed override void OnAssetChunkConfigured(WorldCell worldCellOfChunk, int chunkIndex)
        {
            if (timingDataTracker != null)
                timingDataTracker.OnAssetChunkConfigured(worldCellOfChunk, chunkIndex);
            configuringMarker.End();
        }

        static readonly ProfilerMarker initiatingUnloadMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.InitiateAsyncUnloadOfAssetChunk");
        public sealed override void OnInitiatingAssetChunkUnload(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            initiatingUnloadMarker.Begin();
        }

        public sealed override void OnAssetChunkUnloadInitiated(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            initiatingUnloadMarker.End();
        }

        public sealed override void OnInitiatingAssetChunkDeintegrate(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            
        }

        public sealed override void OnAssetChunkUnloaded(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            
        }

        static readonly ProfilerMarker destroyMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.DestroyAssetChunk");
        public sealed override void OnDestroyingAssetChunkOrChildren(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            destroyMarker.Begin();
        }

        public sealed override void OnAssetChunkOrChildrenDestroyed(WorldCell worldCellOfChunk, int chunkIndex) 
        {
            destroyMarker.End();
        }

        static readonly ProfilerMarker releaseMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.ReleaseAssetChunkHandle");
        public sealed override void OnReleasingAssetChunkHandle(WorldCell worldCellOfChunk, int chunkIndex)
        {
            releaseMarker.Begin();
        }

        public sealed override void OnAssetChunkHandleReleased(WorldCell worldCellOfChunk, int chunkIndex)
        {
            releaseMarker.End();
        }

        static readonly ProfilerMarker activateMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.ActivateAssetChunk");
        static readonly ProfilerMarker deactivateMarker = new ProfilerMarker(ProfilerCategory.Loading, "SAM.DeactivateAssetChunk");
        public sealed override void OnSettingAssetChunkActiveState(WorldCell worldCellOfChunk, int chunkIndex, bool isActive) 
        {
            if(isActive)
            {
                activateMarker.Begin();
                if (timingDataTracker != null)
                    timingDataTracker.OnActivatingAssetChunk(worldCellOfChunk, chunkIndex);
            }
            else
            {
                deactivateMarker.Begin();
                if (timingDataTracker != null)
                    timingDataTracker.OnDeactivatingAssetChunk(worldCellOfChunk, chunkIndex);
            }
        }

        public sealed override void OnAssetChunkActiveStateSet(WorldCell worldCellOfChunk, int chunkIndex, bool isActive) 
        {
            if (isActive)
            {
                if (timingDataTracker != null)
                    timingDataTracker.OnAssetChunkActivated(worldCellOfChunk, chunkIndex);
                activateMarker.End();
            }
            else
            {
                if (timingDataTracker != null)
                    timingDataTracker.OnAssetChunkDeactivated(worldCellOfChunk, chunkIndex);
                deactivateMarker.End();
            }
        }

#else
        public sealed override void OnSAMInitializing(){ }
        public sealed override void OnInitiatingAssetChunkLoad(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkLoadInitiated(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnInitiatingAssetChunkIntegrate(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkLoaded(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnConfiguringAssetChunk(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkConfigured(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnInitiatingAssetChunkUnload(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkUnloadInitiated(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnInitiatingAssetChunkDeintegrate(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkUnloaded(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnDestroyingAssetChunkOrChildren(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkOrChildrenDestroyed(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnReleasingAssetChunkHandle(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnAssetChunkHandleReleased(WorldCell worldCellOfChunk, int chunkIndex){}
        public sealed override void OnSettingAssetChunkActiveState(WorldCell worldCellOfChunk, int chunkIndex, bool isActive){}
        public sealed override void OnAssetChunkActiveStateSet(WorldCell worldCellOfChunk, int chunkIndex, bool isActive){}
#endif
    }
}