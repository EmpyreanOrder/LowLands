Shader "Custom/GlassWithFresnelAndRenderMode"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.8
        _Transparency ("Transparency", Range(0,1)) = 0.5
        [Toggle] _EnableTransparency ("Enable Transparency", Float) = 1.0
        [NoScaleOffset] _MainTex ("Albedo (RGB)", 2D) = "white" {}
        [NoScaleOffset] _NormalMap ("Normal Map", 2D) = "bump" {}
        [NoScaleOffset] _RoughnessMap ("Roughness Map", 2D) = "white" {}
        [KeywordEnum(R, G, B, A)] _RoughnessChannel ("Roughness Channel", Float) = 0
        _FresnelColor ("Fresnel Color", Color) = (1,1,1,1)
        _FresnelPower ("Fresnel Power", Range(0.1, 5)) = 1.0
        [Toggle] _EnableFresnel ("Enable Fresnel", Float) = 1.0
        [Toggle] _RenderOpaque ("Render Opaque", Float) = 0.0
    }
    SubShader
    {
        // Default to Transparent
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows alpha:fade

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _RoughnessMap;
        half _Metallic;
        half _Glossiness;
        half _Transparency;
        half _EnableTransparency;
        fixed4 _Color;
        fixed4 _FresnelColor;
        half _FresnelPower;
        half _EnableFresnel;
        half _RenderOpaque;
        half _RoughnessChannel;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float2 uv_RoughnessMap;
            float3 viewDir; // View direction
            INTERNAL_DATA
        };

        half GetChannelValue(half4 tex, float channel)
        {
            if (channel == 0) return tex.r;
            if (channel == 1) return tex.g;
            if (channel == 2) return tex.b;
            return tex.a;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;

            // Apply normal map
            fixed4 normalTex = tex2D(_NormalMap, IN.uv_NormalMap);
            o.Normal = UnpackNormal(normalTex);

            // Apply roughness map
            fixed4 roughnessTex = tex2D(_RoughnessMap, IN.uv_RoughnessMap);
            half roughness = GetChannelValue(roughnessTex, _RoughnessChannel);
            o.Smoothness = 1.0 - roughness * _Glossiness;

            // Metallic
            o.Metallic = _Metallic;

            // Transparency
            if (_EnableTransparency && _RenderOpaque == 0)
            {
                o.Alpha = _Transparency;
            }
            else
            {
                o.Alpha = 1.0;
            }

            // Fresnel effect
            if (_EnableFresnel)
            {
                half fresnel = pow(1.0 - dot(IN.viewDir, o.Normal), _FresnelPower);
                o.Emission = _FresnelColor.rgb * fresnel;
            }
        }
        ENDCG
    }
    SubShader
    {
        Tags { "Queue"="Geometry" "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _RoughnessMap;
        half _Metallic;
        half _Glossiness;
        half _Transparency;
        half _EnableTransparency;
        fixed4 _Color;
        fixed4 _FresnelColor;
        half _FresnelPower;
        half _EnableFresnel;
        half _RenderOpaque;
        half _RoughnessChannel;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
            float2 uv_RoughnessMap;
            float3 viewDir; // View direction
            INTERNAL_DATA
        };

        half GetChannelValue(half4 tex, float channel)
        {
            if (channel == 0) return tex.r;
            if (channel == 1) return tex.g;
            if (channel == 2) return tex.b;
            return tex.a;
        }

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;

            // Apply normal map
            fixed4 normalTex = tex2D(_NormalMap, IN.uv_NormalMap);
            o.Normal = UnpackNormal(normalTex);

            // Apply roughness map
            fixed4 roughnessTex = tex2D(_RoughnessMap, IN.uv_RoughnessMap);
            half roughness = GetChannelValue(roughnessTex, _RoughnessChannel);
            o.Smoothness = 1.0 - roughness * _Glossiness;

            // Metallic
            o.Metallic = _Metallic;

            // Transparency
            o.Alpha = 1.0;

            // Fresnel effect
            if (_EnableFresnel)
            {
                half fresnel = pow(1.0 - dot(IN.viewDir, o.Normal), _FresnelPower);
                o.Emission = _FresnelColor.rgb * fresnel;
            }
        }
        ENDCG
    }
    FallBack "Diffuse"
}
