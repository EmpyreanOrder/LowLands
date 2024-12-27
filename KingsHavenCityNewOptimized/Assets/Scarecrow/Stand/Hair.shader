Shader "Custom/HairShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [NoScaleOffset] _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [NoScaleOffset] _NormalMap ("Normal Map", 2D) = "bump" {}
        [NoScaleOffset] _SpecularMap ("Specular Map", 2D) = "white" {}
        [NoScaleOffset] _AlphaMap ("Alpha Map", 2D) = "white" {}
        [NoScaleOffset] _AOMap ("AO Map", 2D) = "white" {}
        [NoScaleOffset] _ColorVarianceMap ("Color Variance Map", 2D) = "white" {}

        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _SpecularIntensity ("Specular Intensity", Range(0,1)) = 0.5
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _RimColor ("Rim Color", Color) = (1,1,1,1)
        _RimPower ("Rim Power", Range(0.1, 8.0)) = 3.0
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
        _AOIntensity ("AO Intensity", Range(0, 1)) = 1.0
        _ColorVarianceIntensity ("Color Variance Intensity", Range(0, 1)) = 1.0
        _ColorVarianceTint ("Color Variance Tint", Color) = (1, 1, 1, 1)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="TransparentCutout" "IgnoreProjector"="True" }
        LOD 300
        Blend SrcAlpha OneMinusSrcAlpha
        AlphaTest Greater [_Cutoff]
        Cull Off
        ZWrite On

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade addshadow
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _SpecularMap;
        sampler2D _AlphaMap;
        sampler2D _AOMap;
        sampler2D _ColorVarianceMap;

        half _Glossiness;
        half _SpecularIntensity;
        fixed4 _Color;
        fixed4 _SpecularColor;
        fixed4 _RimColor;
        half _RimPower;
        half _Cutoff;
        half _AOIntensity;
        half _ColorVarianceIntensity;
        fixed4 _ColorVarianceTint;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float2 uv_SpecularMap;
            float2 uv_AlphaMap;
            float2 uv_AOMap;
            float2 uv_ColorVarianceMap;
            float3 worldPos; // Add world position to Input
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

            // Color Variance
            fixed4 colorVarianceTex = tex2D(_ColorVarianceMap, IN.uv_ColorVarianceMap);
            c.rgb = lerp(c.rgb, _ColorVarianceTint.rgb, colorVarianceTex.r * _ColorVarianceIntensity);

            // AO
            fixed4 aoTex = tex2D(_AOMap, IN.uv_AOMap);
            c.rgb *= lerp(1.0, aoTex.r, _AOIntensity);

            o.Albedo = c.rgb;

            // Normal
            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));

            // Specular (using Metallic and Smoothness)
            fixed4 specular = tex2D(_SpecularMap, IN.uv_SpecularMap);
            o.Metallic = specular.r * _SpecularIntensity;
            o.Smoothness = _Glossiness;

            // Alpha
            fixed4 alphaTex = tex2D(_AlphaMap, IN.uv_AlphaMap);
            o.Alpha = alphaTex.r;

            // Rim lighting
            float3 viewDir = normalize(_WorldSpaceCameraPos - IN.worldPos); // Use worldPos from Input
            float rim = 1.0 - saturate(dot(o.Normal, viewDir));
            o.Emission = _RimColor.rgb * pow(rim, _RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
