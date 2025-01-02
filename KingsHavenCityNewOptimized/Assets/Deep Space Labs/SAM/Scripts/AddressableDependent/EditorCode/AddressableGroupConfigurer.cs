//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEditor;
    using UnityEditor.AddressableAssets.Settings;
    using UnityEditor.AddressableAssets;
    using DeepSpaceLabs.SAM;
    using System;
    using DeepSpaceLabs.EditorCore;

    [CustomEditor(typeof(AddressableGroupConfigurer))]
    public class AddressableGroupConfigurerEditor : Editor
    {
        AddressableGroupConfigurerBaseEditor baseEditor;
        public override void OnInspectorGUI()
        {
            if (baseEditor == null)
                baseEditor = new AddressableGroupConfigurerBaseEditor(serializedObject);

            baseEditor.OnInspectorGUI();
        }
    }

    public class AddressableGroupConfigurerBaseEditor : BaseEditor
    {
        public AddressableGroupConfigurerBaseEditor(SerializedObject serializedObject) : base(serializedObject)
        {
            string globalID = GlobalObjectId.GetGlobalObjectIdSlow(SerializedObject.targetObject).ToString();
            inputGroupToShowKey = $"SAM_AddGroupConfigurer_{globalID}_inputGroupToShow";
        }

        Dictionary<Cell, List<AddressableAssetEntry>> usedCellTracker;
        HashSet<int> usedLayers, usedRows, usedColumns;
        string inputGroupToShowKey;
        protected override void DrawInspector()
        {
            helper.DrawSerializedPropertyField("addressableSettings", addressableSettingsLabel);
            helper.DrawSerializedPropertyField("configurationType", configurationTypeLabel);

            DrawInputGroups();
            DrawSpace();
            int configType = helper.GetPropertyByName("configurationType").intValue;
            if (configType == 0)
            {
                helper.DrawSerializedPropertyField("addLayerLabels", addLayerLabelsLabel);
                helper.DrawSerializedPropertyField("addRowLabels", addRowLabelsLabel);
                helper.DrawSerializedPropertyField("addColumnLabels", addColumnLabelsLabel);
                helper.DrawSerializedPropertyField("additionalLabelsToAdd", additionalLabelsToAddLabel);

                DrawSpace();
                if (GUILayout.Button("Add Labels"))
                    AddLabelsOnly();
            }
            else
            {
                if (GUILayout.Button("Clear Labels"))
                    ClearLabels();
            }
        }

        void DrawInputGroups()
        {
            var inputGroupsProp = helper.GetPropertyByName("inputGroups");
            int numGroupings = inputGroupsProp.arraySize;

            DrawVeryLargeBoldInspectorTitle($"{numGroupings} Input Groups Present");
            DrawSpace();
            if (GUILayout.Button("Add Input Group"))
            {
                ChangeNumOfInputGroups(inputGroupsProp, numGroupings, numGroupings + 1);
                SessionState.SetInt(inputGroupToShowKey, numGroupings);
                numGroupings++;
                ClearKeyboardFocus();
            }

            int previouslyShownInputGroupIndex = SessionState.GetInt(inputGroupToShowKey, 0);
            if (previouslyShownInputGroupIndex < 0)
                previouslyShownInputGroupIndex = 0;
            int newInputGroupToShow = DrawSerializedArrayButtons(previouslyShownInputGroupIndex, inputGroupsProp, "Input Group\n{0}");

            if (numGroupings == 1)
            {
                GUILayout.Button(cannotRemoveLabel);
            }
            else if (GUILayout.Button($"Remove Input Group {newInputGroupToShow + 1}"))
            {
                ClearKeyboardFocus();
                inputGroupsProp.DeleteArrayElementAtIndex(newInputGroupToShow);
                if (newInputGroupToShow >= inputGroupsProp.arraySize)
                    newInputGroupToShow = inputGroupsProp.arraySize - 1;
            }

            if (newInputGroupToShow != previouslyShownInputGroupIndex)
            {
                ClearKeyboardFocus();
                SessionState.SetInt(inputGroupToShowKey, newInputGroupToShow);
            }

            DrawSpace();
            DrawDivider();
            DrawInputGroup(inputGroupsProp, newInputGroupToShow);
        }

        void ChangeNumOfInputGroups(SerializedProperty inputGroupsProp, int previousNumberOfInputGroups, int newNumberOfInputGroups)
        {
            inputGroupsProp.arraySize = newNumberOfInputGroups;

            if (newNumberOfInputGroups > previousNumberOfInputGroups)
            {
                for (int i = previousNumberOfInputGroups; i < newNumberOfInputGroups; i++)
                {
                    var inputGroupProp = inputGroupsProp.GetArrayElementAtIndex(i);
                    helper.GetNestedPropertyByName(inputGroupProp, "group").objectReferenceValue = null;
                    helper.GetNestedPropertyByName(inputGroupProp, "groupStreamableGrid").objectReferenceValue = null;
                    helper.GetNestedPropertyByName(inputGroupProp, "groupLOD").intValue = 1;
                    helper.GetNestedPropertyByName(inputGroupProp, "addressPrependedString").stringValue = "";
                    helper.GetNestedPropertyByName(inputGroupProp, "addressAppendedString").stringValue = "";
                }
            }
        }

        void DrawInputGroup(SerializedProperty groupingStatesProp, int groupingToDraw)
        {
            var inputGroupProp = groupingStatesProp.GetArrayElementAtIndex(groupingToDraw);
            DrawSpace();

            helper.DrawNestedSerializedPropertyField(inputGroupProp, "group");
            helper.DrawNestedSerializedPropertyField(inputGroupProp, "groupStreamableGrid");

            var streamableGrid = helper.GetNestedPropertyByName(inputGroupProp, "groupStreamableGrid").objectReferenceValue as StreamableGrid;
            if (streamableGrid != null)
            {
                helper.DrawSerializedPropertyIntSlider(helper.GetNestedPropertyByName(inputGroupProp, "groupLOD"), groupLODLabel, 1, streamableGrid.LevelsOfDetail_PreInitSafe);
            }
            else
                DrawBoldLabel("LOD: Add a Streamable Grid to set LOD");

            helper.DrawNestedSerializedPropertyField(inputGroupProp, "addressPrependedString");
            helper.DrawNestedSerializedPropertyField(inputGroupProp, "addressAppendedString");
        }

        void AddLabelsOnly()
        {
            var configurer = (AddressableGroupConfigurer)SerializedObject.targetObject;

            if (!VerifySetup(configurer, true, out var settings))
                return;

            InitializeCollections();

            List<AddressableAssetEntry> entries = new List<AddressableAssetEntry>();
            foreach (var inputGrouping in configurer.inputGroups)
            {
                var lodDetails = inputGrouping.groupStreamableGrid.GetLODDetails_PreInitSafe(inputGrouping.groupLOD);
                bool isLOD3D = inputGrouping.groupStreamableGrid.Axes_PreInitSafe == Axes.Three_Dimensional;
                string prependedString = inputGrouping.addressPrependedString == null || inputGrouping.addressPrependedString == "" ? null : inputGrouping.addressPrependedString;

                string appendedString = inputGrouping.addressAppendedString == null || inputGrouping.addressAppendedString == "" ? null : inputGrouping.addressAppendedString;

                Func<string, string> GetChunkNameFromAddress;
                if (prependedString != null)
                {
                    if (appendedString != null)
                        GetChunkNameFromAddress = (address) => address.Replace(prependedString, "").Replace(appendedString, "");
                    else
                        GetChunkNameFromAddress = (address) => address.Replace(prependedString, "");
                }
                else if (appendedString != null)
                    GetChunkNameFromAddress = (address) => address.Replace(appendedString, "");
                else
                    GetChunkNameFromAddress = (address) => address;

                //even though there might be prepended/appended string data, we leave that out of the cell string. Instead we will remove it from the 
                //addresses
                CellString cellString = new CellString(lodDetails.GroupName_PreInitSafe, lodDetails.NamingConvention_PreInitSafe(isLOD3D), isLOD3D, lodDetails.UtilizesMultiChunking_PreInitSafe, null, null);

                inputGrouping.group.GatherAllAssets(entries, true, false, false);
                foreach (var assetEntry in entries)
                {
                    //assetEntry.labels.Clear();only clear asset chunk lables?
                    var chunkName = GetChunkNameFromAddress(assetEntry.address);
                    if (cellString.TryGetCellDataFromChunkName(chunkName, out int row, out int column, out int layer, out int chunkIndex))
                    {
                        assetEntry.labels.Clear();

                        Cell cell = new Cell(row, column, layer);
                        if (!usedCellTracker.TryGetValue(cell, out var assetEntriesForCell))
                        {
                            assetEntriesForCell = new List<AddressableAssetEntry>();
                            usedCellTracker.Add(cell, assetEntriesForCell);
                        }

                        assetEntriesForCell.Add(assetEntry);
                        usedLayers.Add(layer);
                        usedRows.Add(row);
                        usedColumns.Add(column);
                    }
                }

                entries.Clear();
            }

            AddLabels(configurer, settings);
            ClearCollections();
        }

        void ClearLabels()
        {
            var configurer = (AddressableGroupConfigurer)SerializedObject.targetObject;

            if (!VerifySetup(configurer, false, out var settings))
                return;

            InitializeCollections();

            List<AddressableAssetEntry> entries = new List<AddressableAssetEntry>();
            foreach (var inputGrouping in configurer.inputGroups)
            {
                var lodDetails = inputGrouping.groupStreamableGrid.GetLODDetails_PreInitSafe(inputGrouping.groupLOD);
                bool isLOD3D = inputGrouping.groupStreamableGrid.Axes_PreInitSafe == Axes.Three_Dimensional;
                string prependedString = inputGrouping.addressPrependedString == null || inputGrouping.addressPrependedString == "" ? null : inputGrouping.addressPrependedString;

                string appendedString = inputGrouping.addressAppendedString == null || inputGrouping.addressAppendedString == "" ? null : inputGrouping.addressAppendedString;

                Func<string, string> GetChunkNameFromAddress;
                if (prependedString != null)
                {
                    if (appendedString != null)
                        GetChunkNameFromAddress = (address) => address.Replace(prependedString, "").Replace(appendedString, "");
                    else
                        GetChunkNameFromAddress = (address) => address.Replace(prependedString, "");
                }
                else if (appendedString != null)
                    GetChunkNameFromAddress = (address) => address.Replace(appendedString, "");
                else
                    GetChunkNameFromAddress = (address) => address;

                //even though there might be prepended/appended string data, we leave that out of the cell string. Instead we will remove it from the 
                //addresses
                CellString cellString = new CellString(lodDetails.GroupName_PreInitSafe, lodDetails.NamingConvention_PreInitSafe(isLOD3D), isLOD3D, lodDetails.UtilizesMultiChunking_PreInitSafe, null, null);

                inputGrouping.group.GatherAllAssets(entries, true, false, false);
                foreach (var assetEntry in entries)
                {
                    //assetEntry.labels.Clear();only clear asset chunk lables?
                    var chunkName = GetChunkNameFromAddress(assetEntry.address);
                    if (cellString.TryGetCellDataFromChunkName(chunkName, out int row, out int column, out int layer, out int chunkIndex))
                    {
                        assetEntry.labels.Clear();
                    }
                }

                entries.Clear();
            }

            ClearCollections();
        }

        bool VerifySetup(AddressableGroupConfigurer configurer, bool requireLabels, out AddressableAssetSettings assetSettings)
        {
            assetSettings = configurer.GetSettings();
            if (assetSettings == null)
                return false;

            bool allInputGroupingsValid = true;
            for (int i = 0; i < configurer.inputGroups.Length; i++)
            {
                var inputGrouping = configurer.inputGroups[i];
                if (inputGrouping.group == null)
                {
                    allInputGroupingsValid = false;
                    Debug.LogError($"Input Grouping at Index {i} has a null Addressable Asset Group!");
                }

                if (inputGrouping.groupStreamableGrid == null)
                {
                    allInputGroupingsValid = false;
                    Debug.LogError($"Input Grouping at Index {i} has a null Streamable Grid!");
                }
            }

            bool otherSettingsValid = true;

            if (requireLabels && !configurer.addLayerLabels && !configurer.addRowLabels && !configurer.addColumnLabels && (configurer.additionalLabelsToAdd == null || configurer.additionalLabelsToAdd.Length == 0))
            {
                otherSettingsValid = false;
                Debug.LogError($"No Labels have been configured to be added! The tool would do nothing if run at the moment.");
            }

            return allInputGroupingsValid && otherSettingsValid;
        }

        void AddLabels(AddressableGroupConfigurer configurer, AddressableAssetSettings assetSettings)
        {
            Action<AddressableAssetEntry, string> SetOrDontSetLayerLabel, SetOrDontSetRowLabel, SetOrDontSetColumnLabel;
            Action<AddressableAssetEntry> SetOrDontSetAdditionalLabels;

            if (configurer.addLayerLabels)
            {
                foreach (var layer in usedLayers)
                    assetSettings.AddLabel($"L{layer}");
                SetOrDontSetLayerLabel = (assetEntry, layerLabel) => assetEntry.SetLabel(layerLabel, true);
            }
            else
                SetOrDontSetLayerLabel = (assetEntry, layerLabel) => { };

            if (configurer.addRowLabels)
            {
                foreach (var row in usedRows)
                    assetSettings.AddLabel($"R{row}");

                SetOrDontSetRowLabel = (assetEntry, rowLabel) => assetEntry.SetLabel(rowLabel, true);
            }
            else
                SetOrDontSetRowLabel = (assetEntry, layerLabel) => { };

            if (configurer.addColumnLabels)
            {
                foreach (var column in usedColumns)
                    assetSettings.AddLabel($"C{column}");

                SetOrDontSetColumnLabel = (assetEntry, columnLabel) => assetEntry.SetLabel(columnLabel, true);
            }
            else
                SetOrDontSetColumnLabel = (assetEntry, layerLabel) => { };

            if (configurer.additionalLabelsToAdd != null && configurer.additionalLabelsToAdd.Length > 0)
            {
                for (int i = 0; i < configurer.additionalLabelsToAdd.Length; i++)
                    assetSettings.AddLabel(configurer.additionalLabelsToAdd[i]);

                SetOrDontSetAdditionalLabels = (assetEntry) =>
                {
                    for (int i = 0; i < configurer.additionalLabelsToAdd.Length; i++)
                        assetEntry.SetLabel(configurer.additionalLabelsToAdd[i], true);
                };
            }
            else
                SetOrDontSetAdditionalLabels = (assetEntry) => { };

            var en = usedCellTracker.GetEnumerator();
            while (en.MoveNext())
            {
                var cell = en.Current.Key;
                var assetEntriesNeedingLabel = en.Current.Value;

                string layerLabel = $"L{cell.Layer}";
                string rowLabel = $"R{cell.Row}";
                string columnLabel = $"C{cell.Column}";

                foreach (var assetEntry in assetEntriesNeedingLabel)
                {
                    SetOrDontSetLayerLabel(assetEntry, layerLabel);
                    SetOrDontSetRowLabel(assetEntry, rowLabel);
                    SetOrDontSetColumnLabel(assetEntry, columnLabel);
                    SetOrDontSetAdditionalLabels(assetEntry);
                }
            }
        }

        void InitializeCollections()
        {
            if (usedCellTracker == null)
                usedCellTracker = new Dictionary<Cell, List<AddressableAssetEntry>>();

            if (usedLayers == null)
                usedLayers = new HashSet<int>();

            if (usedRows == null)
                usedRows = new HashSet<int>();

            if (usedColumns == null)
                usedColumns = new HashSet<int>();
        }

        void ClearCollections()
        {
            usedCellTracker.Clear();
            usedLayers.Clear();
            usedRows.Clear();
            usedColumns.Clear();
        }

        #region Labels
        readonly GUIContent addLayerLabelsLabel = new GUIContent("Add Layer Labels*", "Add Layer Labels\n\nIf enabled, will add a label called L# to each Asset Chunk, where # is replaced by the layer of the Cell the Asset Chunk belongs to.");

        readonly GUIContent addRowLabelsLabel = new GUIContent("Add Row Labels*", "Add Row Labels\n\nIf enabled, will add a label called R# to each Asset Chunk, where # is replaced by the row of the Cell the Asset Chunk belongs to.");

        readonly GUIContent addColumnLabelsLabel = new GUIContent("Add Column Labels*", "Add Column Labels\n\nIf enabled, will add a label called C# to each Asset Chunk, where # is replaced by the column of the Cell the Asset Chunk belongs to.");

        readonly GUIContent addressableSettingsLabel = new GUIContent("Addressable Settings*", "Addressable Settings\nThe settings object with the group(s) you want to configure. If you leave it null, the Default Settings object will be used.");

        readonly GUIContent additionalLabelsToAddLabel = new GUIContent("Additional Labels To Add*", "Additional Labels To Add\n\nAdditional labels that will be added to each Addressable Asset Chunk.");

        readonly GUIContent cannotRemoveLabel = new GUIContent("Cannot Remove*", "Removing this Input Group will leave 0 Input Groups, which is not allowed!");

        readonly GUIContent configurationTypeLabel = new GUIContent("Configuration Type*", "Configuration Type\nThe type of configuration operation to run.\n\nAdd Labels will adds labels corresponding to the cell row/column/layer (if 3D) of each Asset Chunk in each Input Group (if those settings are enabled), plus any additional labels, while Clear Labels will clear all labels (only for the Asset Chunks in each Input Grouping).");

        readonly GUIContent groupLODLabel = new GUIContent("Group LOD*", "Group LOD\n\nThe LOD of the Group (can be found on the Streamable Grid). Each LOD Group of Asset Chunks must be contained in a separate Addressable Group for this tool to work correctly!");
        #endregion

        [MenuItem(SAM.GlobalValues.ASSET_CREATION_PATH + "Addressable Group Configurer", false)]
        public static void CreateAddressableGroupConfigurer()
        {
            ScriptableObjectAssetCreator.GenerateScriptableObjectAssetAtSelectedFolder<AddressableGroupConfigurer>("AddressableGroupConfigurer");
        }
    }

    public class AddressableGroupConfigurer : ScriptableObject
    {
        [SerializeField]
        AddressableAssetSettings addressableSettings;

        enum ConfigurationType { AddLabels, ClearLabels }
        [SerializeField]
        ConfigurationType configurationType;

        //Add Labels configuration type


        //Setup Dependencies configuration type

        [SerializeField]
        public AddressableInputGroup[] inputGroups = new AddressableInputGroup[1] { new AddressableInputGroup() };

        [SerializeField]
        public bool addLayerLabels = true, addRowLabels = true, addColumnLabels = true;

        [SerializeField]
        public string[] additionalLabelsToAdd;

        [SerializeField]
        AddressableAssetGroupTemplate sharedGroupTemplate;

        public AddressableAssetSettings GetSettings()
        {
            AddressableAssetSettings settings = addressableSettings;
            if (settings == null)
            {
                settings = AddressableAssetSettingsDefaultObject.Settings;
                if (settings == null)
                {
                    Debug.LogError($"Could not locate a valid Addressable Asset Settings in your project. Open the Groups window via Window -> Asset Management -> Addressables -> Groups to create/set an addressable settings asset.");
                }
            }
            return settings;
        }
    }

    [System.Serializable]
    public class AddressableInputGroup
    {
        [SerializeField]
        public AddressableAssetGroup group;

        [SerializeField]
        public StreamableGrid groupStreamableGrid;

        [SerializeField]
        public int groupLOD = 1;

        [SerializeField]
        public string addressPrependedString, addressAppendedString;
    }
}
