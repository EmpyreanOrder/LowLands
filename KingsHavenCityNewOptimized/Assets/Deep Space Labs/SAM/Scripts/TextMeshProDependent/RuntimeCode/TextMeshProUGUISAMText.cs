//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine;
    using TMPro;
    using DeepSpaceLabs.Core;

    /// <summary>
    /// A SAMText implementation that leverages the TextMeshProUGUISAMText component to update text. This is primarily used 
    /// by the SAMInitializer to update the initialization progress text.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Secondary Components/Text Mesh Pro UGUI SAM Text")]
    [HelpURL(GlobalValues.API_URL + "TextMeshProUGUISAMText.html")]
    public class TextMeshProUGUISAMText : SAMText
    {
        [SerializeField, FieldRename("Text*", "Text\n\nThe TextMeshProUGUI component whose value will be adjusted when SetText is called.\n\nIf you place this component on the same game object as the TextMeshProUGUI component, there is no need to manually assign the text to this field.\n\nIf using a TextMeshPro component, use the TextMeshProSAMText component instead.")]
        TextMeshProUGUI text;

        void Awake()
        {
            if (text == null)
                text = GetComponent<TextMeshProUGUI>();
        }

        public override void SetText(string value)
        {
            text.text = value;
        }
    }
}