//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.EditorSAM
{
    using DeepSpaceLabs.EditorCore;
    using DeepSpaceLabs.SAM;
    using UnityEditor;
    using UnityEngine;

    [CustomEditor(typeof(ConditionalMembersImplementation))]
    public class ConditionalMembersImplementationEditor : Editor
    {
        public override void OnInspectorGUI()
        {
            EditorGUILayout.HelpBox("This component serves a bridge between code contained in the SAM.DLL and code that depends on Unity Preprocess Directives. Please do not delete this asset from the Resources folder!\n\nYou can move the Resources folder, or move the Conditional Members asset to a different Resources folder, however note that when you use the 'Regenerate Conditional Members Implementation' command (Assets -> Deep Space Labs -> SAM), the asset will always be generated in Assets/Deep Space Labs/SAM/Resources.", MessageType.Warning);
        }

        [MenuItem(GlobalValues.ACTIONS_MENU_PATH + "Regenerate Conditional Members Implementation", true, 7)]
        static bool ShouldRegenerateConditionalMembersImplementation()
        {
            return Resources.Load<ConditionalMembersImplementation>("ConditionalMembers_DoNotDeleteOrRename") == null;
        }

        [MenuItem(GlobalValues.ACTIONS_MENU_PATH + "Regenerate Conditional Members Implementation", false, 7)]
        static void RegenerateConditionalMembersImplementation()
        {
            string filePath = $"Assets/Deep Space Labs/SAM/Resources/ConditionalMembers_DoNotDeleteOrRename.asset";
            ScriptableObjectAssetCreator.CreateAsset<ConditionalMembersImplementation>(filePath);
            AssetDatabase.ImportAsset(filePath);
        }
    }
}