Shader "Custom/PBRShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [NoScaleOffset] _MainTex ("Albedo (RGB)", 2D) = "white" {}

        _Metallic ("Metallic", Range(0,1)) = 0.0
        [NoScaleOffset] _MetallicMap ("Metallic Map", 2D) = "white" {}
        [KeywordEnum(R, G, B, A)] _MetallicChannel ("Metallic Channel", Float) = 0

        _RoughnessScale ("Roughness Scale", Range(0, 2)) = 1.0
        [NoScaleOffset] _RoughnessMap ("Roughness Map", 2D) = "white" {}
        [KeywordEnum(R, G, B, A)] _RoughnessChannel ("Roughness Channel", Float) = 0

        [NoScaleOffset] _NormalMap ("Normal Map", 2D) = "bump" {}
        [Toggle] _FlipGreenChannel ("Flip Green Channel", Float) = 0
        [NoScaleOffset] _DetailNormalMap ("Detail Normal Map", 2D) = "bump" {}
        [NoScaleOffset] _DetailNormalMask ("Detail Normal Mask", 2D) = "white" {}
        _DetailNormalScale ("Detail Normal Scale", Range(0,1)) = 0.5
        _DetailNormalTiling ("Detail Normal Tiling", Vector) = (1,1,0,0)

        [NoScaleOffset] _AlphaMask ("Alpha Mask (RGB)", 2D) = "white" {}
        [Toggle] _UseAlbedoAlpha ("Use Albedo Alpha", Float) = 0

        [NoScaleOffset] _SSSMask ("SSS Mask", 2D) = "white" {}
        _SSSIntensity ("SSS Intensity", Range(0,1)) = 0.5
        _SSSColor ("SSS Color", Color) = (1,1,1,1)

        [NoScaleOffset] _EmissiveMap ("Emissive Map (RGB)", 2D) = "black" {}
        _EmissiveColor ("Emissive Color", Color) = (0,0,0,1)

        [NoScaleOffset] _AOMap ("Ambient Occlusion Map", 2D) = "white" {}
        [KeywordEnum(R, G, B, A)] _AOChannel ("AO Channel", Float) = 0
        _AOIntensity ("AO Intensity", Range(0,2)) = 1.0

        [Enum(Off, Front, Back, Both)] _Cull ("Render Face", Float) = 2.0
        _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5

        _Panning ("Panning Speed (X, Y)", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags { "Queue"="AlphaTest" "RenderType"="Cutout" "IgnoreProjector"="True" }
        LOD 200
        Cull [_Cull]
        ZWrite On
        AlphaTest Greater [_Cutoff]

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alphatest:_Cutoff

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _DetailNormalMap;
        sampler2D _DetailNormalMask;
        sampler2D _RoughnessMap;
        sampler2D _MetallicMap;
        sampler2D _AlphaMask;
        sampler2D _SSSMask;
        sampler2D _EmissiveMap;
        sampler2D _AOMap;

        float4 _Speed;
        float4 _Panning;
        float _Metallic;
        float _DetailNormalScale;
        float4 _DetailNormalTiling;
        float _UseAlbedoAlpha;
        float _SSSIntensity;
        fixed4 _Color;
        fixed4 _SSSColor;
        float _MetallicChannel;
        float _RoughnessChannel;
        float _RoughnessScale;
        float _FlipGreenChannel;
        fixed4 _EmissiveColor;
        float _AOChannel;
        float _AOIntensity;
        int _Cull;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_DetailNormalMap;
            float2 uv_DetailNormalMask;
            float2 uv_SSSMask;
            float2 uv_EmissiveMap;
            float2 uv_AOMap;
        };

        half GetChannelValue(half4 tex, float channel)
        {
            if (channel == 0) return tex.r;
            if (channel == 1) return tex.g;
            if (channel == 2) return tex.b;
            return tex.a;
        }

        half3 OverlayBlend(half3 baseColor, half3 overlayColor)
        {
            return (baseColor < 0.5) ? (2.0 * baseColor * overlayColor) : (1.0 - 2.0 * (1.0 - baseColor) * (1.0 - overlayColor));
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 pannerUV = IN.uv_MainTex + _Speed.xy * _Time.y + _Panning.xy * _Time.y;

            fixed4 c = tex2D(_MainTex, pannerUV) * _Color;
            o.Albedo = c.rgb;

            fixed4 normalTex = tex2D(_NormalMap, pannerUV);
            if (_FlipGreenChannel > 0)
            {
                normalTex.g = 1.0 - normalTex.g;
            }
            half3 normal = UnpackNormal(normalTex);

            float2 detailUV = IN.uv_DetailNormalMap * _DetailNormalTiling.xy;
            half3 detailNormal = UnpackNormal(tex2D(_DetailNormalMap, detailUV));
            detailNormal = detailNormal * _DetailNormalScale;

            half mask = tex2D(_DetailNormalMask, IN.uv_DetailNormalMask).r;
            detailNormal *= mask;

            half3 overlayNormal = OverlayBlend(normal * 0.5 + 0.5, detailNormal * 0.5 + 0.5);
            o.Normal = normalize(overlayNormal * 2.0 - 1.0);

            half4 roughnessTex = tex2D(_RoughnessMap, pannerUV);
            half roughness = GetChannelValue(roughnessTex, _RoughnessChannel);
            o.Smoothness = 1.0 - roughness * _RoughnessScale;

            half4 metallicTex = tex2D(_MetallicMap, pannerUV);
            half metallic = GetChannelValue(metallicTex, _MetallicChannel);
            o.Metallic = metallic * _Metallic;

            half4 alphaTex = tex2D(_AlphaMask, pannerUV);
            half luminance = dot(alphaTex.rgb, half3(0.299, 0.587, 0.114)); // Use luminance for alpha
            o.Alpha = lerp(luminance, c.a, _UseAlbedoAlpha);

            half sssMask = tex2D(_SSSMask, IN.uv_SSSMask).r;
            o.Albedo += sssMask * _SSSIntensity * _SSSColor.rgb;

            fixed3 emissive = tex2D(_EmissiveMap, IN.uv_EmissiveMap).rgb * _EmissiveColor.rgb;
            o.Emission = emissive;

            half ao = GetChannelValue(tex2D(_AOMap, IN.uv_AOMap), _AOChannel) * _AOIntensity;
            o.Occlusion = ao;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
