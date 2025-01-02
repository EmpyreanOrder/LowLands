//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine;
    using TMPro;
    using DeepSpaceLabs.Core;

    /// <summary>
    /// A SAMText implementation that leverages the TextMeshPro component to update text. This is primarily used 
    /// by the SAMInitializer to update the initialization progress text.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Secondary Components/Text Mesh Pro SAM Text")]
    [HelpURL(GlobalValues.API_URL + "TextMeshProSAMText.html")]
    public class TextMeshProSAMText : SAMText
    {
        [SerializeField, FieldRename("Text*", "Text\n\nThe TextMeshPro component whose value will be adjusted when SetText is called.\n\nIf you place this component on the same game object as the TextMeshPro component, there is no need to manually assign the text to this field.\n\nIf using a TextMeshProUGUI component, use the TextMeshProUGUISAMText component instead.")]
        TextMeshPro text;

        void Awake()
        {
            if (text == null)
                text = GetComponent<TextMeshPro>();
        }

        public override void SetText(string value)
        {
            text.text = value;
        }
    }
}
