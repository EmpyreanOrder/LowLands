//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine;
    using UnityEngine.UI;
    using DeepSpaceLabs.Core;

    /// <summary>
    /// A SAMText implementation that leverages the UnityUISAMText component to update text. This is primarily used 
    /// by the SAMInitializer to update the initialization progress text.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Secondary Components/Unity UI SAM Text")]
    [HelpURL(GlobalValues.API_URL + "UnityUISAMText.html")]
    public class UnityUISAMText : SAMText
    {
        [SerializeField, FieldRename("Text*", "Text\n\nThe text whose value will be adjusted when SetText is called.\n\nIf you place this component on the same game object as the Text component, there is no need to manually assign the text to this field.")]
        Text text;

        void Awake()
        {
            if (text == null)
                text = GetComponent<Text>();
        }

        public override void SetText(string value)
        {
            text.text = value;
        }
    }
}