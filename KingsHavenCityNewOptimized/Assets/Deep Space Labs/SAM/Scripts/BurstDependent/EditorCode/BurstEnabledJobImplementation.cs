//SAM - Stremable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using System;
    using Unity.Collections;
    using Unity.Collections.LowLevel.Unsafe;
    using Unity.Jobs;
    using UnityEditor;
    using DeepSpaceLabs.EditorCore;
    using DeepSpaceLabs.SAM;
    using UnityEngine;
    using Unity.Burst;

    public class BurstEnabledJobImplementation : BurstAffectedJobBase
    {
        [MenuItem(GlobalValues.ACTIONS_MENU_PATH + "Regenerate Burst Enabled Job Implementation", true, 4)]
        static bool RegenerateBurstEnabledJobImpValidate()
        {
            string filePath = $"{GlobalValues.EDITOR_RESOURCES_PATH}ScriptableAssets/BurstEnabledJobImplementation.asset";
            return AssetDatabase.LoadAssetAtPath<BurstEnabledJobImplementation>(filePath) == null;
        }

        [MenuItem(GlobalValues.ACTIONS_MENU_PATH + "Regenerate Burst Enabled Job Implementation", false, 4)]
        static void RegenerateBurstEnabledJobImp()
        {
            string filePath = $"{GlobalValues.EDITOR_RESOURCES_PATH}ScriptableAssets/BurstEnabledJobImplementation.asset";
            ScriptableObjectAssetCreator.CreateAsset<BurstEnabledJobImplementation>(filePath);
            AssetDatabase.ImportAsset(filePath);
        }

        public sealed override JobHandle GetSetupPrimaryOpaqueElementsJob(NativeArray<int> primaryOpaqueIndexes, NativeArray<OpaqueMainVisualElement> primaryOpaqueElements, NativeArray<EditorPatternElement> patternElements, int opaqueElementsArrayOffset, int length, int batchSize, int streamableGridRows, int streamableGridColumns, int streamableGridLayers, Cell dnaCell, bool usesLayers, bool clampIndexesForDisplay, bool hasDep = false, JobHandle dep = default)
        {
            var j = new SetupPrimaryOpaqueElements()
            {
                primaryOpaqueIndexes = primaryOpaqueIndexes,
                primaryOpaqueElements = primaryOpaqueElements,
                patternElements = patternElements,
                opaqueElementsArrayOffset = opaqueElementsArrayOffset,
                streamableGridRows = streamableGridRows,
                streamableGridColumns = streamableGridColumns,
                streamableGridLayers = streamableGridLayers,
                usesLayers = usesLayers,
                clampIndexesForDisplay = clampIndexesForDisplay,
                dnaCell = dnaCell
            };

            if (hasDep)
                return j.Schedule(length, batchSize, dep);
            else
                return j.Schedule(length, batchSize);
        }

        public sealed override JobHandle GetSetupPrimaryTransparentElementsJob(NativeArray<int> primaryTransparentIndexes, NativeArray<TransparentVisualElement> primaryTransparentElements, NativeArray<EditorPatternElement> patternElements, int transparentElementsArrayOffset, int length, int batchSize, int streamableGridRows, int streamableGridColumns, int streamableGridLayers, Cell dnaCell, bool hasDep = false, JobHandle dep = default)
        {
            var j = new SetupPrimaryTransparentElements()
            {
                primaryTransparentIndexes = primaryTransparentIndexes,
                primaryTransparentElements = primaryTransparentElements,
                patternElements = patternElements,
                transparentElementsArrayOffset = transparentElementsArrayOffset,
                streamableGridRows = streamableGridRows,
                streamableGridColumns = streamableGridColumns,
                streamableGridLayers = streamableGridLayers,
                dnaCell = dnaCell
            };

            if (hasDep)
                return j.Schedule(length, batchSize, dep);
            else
                return j.Schedule(length, batchSize);
        }

        public sealed override JobHandle GetSetupPrimaryOutlineElementsJob(NativeArray<int> outlineIndexes, NativeArray<OpaqueOutlineVisualElement> outlineElements, NativeArray<EditorPatternElement> patternElements, int outlineElementsArrayOffset, int length, int batchSize, bool hasDep = false, JobHandle dep = default)
        {
            var j = new SetupPrimaryOutlineElements()
            {
                outlineIndexes = outlineIndexes,
                outlineElements = outlineElements,
                patternElements = patternElements,
                outlineElementsArrayOffset = outlineElementsArrayOffset
            };

            if (hasDep)
                return j.Schedule(length, batchSize, dep);
            else
                return j.Schedule(length, batchSize);
        }

        public sealed override JobHandle GetSetupPrimaryAndSecondaryOutlineElementsJob(NativeArray<int> outlineIndexes, NativeArray<OpaqueOutlineVisualElement> outlineElements, NativeArray<Matrix4x4> secondaryOutlineMatrices, NativeArray<EditorPatternElement> patternElements, int outlineElementsArrayOffset, int length, int batchSize, bool hasDep = false, JobHandle dep = default)
        {
            var j = new SetupPrimaryAndSecondaryOutlineElements()
            {
                outlineIndexes = outlineIndexes,
                outlineElements = outlineElements,
                secondaryOutlineMatrices = secondaryOutlineMatrices,
                patternElements = patternElements,
                outlineElementsArrayOffset = outlineElementsArrayOffset
            };

            if (hasDep)
                return j.Schedule(length, batchSize, dep);
            else
                return j.Schedule(length, batchSize);
        }

        [BurstCompile]
        struct SetupPrimaryOpaqueElements : IJobParallelFor
        {
            [ReadOnly, DeallocateOnJobCompletion] public NativeArray<int> primaryOpaqueIndexes;
            [WriteOnly, NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<OpaqueMainVisualElement> primaryOpaqueElements;

            [NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<EditorPatternElement> patternElements;

            [ReadOnly] public int opaqueElementsArrayOffset, streamableGridRows, streamableGridColumns, streamableGridLayers;
            [ReadOnly] public bool usesLayers, clampIndexesForDisplay;
            [ReadOnly] public Cell dnaCell;

            public void Execute(int index)
            {
                int elementIndexInContainer = primaryOpaqueIndexes[index];

                var e = patternElements[elementIndexInContainer];

                e.mainActive = true;
                e.primaryVisualStatus = VisualStatus.AddedToOpaque;
                int actualIndex = index + opaqueElementsArrayOffset;
                e.indexInMainVisualContainer = actualIndex;

                long layerIndexToDisplay, rowIndexToDisplay, columnIndexToDisplay, meshIndex;
                if (e.elementType == EditorPatternElement.ElementType.Sectioned)
                {
                    meshIndex = -1;
                    if (clampIndexesForDisplay)
                    {
                        layerIndexToDisplay = Clamp((long)dnaCell.Layer + e.offsetFromDNACell.Layer, streamableGridLayers);
                        rowIndexToDisplay = Clamp((long)dnaCell.Row + e.offsetFromDNACell.Row, streamableGridRows);
                        columnIndexToDisplay = Clamp((long)dnaCell.Column + e.offsetFromDNACell.Column, streamableGridColumns);
                    }
                    else
                    {
                        layerIndexToDisplay = (long)dnaCell.Layer + e.offsetFromDNACell.Layer;
                        rowIndexToDisplay = (long)dnaCell.Row + e.offsetFromDNACell.Row;
                        columnIndexToDisplay = (long)dnaCell.Column + e.offsetFromDNACell.Column;
                    }
                }
                else
                {
                    long layerOnEndlessGrid = (long)dnaCell.Layer + e.offsetFromDNACell.Layer;
                    long rowOnEndlessGrid = (long)dnaCell.Row + e.offsetFromDNACell.Row;
                    long columnOnEndlessGrid = (long)dnaCell.Column + e.offsetFromDNACell.Column;

                    long layerOnWorldGrid = Clamp(layerOnEndlessGrid, streamableGridLayers);
                    long rowOnWorldGrid = Clamp(rowOnEndlessGrid, streamableGridRows);
                    long columnOnWorldGrid = Clamp(columnOnEndlessGrid, streamableGridColumns);
                    meshIndex = (streamableGridRows * streamableGridColumns * layerOnWorldGrid) + (streamableGridColumns * rowOnWorldGrid) + columnOnWorldGrid;

                    if (clampIndexesForDisplay)
                    {
                        layerIndexToDisplay = layerOnWorldGrid;
                        rowIndexToDisplay = rowOnWorldGrid;
                        columnIndexToDisplay = columnOnWorldGrid;
                    }
                    else
                    {
                        layerIndexToDisplay = layerOnEndlessGrid;
                        rowIndexToDisplay = rowOnEndlessGrid;
                        columnIndexToDisplay = columnOnEndlessGrid;
                    }
                }

                primaryOpaqueElements[actualIndex] = e.CreateVisualInfoForOpaqueMainElement(meshIndex, new CellLong(rowIndexToDisplay, columnIndexToDisplay, layerIndexToDisplay), usesLayers);

                patternElements[elementIndexInContainer] = e;
            }
        }

        [BurstCompile]
        struct SetupPrimaryTransparentElements : IJobParallelFor
        {
            [ReadOnly, DeallocateOnJobCompletion] public NativeArray<int> primaryTransparentIndexes;
            [WriteOnly, NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<TransparentVisualElement> primaryTransparentElements;

            [NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<EditorPatternElement> patternElements;

            [ReadOnly] public int transparentElementsArrayOffset, streamableGridRows, streamableGridColumns, streamableGridLayers;
            [ReadOnly] public Cell dnaCell;

            public void Execute(int index)
            {
                int elementIndexInContainer = primaryTransparentIndexes[index];

                var e = patternElements[elementIndexInContainer];

                //unecessary because the index points to a valid element that will be in the viewable area
                //if (!e.inViewableArea)
                //    return;

                e.mainActive = true;
                e.primaryVisualStatus = VisualStatus.AddedToTransparent;
                int actualIndex = index + transparentElementsArrayOffset;
                e.indexInMainVisualContainer = actualIndex;

                long meshIndex = e.elementType == EditorPatternElement.ElementType.Sectioned ? -1L : CalculateMeshIndex(e.offsetFromDNACell);
                primaryTransparentElements[actualIndex] = e.CreateVisualInfoForTransparentMainElement(meshIndex);

                patternElements[elementIndexInContainer] = e;
            }

            long CalculateMeshIndex(Cell offsetFromDNACell)
            {
                long layer = Clamp((long)dnaCell.Layer + offsetFromDNACell.Layer, streamableGridLayers);
                long row = Clamp((long)dnaCell.Row + offsetFromDNACell.Row, streamableGridRows);
                long column = Clamp((long)dnaCell.Column + offsetFromDNACell.Column, streamableGridColumns);

                return (streamableGridRows * streamableGridColumns * layer) + (streamableGridColumns * row) + column;
            }
        }

        [BurstCompile]
        struct SetupPrimaryOutlineElements : IJobParallelFor
        {
            [ReadOnly, DeallocateOnJobCompletion] public NativeArray<int> outlineIndexes;
            [WriteOnly, NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<OpaqueOutlineVisualElement> outlineElements;

            [NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<EditorPatternElement> patternElements;

            [ReadOnly] public int outlineElementsArrayOffset;
            public void Execute(int index)
            {
                int elementIndexInContainer = outlineIndexes[index];

                var e = patternElements[elementIndexInContainer];

                //unecessary because the index points to a valid element that will be in the viewable area
                //if (!e.inViewableArea)
                //    return;

                e.outlineAddedToArray = true;
                int actualIndex = index + outlineElementsArrayOffset;
                e.indexInSecondaryVisualContainer = actualIndex;

                outlineElements[actualIndex] = e.CreateVisualInfoForOpaqueOutline();

                patternElements[elementIndexInContainer] = e;
            }
        }

        [BurstCompile]
        struct SetupPrimaryAndSecondaryOutlineElements : IJobParallelFor
        {
            [ReadOnly, DeallocateOnJobCompletion] public NativeArray<int> outlineIndexes;
            [WriteOnly, NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<OpaqueOutlineVisualElement> outlineElements;
            [WriteOnly, NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<Matrix4x4> secondaryOutlineMatrices;

            [NativeDisableParallelForRestriction, NativeDisableContainerSafetyRestriction] public NativeArray<EditorPatternElement> patternElements;

            [ReadOnly] public int outlineElementsArrayOffset;
            public void Execute(int index)
            {
                int elementIndexInContainer = outlineIndexes[index];

                var e = patternElements[elementIndexInContainer];

                //unecessary because the index points to a valid element that will be in the viewable area
                //if (!e.inViewableArea)
                //    return;

                e.outlineAddedToArray = true;
                int actualIndex = index + outlineElementsArrayOffset;
                e.indexInSecondaryVisualContainer = actualIndex;

                outlineElements[actualIndex] = e.CreateVisualInfoForOpaqueOutline();
                secondaryOutlineMatrices[actualIndex] = e.secondaryOutlineMatrix;

                patternElements[elementIndexInContainer] = e;
            }
        }

        static long Clamp(long value, int indexes)
        {
            return (Math.Abs(value * indexes) + value) % indexes;
        }
    }
}