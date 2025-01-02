//SAM - Streamable Assets Manager copyright © 2023 Kyle Gillen - Deep Space Labs. All rights reserved. Redistribution is not allowed.
namespace DeepSpaceLabs.SAM
{
    using UnityEngine;
    using UnityEngine.UI;
    using DeepSpaceLabs.Core;

    /// <summary>
    /// A SAMSlider implementation that leverages the UnityEngine.UI.Slider component to update a slider value. This is primarily used 
    /// by the SAMInitializer to update the initialization progress.
    /// </summary>
    [AddComponentMenu(GlobalValues.COMPONENT_ROOT_PATH + "Secondary Components/Unity UI SAM Slider")]
    [HelpURL(GlobalValues.API_URL + "UnityUISAMSlider.html")]
    public class UnityUISAMSlider : SAMSlider
    {
        [SerializeField, FieldRename("Slider*", "Slider\n\nThe slider whose value will be adjusted when SetSliderValue is called.\n\nIf you place this component on the same game object as the Slider component, there is no need to manually assign the slider to this field.")]
        Slider slider;

        void Awake()
        {
            if(slider == null)
                slider = GetComponent<Slider>();
        }

        public override void SetSliderValue(float value)
        {
            slider.value = value;
        }
    }
}