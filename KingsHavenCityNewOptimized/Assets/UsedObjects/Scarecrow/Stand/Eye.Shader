Shader "Custom/EyeShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [NoScaleOffset] _ScleraTex ("Sclera (RGB)", 2D) = "white" {}
        [NoScaleOffset] _NormalMap ("Normal Map", 2D) = "bump" {}
        [NoScaleOffset] _IrisTex ("Iris (RGB)", 2D) = "white" {}
        [NoScaleOffset] _IrisMask ("Iris Mask", 2D) = "white" {}
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        _IrisScale ("Iris Scale", Range(0.1,2)) = 1.0
        _PupilSize ("Pupil Size", Range(0.1,2)) = 1.0
        _NormalIntensity ("Normal Intensity", Range(0, 1)) = 1.0
        _BlurIntensity ("Blur Intensity", Range(0, 10)) = 1.0
        _EdgeWidth ("Edge Width", Range(0, 0.1)) = 0.01
        _EdgeColor ("Edge Color", Color) = (1,0,0,1)
        _TopShadeIntensity ("Top Shade Intensity", Range(0, 1)) = 0.5
        _BottomShadeIntensity ("Bottom Shade Intensity", Range(0, 1)) = 0.5
        _TopShadeStart ("Top Shade Start", Range(0, 1)) = 0.0
        _TopShadeEnd ("Top Shade End", Range(0, 1)) = 0.5
        _BottomShadeStart ("Bottom Shade Start", Range(0, 1)) = 0.5
        _BottomShadeEnd ("Bottom Shade End", Range(0, 1)) = 1.0
        _IrisBrightness ("Iris Brightness", Range(0, 2)) = 1.0
        _NormalMapIntensity ("Normal Map Intensity", Range(0, 2)) = 1.0
        _Hue ("Hue", Range(0, 1)) = 0.0
        _Saturation ("Saturation", Range(0, 2)) = 1.0
        _Lightness ("Lightness", Range(0, 2)) = 1.0
        _ScleraBrightness ("Sclera Brightness", Range(0, 2)) = 1.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        #pragma target 3.0

        sampler2D _ScleraTex;
        sampler2D _NormalMap;
        sampler2D _IrisTex;
        sampler2D _IrisMask;

        half _Glossiness;
        half _Metallic;
        half _IrisScale;
        half _PupilSize;
        half _NormalIntensity;
        half _BlurIntensity;
        half _EdgeWidth;
        half _TopShadeIntensity;
        half _BottomShadeIntensity;
        half _TopShadeStart;
        half _TopShadeEnd;
        half _BottomShadeStart;
        half _BottomShadeEnd;
        fixed4 _EdgeColor;
        fixed4 _Color;
        half _IrisBrightness;
        half _NormalMapIntensity;
        half _Hue;
        half _Saturation;
        half _Lightness;
        half _ScleraBrightness;

        struct Input
        {
            float2 uv_ScleraTex;
            float2 uv_IrisMask;
            float3 viewDir;
        };

        // Function to apply a simple blur effect
        half4 BlurEffect(sampler2D mask, float2 uv, float blurIntensity)
        {
            half4 sum = half4(0, 0, 0, 0);
            half weight = 1.0 / 9.0;
            half offset = blurIntensity * 0.01;

            sum += tex2D(mask, uv + float2(-offset, -offset)) * weight;
            sum += tex2D(mask, uv + float2(0, -offset)) * weight;
            sum += tex2D(mask, uv + float2(offset, -offset)) * weight;
            sum += tex2D(mask, uv + float2(-offset, 0)) * weight;
            sum += tex2D(mask, uv) * weight;
            sum += tex2D(mask, uv + float2(offset, 0)) * weight;
            sum += tex2D(mask, uv + float2(-offset, offset)) * weight;
            sum += tex2D(mask, uv + float2(0, offset)) * weight;
            sum += tex2D(mask, uv + float2(offset, offset)) * weight;

            return sum;
        }

        // Function to blend two normal maps
        fixed3 BlendNormals(fixed3 n1, fixed3 n2, float scale)
        {
            n1.xy = n1.xy * 2.0 - 1.0;
            n2.xy = n2.xy * 2.0 - 1.0;

            fixed3 blended;
            blended.xy = n1.xy + n2.xy * scale;
            blended.z = n1.z * n2.z;
            blended = normalize(blended * 0.5 + 0.5);

            return blended;
        }

        // Function to convert RGB to HSL
        half3 RGBToHSL(fixed3 rgb)
        {
            half maxc = max(max(rgb.r, rgb.g), rgb.b);
            half minc = min(min(rgb.r, rgb.g), rgb.b);
            half h = 0.0;
            half s = 0.0;
            half l = (maxc + minc) / 2.0;
            if (maxc != minc)
            {
                half d = maxc - minc;
                s = (l > 0.5) ? d / (2.0 - maxc - minc) : d / (maxc + minc);
                if (maxc == rgb.r)
                {
                    h = (rgb.g - rgb.b) / d + (rgb.g < rgb.b ? 6.0 : 0.0);
                }
                else if (maxc == rgb.g)
                {
                    h = (rgb.b - rgb.r) / d + 2.0;
                }
                else if (maxc == rgb.b)
                {
                    h = (rgb.r - rgb.g) / d + 4.0;
                }
                h /= 6.0;
            }
            return half3(h, s, l);
        }

        // Function to convert HSL to RGB
        half3 HSLToRGB(half3 hsl)
        {
            half r, g, b;
            if (hsl.y == 0.0)
            {
                r = g = b = hsl.z;
            }
            else
            {
                half q = (hsl.z < 0.5) ? hsl.z * (1.0 + hsl.y) : (hsl.z + hsl.y) - (hsl.z * hsl.y);
                half p = 2.0 * hsl.z - q;
                half3 hk = half3(hsl.x + 1.0 / 3.0, hsl.x, hsl.x - 1.0 / 3.0);
                half3 tc = (hk < 0.0) ? (hk + 1.0) : ((hk > 1.0) ? (hk - 1.0) : hk);
                half3 color;
                color.r = (tc.r < 1.0 / 6.0) ? (p + ((q - p) * 6.0 * tc.r)) : ((tc.r < 1.0 / 2.0) ? q : ((tc.r < 2.0 / 3.0) ? (p + ((q - p) * (2.0 / 3.0 - tc.r) * 6.0)) : p));
                color.g = (tc.g < 1.0 / 6.0) ? (p + ((q - p) * 6.0 * tc.g)) : ((tc.g < 1.0 / 2.0) ? q : ((tc.g < 2.0 / 3.0) ? (p + ((q - p) * (2.0 / 3.0 - tc.g) * 6.0)) : p));
                color.b = (tc.b < 1.0 / 6.0) ? (p + ((q - p) * 6.0 * tc.b)) : ((tc.b < 1.0 / 2.0) ? q : ((tc.b < 2.0 / 3.0) ? (p + ((q - p) * (2.0 / 3.0 - tc.b) * 6.0)) : p));
                r = color.r;
                g = color.g;
                b = color.b;
            }
            return half3(r, g, b);
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            // Apply sclera texture tinted by color and adjust brightness
            fixed4 sclera = tex2D(_ScleraTex, IN.uv_ScleraTex) * _Color * _ScleraBrightness;
            o.Albedo = sclera.rgb;

            // Calculate centered UVs for the iris texture, mask, and normal map with scaling
            float2 centerUV = float2(0.5, 0.5);
            float2 irisMaskUV = (IN.uv_IrisMask - centerUV) * _IrisScale + centerUV;
            float2 irisUV = (irisMaskUV - centerUV) * _PupilSize + centerUV;

            // Apply iris texture and mask
            fixed4 iris = tex2D(_IrisTex, irisUV) * _IrisBrightness;
            fixed4 irisMask = BlurEffect(_IrisMask, irisMaskUV, _BlurIntensity);

            // Convert iris color from RGB to HSL
            half3 irisHSL = RGBToHSL(iris.rgb);
            // Adjust HSL values
            irisHSL.x = fmod(irisHSL.x + _Hue, 1.0);
            irisHSL.y *= _Saturation;
            irisHSL.z *= _Lightness;
            // Convert back to RGB
            iris.rgb = HSLToRGB(irisHSL);

            // Apply normal map with scaling for iris
            fixed4 normalTex = tex2D(_NormalMap, irisUV);
            half3 irisNormal = UnpackNormal(normalTex) * _NormalIntensity * _NormalMapIntensity;

            // Calculate edge effect based on mask
            float maskValue = irisMask.r;
            float edge = smoothstep(0.5 - _EdgeWidth, 0.5 + _EdgeWidth, maskValue);
            float innerEdge = smoothstep(0.5 - _EdgeWidth, 0.5, maskValue);
            float outerEdge = smoothstep(0.5, 0.5 + _EdgeWidth, maskValue);
            float finalEdge = outerEdge - innerEdge;
            fixed4 edgeColor = _EdgeColor * finalEdge;

            // Apply iris texture and mask
            o.Albedo = lerp(o.Albedo, iris.rgb, maskValue); // Using red channel of the mask
            o.Albedo.rgb = lerp(o.Albedo.rgb, edgeColor.rgb, finalEdge); // Apply edge color as overlay

            // Blend normal maps
            o.Normal = lerp(o.Normal, irisNormal, maskValue * _NormalIntensity);

            // Apply top and bottom shading with adjustable start and end points
            float topShade = smoothstep(_TopShadeStart, _TopShadeEnd, IN.uv_ScleraTex.y) * _TopShadeIntensity;
            float bottomShade = smoothstep(_BottomShadeEnd, _BottomShadeStart, IN.uv_ScleraTex.y) * _BottomShadeIntensity;
            float shading = max(topShade, bottomShade);
            o.Albedo.rgb *= (1.0 - shading);

            // Metallic and smoothness come from slider variables
            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = sclera.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
