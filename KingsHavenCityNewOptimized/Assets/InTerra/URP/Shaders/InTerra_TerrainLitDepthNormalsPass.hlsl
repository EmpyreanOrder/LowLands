#ifndef UNIVERSAL_FORWARD_LIT_DEPTH_NORMALS_PASS_INCLUDED
#define UNIVERSAL_FORWARD_LIT_DEPTH_NORMALS_PASS_INCLUDED

#include "InTerra_TerrainLitPasses.hlsl"


// DepthNormal pass
struct AttributesDepthNormal
{
    float4 positionOS : POSITION;
    half3 normalOS : NORMAL;
    float2 texcoord : TEXCOORD0;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct VaryingsDepthNormal
{
    float4 uvMainAndLM              : TEXCOORD0; // xy: control, zw: lightmap
    #ifndef TERRAIN_SPLAT_BASEPASS
        float4 uvSplat01                : TEXCOORD1; // xy: splat0, zw: splat1
        float4 uvSplat23                : TEXCOORD2; // xy: splat2, zw: splat3
    #endif

    #if defined(_NORMALMAP) || defined(_TERRAIN_NORMAL_IN_MASK)  && !defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
        half4 normal                   : TEXCOORD3;    // xyz: normal, w: viewDir.x
        half4 tangent                  : TEXCOORD4;    // xyz: tangent, w: viewDir.y
        half4 bitangent                : TEXCOORD5;    // xyz: bitangent, w: viewDir.z
    #else
        half3 normal                   : TEXCOORD3;
    #endif

    float4 clipPos                  : SV_POSITION;
    UNITY_VERTEX_OUTPUT_STEREO
};

VaryingsDepthNormal DepthNormalOnlyVertex(AttributesDepthNormal v)
{
    VaryingsDepthNormal o = (VaryingsDepthNormal)0;

    UNITY_SETUP_INSTANCE_ID(v);
    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
    TerrainInstancing(v.positionOS, v.normalOS, v.texcoord);

    const VertexPositionInputs attributes = GetVertexPositionInputs(v.positionOS.xyz);

    o.uvMainAndLM.xy = v.texcoord;
    o.uvMainAndLM.zw = v.texcoord * unity_LightmapST.xy + unity_LightmapST.zw;
    #ifndef TERRAIN_SPLAT_BASEPASS
        o.uvSplat01.xy = TRANSFORM_TEX(v.texcoord, _Splat0);
        o.uvSplat01.zw = TRANSFORM_TEX(v.texcoord, _Splat1);
        o.uvSplat23.xy = TRANSFORM_TEX(v.texcoord, _Splat2);
        o.uvSplat23.zw = TRANSFORM_TEX(v.texcoord, _Splat3);
    #endif

    #if defined(_NORMALMAP) || defined(_TERRAIN_NORMAL_IN_MASK) && !defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
        half3 viewDirWS = GetWorldSpaceNormalizeViewDir(attributes.positionWS);
        float4 vertexTangent = float4(cross(float3(0, 0, 1), v.normalOS), 1.0);
        VertexNormalInputs normalInput = GetVertexNormalInputs(v.normalOS, vertexTangent);

        o.normal = half4(normalInput.normalWS, viewDirWS.x);
        o.tangent = half4(normalInput.tangentWS, viewDirWS.y);
        o.bitangent = half4(normalInput.bitangentWS, viewDirWS.z);
    #else
        o.normal = TransformObjectToWorldNormal(v.normalOS);
    #endif

    o.clipPos = attributes.positionCS;
    return o;
}


void NormalMapMix(float4 uvSplat01, float4 uvSplat23, inout half4 splatControl, inout half3 mixedNormal)
{
    #if defined(_NORMALMAP)
        half3 nrm = half(0.0);
        nrm += splatControl.r * UnpackNormalScale(SAMPLE_TEXTURE2D(_Normal0, SamplerState_Linear_Repeat, uvSplat01.xy), _NormalScale0);
        nrm += splatControl.g * UnpackNormalScale(SAMPLE_TEXTURE2D(_Normal1, SamplerState_Linear_Repeat, uvSplat01.zw), _NormalScale1);
        nrm += splatControl.b * UnpackNormalScale(SAMPLE_TEXTURE2D(_Normal2, SamplerState_Linear_Repeat, uvSplat23.xy), _NormalScale2);
        nrm += splatControl.a * UnpackNormalScale(SAMPLE_TEXTURE2D(_Normal3, SamplerState_Linear_Repeat, uvSplat23.zw), _NormalScale3);

        // avoid risk of NaN when normalizing.
        #if HAS_HALF
            nrm.z += half(0.01);
        #else
            nrm.z += 1e-5f;
        #endif

        mixedNormal = normalize(nrm.xyz);
    #endif
}

#ifdef UNITY_2022_2_OR_NEWER
    void DepthNormalOnlyFragment(
        VaryingsDepthNormal IN
        , out half4 outNormalWS : SV_Target0
    #ifdef _WRITE_RENDERING_LAYERS
        , out float4 outRenderingLayers : SV_Target1
    #endif
    )
#else
    half4 DepthNormalOnlyFragment(VaryingsDepthNormal IN) : SV_TARGET
#endif
{
    #ifdef _ALPHATEST_ON
        ClipHoles(IN.uvMainAndLM.xy);
    #endif

    float2 splatUV = (IN.uvMainAndLM.xy * (_Control_TexelSize.zw - 1.0f) + 0.5f) * _Control_TexelSize.xy;
    half4 splatControl = SAMPLE_TEXTURE2D(_Control, sampler_Control, splatUV);

    half3 normalTS = half3(0.0h, 0.0h, 1.0h);
    NormalMapMix(IN.uvSplat01, IN.uvSplat23, splatControl, normalTS);

    #if defined(_NORMALMAP) || defined(_TERRAIN_NORMAL_IN_MASK) && !defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
        half3 normalWS = TransformTangentToWorld(normalTS, half3x3(-IN.tangent.xyz, IN.bitangent.xyz, IN.normal.xyz));
    #elif defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
        half3 viewDirWS = IN.viewDir;
        float2 sampleCoords = (IN.uvMainAndLM.xy / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
        half3 normalWS = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
        half3 tangentWS = cross(GetObjectToWorldMatrix()._13_23_33, normalWS);
        half3 normalWS = TransformTangentToWorld(normalTS, half3x3(-tangentWS, cross(normalWS, tangentWS), normalWS));
    #else
        half3 normalWS = IN.normal;
    #endif

    normalWS = NormalizeNormalPerPixel(normalWS);
    
    #ifdef UNITY_2022_2_OR_NEWER
        outNormalWS = half4(normalWS, 0.0);
        #ifdef _WRITE_RENDERING_LAYERS
            uint renderingLayers = GetMeshRenderingLayer();
            outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
        #endif
    #else
        return half4(normalWS, 0.0);
    #endif

}

#endif
