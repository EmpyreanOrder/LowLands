#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_MATERIAL_TEXCOORDS_VERTEX 1
#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

struct Input
{
	//float3 Normal;
	float2 uv_MainTex : TEXCOORD0;
	float2 uv2_Material_Texture2D_0 : TEXCOORD1;
	float4 color : COLOR;
	float4 tangent;
	//float4 normal;
	float3 viewDir;
	float4 screenPos;
	float3 worldPos;
	//float3 worldNormal;
	float3 normal2;
};
struct SurfaceOutputStandard
{
	float3 Albedo;		// base (diffuse or specular) color
	float3 Normal;		// tangent space normal, if written
	half3 Emission;
	half Metallic;		// 0=non-metal, 1=metal
	// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
	// Everywhere in the code you meet smoothness it is perceptual smoothness
	half Smoothness;	// 0=rough, 1=smooth
	half Occlusion;		// occlusion (default 1)
	float Alpha;		// alpha for transparencies
};

//#define HDRP 1
#define URP 1
#define UE5
//#define HAS_CUSTOMIZED_UVS 1
#define MATERIAL_TANGENTSPACENORMAL 1
//struct Material
//{
	//samplers start
SAMPLER( SamplerState_Linear_Repeat );
SAMPLER( SamplerState_Linear_Clamp );
TEXTURE2D(       Material_Texture2D_0 );
SAMPLER(  samplerMaterial_Texture2D_0 );
float4 Material_Texture2D_0_TexelSize;
float4 Material_Texture2D_0_ST;
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER(  samplerMaterial_Texture2D_1 );
float4 Material_Texture2D_1_TexelSize;
float4 Material_Texture2D_1_ST;
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER(  samplerMaterial_Texture2D_2 );
float4 Material_Texture2D_2_TexelSize;
float4 Material_Texture2D_2_ST;
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER(  samplerMaterial_Texture2D_3 );
float4 Material_Texture2D_3_TexelSize;
float4 Material_Texture2D_3_ST;
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER(  samplerMaterial_Texture2D_4 );
float4 Material_Texture2D_4_TexelSize;
float4 Material_Texture2D_4_ST;
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER(  samplerMaterial_Texture2D_5 );
float4 Material_Texture2D_5_TexelSize;
float4 Material_Texture2D_5_ST;
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER(  samplerMaterial_Texture2D_6 );
float4 Material_Texture2D_6_TexelSize;
float4 Material_Texture2D_6_ST;
TEXTURE2D(       Material_Texture2D_7 );
SAMPLER(  samplerMaterial_Texture2D_7 );
float4 Material_Texture2D_7_TexelSize;
float4 Material_Texture2D_7_ST;
TEXTURE2D(       Material_Texture2D_8 );
SAMPLER(  samplerMaterial_Texture2D_8 );
float4 Material_Texture2D_8_TexelSize;
float4 Material_Texture2D_8_ST;
TEXTURE2D(       Material_Texture2D_9 );
SAMPLER(  samplerMaterial_Texture2D_9 );
float4 Material_Texture2D_9_TexelSize;
float4 Material_Texture2D_9_ST;
TEXTURE2D(       Material_Texture2D_10 );
SAMPLER(  samplerMaterial_Texture2D_10 );
float4 Material_Texture2D_10_TexelSize;
float4 Material_Texture2D_10_ST;
TEXTURE2D(       Material_Texture2D_11 );
SAMPLER(  samplerMaterial_Texture2D_11 );
float4 Material_Texture2D_11_TexelSize;
float4 Material_Texture2D_11_ST;
TEXTURE2D(       Material_Texture2D_12 );
SAMPLER(  samplerMaterial_Texture2D_12 );
float4 Material_Texture2D_12_TexelSize;
float4 Material_Texture2D_12_ST;
TEXTURE2D(       Material_Texture2D_13 );
SAMPLER(  samplerMaterial_Texture2D_13 );
float4 Material_Texture2D_13_TexelSize;
float4 Material_Texture2D_13_ST;
TEXTURE2D(       Material_Texture2D_14 );
SAMPLER(  samplerMaterial_Texture2D_14 );
float4 Material_Texture2D_14_TexelSize;
float4 Material_Texture2D_14_ST;
TEXTURE2D(       Material_Texture2D_15 );
SAMPLER(  samplerMaterial_Texture2D_15 );
float4 Material_Texture2D_15_TexelSize;
float4 Material_Texture2D_15_ST;
TEXTURE2D(       Material_Texture2D_16 );
SAMPLER(  samplerMaterial_Texture2D_16 );
float4 Material_Texture2D_16_TexelSize;
float4 Material_Texture2D_16_ST;
TEXTURE2D(       Material_Texture2D_17 );
SAMPLER(  samplerMaterial_Texture2D_17 );
float4 Material_Texture2D_17_TexelSize;
float4 Material_Texture2D_17_ST;
TEXTURE2D(       Material_Texture2D_18 );
SAMPLER(  samplerMaterial_Texture2D_18 );
float4 Material_Texture2D_18_TexelSize;
float4 Material_Texture2D_18_ST;
TEXTURE2D(       Material_Texture2D_19 );
SAMPLER(  samplerMaterial_Texture2D_19 );
float4 Material_Texture2D_19_TexelSize;
float4 Material_Texture2D_19_ST;
TEXTURE2D(       Material_Texture2D_20 );
SAMPLER(  samplerMaterial_Texture2D_20 );
float4 Material_Texture2D_20_TexelSize;
float4 Material_Texture2D_20_ST;
TEXTURE2D(       Material_Texture2D_21 );
SAMPLER(  samplerMaterial_Texture2D_21 );
float4 Material_Texture2D_21_TexelSize;
float4 Material_Texture2D_21_ST;
TEXTURE2D(       Material_Texture2D_22 );
SAMPLER(  samplerMaterial_Texture2D_22 );
float4 Material_Texture2D_22_TexelSize;
float4 Material_Texture2D_22_ST;
TEXTURE2D(       Material_Texture2D_23 );
SAMPLER(  samplerMaterial_Texture2D_23 );
float4 Material_Texture2D_23_TexelSize;
float4 Material_Texture2D_23_ST;
TEXTURE2D(       Material_Texture2D_24 );
SAMPLER(  samplerMaterial_Texture2D_24 );
float4 Material_Texture2D_24_TexelSize;
float4 Material_Texture2D_24_ST;
TEXTURE2D(       Material_Texture2D_25 );
SAMPLER(  samplerMaterial_Texture2D_25 );
float4 Material_Texture2D_25_TexelSize;
float4 Material_Texture2D_25_ST;
TEXTURE2D(       Material_Texture2D_26 );
SAMPLER(  samplerMaterial_Texture2D_26 );
float4 Material_Texture2D_26_TexelSize;
float4 Material_Texture2D_26_ST;
TEXTURE2D(       Material_Texture2D_27 );
SAMPLER(  samplerMaterial_Texture2D_27 );
float4 Material_Texture2D_27_TexelSize;
float4 Material_Texture2D_27_ST;
TEXTURE2D(       Material_Texture2D_28 );
SAMPLER(  samplerMaterial_Texture2D_28 );
float4 Material_Texture2D_28_TexelSize;
float4 Material_Texture2D_28_ST;
TEXTURE2D(       Material_Texture2D_29 );
SAMPLER(  samplerMaterial_Texture2D_29 );
float4 Material_Texture2D_29_TexelSize;
float4 Material_Texture2D_29_ST;
TEXTURE2D(       Material_Texture2D_30 );
SAMPLER(  samplerMaterial_Texture2D_30 );
float4 Material_Texture2D_30_TexelSize;
float4 Material_Texture2D_30_ST;
TEXTURE2D(       Material_Texture2D_31 );
SAMPLER(  samplerMaterial_Texture2D_31 );
float4 Material_Texture2D_31_TexelSize;
float4 Material_Texture2D_31_ST;
TEXTURE2D(       Material_Texture2D_32 );
SAMPLER(  samplerMaterial_Texture2D_32 );
float4 Material_Texture2D_32_TexelSize;
float4 Material_Texture2D_32_ST;
TEXTURE2D(       Material_Texture2D_33 );
SAMPLER(  samplerMaterial_Texture2D_33 );
float4 Material_Texture2D_33_TexelSize;
float4 Material_Texture2D_33_ST;
TEXTURE2D(       Material_Texture2D_34 );
SAMPLER(  samplerMaterial_Texture2D_34 );
float4 Material_Texture2D_34_TexelSize;
float4 Material_Texture2D_34_ST;
TEXTURE2D(       Material_Texture2D_35 );
SAMPLER(  samplerMaterial_Texture2D_35 );
float4 Material_Texture2D_35_TexelSize;
float4 Material_Texture2D_35_ST;
TEXTURE2D(       Material_Texture2D_36 );
SAMPLER(  samplerMaterial_Texture2D_36 );
float4 Material_Texture2D_36_TexelSize;
float4 Material_Texture2D_36_ST;
TEXTURE2D(       Material_Texture2D_37 );
SAMPLER(  samplerMaterial_Texture2D_37 );
float4 Material_Texture2D_37_TexelSize;
float4 Material_Texture2D_37_ST;
TEXTURE2D(       Material_Texture2D_38 );
SAMPLER(  samplerMaterial_Texture2D_38 );
float4 Material_Texture2D_38_TexelSize;
float4 Material_Texture2D_38_ST;
TEXTURE2D(       Material_Texture2D_39 );
SAMPLER(  samplerMaterial_Texture2D_39 );
float4 Material_Texture2D_39_TexelSize;
float4 Material_Texture2D_39_ST;
TEXTURE2D(       Material_Texture2D_40 );
SAMPLER(  samplerMaterial_Texture2D_40 );
float4 Material_Texture2D_40_TexelSize;
float4 Material_Texture2D_40_ST;

//};

#ifdef UE5
	#define UE_LWC_RENDER_TILE_SIZE			2097152.0
	#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
	#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
	#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
	#define INVARIANT(X) X
	#define PI 					(3.1415926535897932)

	#include "LargeWorldCoordinates.hlsl"
#endif
struct MaterialStruct
{
	float4 PreshaderBuffer[34];
	float4 ScalarExpressions[1];
	float VTPackedPageTableUniform[2];
	float VTPackedUniform[1];
};
static SamplerState View_MaterialTextureBilinearWrapedSampler;
static SamplerState View_MaterialTextureBilinearClampedSampler;
struct ViewStruct
{
	float GameTime;
	float RealTime;
	float DeltaTime;
	float PrevFrameGameTime;
	float PrevFrameRealTime;
	float MaterialTextureMipBias;	
	float4 PrimitiveSceneData[ 40 ];
	float4 TemporalAAParams;
	float2 ViewRectMin;
	float4 ViewSizeAndInvSize;
	float MaterialTextureDerivativeMultiply;
	uint StateFrameIndexMod8;
	float FrameNumber;
	float2 FieldOfViewWideAngles;
	float4 RuntimeVirtualTextureMipLevel;
	float PreExposure;
	float4 BufferBilinearUVMinMax;
};
struct ResolvedViewStruct
{
	#ifdef UE5
		FLWCVector3 WorldCameraOrigin;
		FLWCVector3 PrevWorldCameraOrigin;
		FLWCVector3 PreViewTranslation;
		FLWCVector3 WorldViewOrigin;
	#else
		float3 WorldCameraOrigin;
		float3 PrevWorldCameraOrigin;
		float3 PreViewTranslation;
		float3 WorldViewOrigin;
	#endif
	float4 ScreenPositionScaleBias;
	float4x4 TranslatedWorldToView;
	float4x4 TranslatedWorldToCameraView;
	float4x4 TranslatedWorldToClip;
	float4x4 ViewToTranslatedWorld;
	float4x4 PrevViewToTranslatedWorld;
	float4x4 CameraViewToTranslatedWorld;
	float4 BufferBilinearUVMinMax;
	float4 XRPassthroughCameraUVs[ 2 ];
};
struct PrimitiveStruct
{
	float4x4 WorldToLocal;
	float4x4 LocalToWorld;
};

static ViewStruct View;
static ResolvedViewStruct ResolvedView;
static PrimitiveStruct Primitive;
uniform float4 View_BufferSizeAndInvSize;
uniform float4 LocalObjectBoundsMin;
uniform float4 LocalObjectBoundsMax;
static SamplerState Material_Wrap_WorldGroupSettings;
static SamplerState Material_Clamp_WorldGroupSettings;

#include "UnrealCommon.cginc"

static MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(127499.992188,127499.992188,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(127499.992188,127499.992188,0.000500,0.474783);//(Unknown)
	Material.PreshaderBuffer[4] = float4(5.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(254999.984375,254999.984375,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(254999.984375,254999.984375,0.000100,0.252000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(7000.000000,0.000143,2.500000,0.900433);//(Unknown)
	Material.PreshaderBuffer[8] = float4(2.000000,1.000000,7000.000000,0.000143);//(Unknown)
	Material.PreshaderBuffer[9] = float4(2.500000,0.630206,1.000000,0.400000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(7000.000000,0.000143,2.500000,3.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,7000.000000,0.000143);//(Unknown)
	Material.PreshaderBuffer[12] = float4(2.500000,0.500000,2.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(7000.000000,0.000143,2.500000,1.678552);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.620845,1.000000,2.250000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.291667,0.291667,0.291667,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.291667,0.291667,0.291667,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.182292,0.182292,0.182292,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.182292,0.182292,0.182292,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.708333,0.708333,0.708333,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.708333,0.708333,0.708333,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.307292,0.307292,0.307292,1.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.307292,0.307292,0.307292,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(255.000000,255.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(255.000000,255.000000,0.750000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.715694,1.000000,0.603828,1.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.715694,1.000000,0.603828,0.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.000000,1.450923,1.266140,1.824140);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.000000,1.018031,1.000000,0.000000);//(Unknown)
}
MaterialFloat3 CustomExpression9(FMaterialPixelParameters Parameters,MaterialFloat Base,MaterialFloat4 Weight,MaterialFloat Layer)
{
float3 BaseCopy = Base;
return BaseCopy.rgb + Weight.rrr * Layer;
}

MaterialFloat3 CustomExpression8(FMaterialPixelParameters Parameters,MaterialFloat Base,MaterialFloat4 Weight,MaterialFloat Layer)
{
float3 BaseCopy = Base;
return BaseCopy.rgb + Weight.rrr * Layer;
}

MaterialFloat3 CustomExpression7(FMaterialPixelParameters Parameters,MaterialFloat Base,MaterialFloat4 Weight,MaterialFloat Layer)
{
float3 BaseCopy = Base;
return BaseCopy.rgb + Weight.rrr * Layer;
}

MaterialFloat3 CustomExpression6(FMaterialPixelParameters Parameters,MaterialFloat Base,MaterialFloat4 Weight,MaterialFloat Layer)
{
float3 BaseCopy = Base;
return BaseCopy.rgb + Weight.rrr * Layer;
}

MaterialFloat3 CustomExpression5(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat Dirt_01,MaterialFloat Dirt_02,MaterialFloat Grass_01,MaterialFloat Grass_02,MaterialFloat Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression4(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat Dirt_01,MaterialFloat Dirt_02,MaterialFloat Grass_01,MaterialFloat Grass_02,MaterialFloat Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression3(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat3 Dirt_01,MaterialFloat3 Dirt_02,MaterialFloat3 Grass_01,MaterialFloat3 Grass_02,MaterialFloat3 Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat3 Dirt_01,MaterialFloat3 Dirt_02,MaterialFloat3 Grass_01,MaterialFloat3 Grass_02,MaterialFloat3 Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat3 Dirt_01,MaterialFloat3 Dirt_02,MaterialFloat3 Grass_01,MaterialFloat3 Grass_02,MaterialFloat3 Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat Dirt_01Weight,MaterialFloat Dirt_02Weight,MaterialFloat Grass_01Weight,MaterialFloat Grass_02Weight,MaterialFloat RockWeight,MaterialFloat3 Dirt_01,MaterialFloat3 Dirt_02,MaterialFloat3 Grass_01,MaterialFloat3 Grass_02,MaterialFloat3 Rock,MaterialFloat Dirt_01Height,MaterialFloat Dirt_02Height,MaterialFloat Grass_01Height,MaterialFloat Grass_02Height,MaterialFloat RockHeight)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, Dirt_01Weight );
Local0 = ( lerpres + Dirt_01Height );
float Layer0WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Dirt_02Weight );
Local0 = ( lerpres + Dirt_02Height );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_01Weight );
Local0 = ( lerpres + Grass_01Height );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Grass_02Weight );
Local0 = ( lerpres + Grass_02Height );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer0WithHeight + Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(Layer0WithHeight,Layer0WithHeight,Layer0WithHeight) * Dirt_01;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Dirt_02;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Grass_01;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Grass_02;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Rock;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}
void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[1].x));
	MaterialFloat Local2 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 10);
	MaterialFloat4 Local3 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local4 = MaterialStoreTexSample(Parameters, Local3, 10);
	MaterialFloat4 Local5 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 10);
	MaterialFloat4 Local7 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local8 = MaterialStoreTexSample(Parameters, Local7, 10);
	MaterialFloat4 Local9 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 10);
	MaterialFloat4 Local11 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local12 = MaterialStoreTexSample(Parameters, Local11, 10);
	MaterialFloat2 Local13 = (DERIV_BASE_VALUE(Local0) + MaterialFloat4(0.00784314,0.00784314,0.00784314,0.00784314).rg);
	MaterialFloat2 Local14 = (DERIV_BASE_VALUE(Local13) * Material.PreshaderBuffer[3].xy);
	MaterialFloat2 Local15 = (DERIV_BASE_VALUE(Local14) * ((MaterialFloat2)Material.PreshaderBuffer[3].z));
	MaterialFloat2 Local16 = (DERIV_BASE_VALUE(Local15) * ((MaterialFloat2)Material.PreshaderBuffer[3].w));
	MaterialFloat Local17 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 3);
	MaterialFloat4 Local18 = UnpackNormalMap(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local19 = MaterialStoreTexSample(Parameters, Local18, 3);
	MaterialFloat Local20 = (Local18.r * Material.PreshaderBuffer[4].x);
	MaterialFloat Local21 = (Local18.g * Material.PreshaderBuffer[4].x);
	MaterialFloat2 Local22 = (DERIV_BASE_VALUE(Local13) * Material.PreshaderBuffer[6].xy);
	MaterialFloat2 Local23 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[6].z));
	MaterialFloat2 Local24 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)Material.PreshaderBuffer[6].w));
	MaterialFloat Local25 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 3);
	MaterialFloat4 Local26 = UnpackNormalMap(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local27 = MaterialStoreTexSample(Parameters, Local26, 3);
	FLWCVector3 Local28 = GetWorldPosition(Parameters);
	FLWCVector3 Local29 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local30 = LWCSubtract(DERIV_BASE_VALUE(Local28), Local29);
	MaterialFloat3 Local31 = LWCToFloat(DERIV_BASE_VALUE(Local30));
	MaterialFloat Local32 = length(DERIV_BASE_VALUE(Local31));
	MaterialFloat Local33 = (DERIV_BASE_VALUE(Local32) * Material.PreshaderBuffer[7].y);
	MaterialFloat Local34 = PositiveClampedPow(DERIV_BASE_VALUE(Local33),Material.PreshaderBuffer[7].z);
	MaterialFloat Local35 = saturate(DERIV_BASE_VALUE(Local34));
	MaterialFloat3 Local36 = lerp(MaterialFloat3(MaterialFloat2(Local20,Local21),Local18.b),Local26.rgb,DERIV_BASE_VALUE(Local35));
	MaterialFloat2 Local37 = (DERIV_BASE_VALUE(Local15) * ((MaterialFloat2)Material.PreshaderBuffer[7].w));
	MaterialFloat Local38 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 3);
	MaterialFloat4 Local39 = UnpackNormalMap(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local40 = MaterialStoreTexSample(Parameters, Local39, 3);
	MaterialFloat Local41 = (Local39.r * Material.PreshaderBuffer[8].x);
	MaterialFloat Local42 = (Local39.g * Material.PreshaderBuffer[8].x);
	MaterialFloat2 Local43 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)Material.PreshaderBuffer[8].y));
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local43), 3);
	MaterialFloat4 Local45 = UnpackNormalMap(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local43)));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 3);
	MaterialFloat Local47 = (DERIV_BASE_VALUE(Local32) * Material.PreshaderBuffer[8].w);
	MaterialFloat Local48 = PositiveClampedPow(DERIV_BASE_VALUE(Local47),Material.PreshaderBuffer[9].x);
	MaterialFloat Local49 = saturate(DERIV_BASE_VALUE(Local48));
	MaterialFloat3 Local50 = lerp(MaterialFloat3(MaterialFloat2(Local41,Local42),Local39.b),Local45.rgb,DERIV_BASE_VALUE(Local49));
	MaterialFloat2 Local51 = (DERIV_BASE_VALUE(Local15) * ((MaterialFloat2)Material.PreshaderBuffer[9].y));
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local51), 7);
	MaterialFloat4 Local53 = UnpackNormalMap(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local51)));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 7);
	MaterialFloat Local55 = (Local53.r * Material.PreshaderBuffer[9].z);
	MaterialFloat Local56 = (Local53.g * Material.PreshaderBuffer[9].z);
	MaterialFloat2 Local57 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)Material.PreshaderBuffer[9].w));
	MaterialFloat Local58 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local57), 7);
	MaterialFloat4 Local59 = UnpackNormalMap(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local57)));
	MaterialFloat Local60 = MaterialStoreTexSample(Parameters, Local59, 7);
	MaterialFloat Local61 = (DERIV_BASE_VALUE(Local32) * Material.PreshaderBuffer[10].y);
	MaterialFloat Local62 = PositiveClampedPow(DERIV_BASE_VALUE(Local61),Material.PreshaderBuffer[10].z);
	MaterialFloat Local63 = saturate(DERIV_BASE_VALUE(Local62));
	MaterialFloat3 Local64 = lerp(MaterialFloat3(MaterialFloat2(Local55,Local56),Local53.b),Local59.rgb,DERIV_BASE_VALUE(Local63));
	MaterialFloat2 Local65 = (DERIV_BASE_VALUE(Local15) * ((MaterialFloat2)Material.PreshaderBuffer[10].w));
	MaterialFloat Local66 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 7);
	MaterialFloat4 Local67 = UnpackNormalMap(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local68 = MaterialStoreTexSample(Parameters, Local67, 7);
	MaterialFloat Local69 = (Local67.r * Material.PreshaderBuffer[11].x);
	MaterialFloat Local70 = (Local67.g * Material.PreshaderBuffer[11].x);
	MaterialFloat2 Local71 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)Material.PreshaderBuffer[11].y));
	MaterialFloat Local72 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local71), 7);
	MaterialFloat4 Local73 = UnpackNormalMap(Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local71)));
	MaterialFloat Local74 = MaterialStoreTexSample(Parameters, Local73, 7);
	MaterialFloat Local75 = (DERIV_BASE_VALUE(Local32) * Material.PreshaderBuffer[11].w);
	MaterialFloat Local76 = PositiveClampedPow(DERIV_BASE_VALUE(Local75),Material.PreshaderBuffer[12].x);
	MaterialFloat Local77 = saturate(DERIV_BASE_VALUE(Local76));
	MaterialFloat3 Local78 = lerp(MaterialFloat3(MaterialFloat2(Local69,Local70),Local67.b),Local73.rgb,DERIV_BASE_VALUE(Local77));
	MaterialFloat2 Local79 = (DERIV_BASE_VALUE(Local15) * ((MaterialFloat2)Material.PreshaderBuffer[12].y));
	MaterialFloat Local80 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 3);
	MaterialFloat4 Local81 = UnpackNormalMap(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local79)));
	MaterialFloat Local82 = MaterialStoreTexSample(Parameters, Local81, 3);
	MaterialFloat Local83 = (Local81.r * Material.PreshaderBuffer[12].z);
	MaterialFloat Local84 = (Local81.g * Material.PreshaderBuffer[12].z);
	MaterialFloat2 Local85 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)Material.PreshaderBuffer[12].w));
	MaterialFloat Local86 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local85), 3);
	MaterialFloat4 Local87 = UnpackNormalMap(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local85)));
	MaterialFloat Local88 = MaterialStoreTexSample(Parameters, Local87, 3);
	MaterialFloat Local89 = (DERIV_BASE_VALUE(Local32) * Material.PreshaderBuffer[13].y);
	MaterialFloat Local90 = PositiveClampedPow(DERIV_BASE_VALUE(Local89),Material.PreshaderBuffer[13].z);
	MaterialFloat Local91 = saturate(DERIV_BASE_VALUE(Local90));
	MaterialFloat3 Local92 = lerp(MaterialFloat3(MaterialFloat2(Local83,Local84),Local81.b),Local87.rgb,DERIV_BASE_VALUE(Local91));
	MaterialFloat Local93 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 2);
	MaterialFloat4 Local94 = Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16));
	MaterialFloat Local95 = MaterialStoreTexSample(Parameters, Local94, 2);
	MaterialFloat Local96 = (Local94.g * Material.PreshaderBuffer[13].w);
	MaterialFloat Local97 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 2);
	MaterialFloat4 Local98 = Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37));
	MaterialFloat Local99 = MaterialStoreTexSample(Parameters, Local98, 2);
	MaterialFloat Local100 = (Local98.g * Material.PreshaderBuffer[14].x);
	MaterialFloat Local101 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local51), 6);
	MaterialFloat4 Local102 = Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local51));
	MaterialFloat Local103 = MaterialStoreTexSample(Parameters, Local102, 6);
	MaterialFloat Local104 = (Local102.g * Material.PreshaderBuffer[14].y);
	MaterialFloat Local105 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 6);
	MaterialFloat4 Local106 = Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65));
	MaterialFloat Local107 = MaterialStoreTexSample(Parameters, Local106, 6);
	MaterialFloat Local108 = (Local106.g * Material.PreshaderBuffer[14].z);
	MaterialFloat Local109 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 2);
	MaterialFloat4 Local110 = Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local79));
	MaterialFloat Local111 = MaterialStoreTexSample(Parameters, Local110, 2);
	MaterialFloat Local112 = (Local110.g * Material.PreshaderBuffer[14].w);
	MaterialFloat3 Local113 = CustomExpression0(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local36,Local50,Local64,Local78,Local92,Local96,Local100,Local104,Local108,Local112);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local113.rgb;


#if TEMPLATE_USES_STRATA
	Parameters.StrataPixelFootprint = StrataGetPixelFootprint(Parameters.WorldPosition_CamRelative, GetRoughnessFromNormalCurvature(Parameters));
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
	Parameters.StrataTree = GetInitialisedStrataTree();
#if STRATA_USE_FULLYSIMPLIFIED_MATERIAL == 1
	Parameters.SharedLocalBasesFullySimplified = StrataInitialiseSharedLocalBases();
	Parameters.StrataTreeFullySimplified = GetInitialisedStrataTree();
#endif
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat3 Local114 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[15].yzw,Material.PreshaderBuffer[15].x);
	MaterialFloat Local115 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 1);
	MaterialFloat4 Local116 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_20,GetMaterialSharedSampler(samplerMaterial_Texture2D_20,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local117 = MaterialStoreTexSample(Parameters, Local116, 1);
	MaterialFloat3 Local118 = (Material.PreshaderBuffer[17].xyz * Local116.rgb);
	MaterialFloat Local119 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 1);
	MaterialFloat4 Local120 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_21,GetMaterialSharedSampler(samplerMaterial_Texture2D_21,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local121 = MaterialStoreTexSample(Parameters, Local120, 1);
	MaterialFloat3 Local122 = (Material.PreshaderBuffer[17].xyz * Local120.rgb);
	MaterialFloat3 Local123 = lerp(Local118,Local122,DERIV_BASE_VALUE(Local35));
	MaterialFloat Local124 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 1);
	MaterialFloat4 Local125 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_22,GetMaterialSharedSampler(samplerMaterial_Texture2D_22,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local126 = MaterialStoreTexSample(Parameters, Local125, 1);
	MaterialFloat3 Local127 = (Material.PreshaderBuffer[19].xyz * Local125.rgb);
	MaterialFloat Local128 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local43), 1);
	MaterialFloat4 Local129 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_23,GetMaterialSharedSampler(samplerMaterial_Texture2D_23,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local43)));
	MaterialFloat Local130 = MaterialStoreTexSample(Parameters, Local129, 1);
	MaterialFloat3 Local131 = (Material.PreshaderBuffer[19].xyz * Local129.rgb);
	MaterialFloat3 Local132 = lerp(Local127,Local131,DERIV_BASE_VALUE(Local49));
	MaterialFloat Local133 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local51), 5);
	MaterialFloat4 Local134 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_24,GetMaterialSharedSampler(samplerMaterial_Texture2D_24,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local51)));
	MaterialFloat Local135 = MaterialStoreTexSample(Parameters, Local134, 5);
	MaterialFloat3 Local136 = (Material.PreshaderBuffer[21].xyz * Local134.rgb);
	MaterialFloat Local137 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local57), 5);
	MaterialFloat4 Local138 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_25,GetMaterialSharedSampler(samplerMaterial_Texture2D_25,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local57)));
	MaterialFloat Local139 = MaterialStoreTexSample(Parameters, Local138, 5);
	MaterialFloat3 Local140 = (Material.PreshaderBuffer[21].xyz * Local138.rgb);
	MaterialFloat3 Local141 = lerp(Local136,Local140,DERIV_BASE_VALUE(Local63));
	MaterialFloat Local142 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 5);
	MaterialFloat4 Local143 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_26,GetMaterialSharedSampler(samplerMaterial_Texture2D_26,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local144 = MaterialStoreTexSample(Parameters, Local143, 5);
	MaterialFloat3 Local145 = (Material.PreshaderBuffer[23].xyz * Local143.rgb);
	MaterialFloat Local146 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local71), 5);
	MaterialFloat4 Local147 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_27,GetMaterialSharedSampler(samplerMaterial_Texture2D_27,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local71)));
	MaterialFloat Local148 = MaterialStoreTexSample(Parameters, Local147, 5);
	MaterialFloat3 Local149 = (Material.PreshaderBuffer[23].xyz * Local147.rgb);
	MaterialFloat3 Local150 = lerp(Local145,Local149,DERIV_BASE_VALUE(Local77));
	MaterialFloat Local151 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 1);
	MaterialFloat4 Local152 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_28,GetMaterialSharedSampler(samplerMaterial_Texture2D_28,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local79)));
	MaterialFloat Local153 = MaterialStoreTexSample(Parameters, Local152, 1);
	MaterialFloat3 Local154 = (Material.PreshaderBuffer[25].xyz * Local152.rgb);
	MaterialFloat2 Local155 = (DERIV_BASE_VALUE(Local13) * Material.PreshaderBuffer[27].xy);
	MaterialFloat2 Local156 = (DERIV_BASE_VALUE(Local155) * ((MaterialFloat2)Material.PreshaderBuffer[27].z));
	MaterialFloat Local157 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local156), 8);
	MaterialFloat4 Local158 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_29,samplerMaterial_Texture2D_29,DERIV_BASE_VALUE(Local156),View.MaterialTextureMipBias));
	MaterialFloat Local159 = MaterialStoreTexSample(Parameters, Local158, 8);
	MaterialFloat3 Local160 = (Local158.rgb * Material.PreshaderBuffer[29].xyz);
	MaterialFloat Local161 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local85), 1);
	MaterialFloat4 Local162 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_30,GetMaterialSharedSampler(samplerMaterial_Texture2D_30,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local85)));
	MaterialFloat Local163 = MaterialStoreTexSample(Parameters, Local162, 1);
	MaterialFloat3 Local164 = (Material.PreshaderBuffer[25].xyz * Local162.rgb);
	MaterialFloat3 Local165 = lerp(Local154,Local164,DERIV_BASE_VALUE(Local91));
	MaterialFloat3 Local166 = CustomExpression1(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local123,Local132,Local141,Local150,Local165,Local96,Local100,Local104,Local108,Local112);
	MaterialFloat Local167 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 4);
	MaterialFloat4 Local168 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_31,GetMaterialSharedSampler(samplerMaterial_Texture2D_31,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local169 = MaterialStoreTexSample(Parameters, Local168, 4);
	MaterialFloat3 Local170 = (((MaterialFloat3)Material.PreshaderBuffer[29].w) * Local168.rgb);
	MaterialFloat Local171 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 4);
	MaterialFloat4 Local172 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_32,GetMaterialSharedSampler(samplerMaterial_Texture2D_32,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local173 = MaterialStoreTexSample(Parameters, Local172, 4);
	MaterialFloat3 Local174 = (((MaterialFloat3)Material.PreshaderBuffer[30].x) * Local172.rgb);
	MaterialFloat Local175 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local51), 4);
	MaterialFloat4 Local176 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_33,GetMaterialSharedSampler(samplerMaterial_Texture2D_33,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local51)));
	MaterialFloat Local177 = MaterialStoreTexSample(Parameters, Local176, 4);
	MaterialFloat3 Local178 = (((MaterialFloat3)Material.PreshaderBuffer[30].y) * Local176.rgb);
	MaterialFloat Local179 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 4);
	MaterialFloat4 Local180 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_34,GetMaterialSharedSampler(samplerMaterial_Texture2D_34,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local181 = MaterialStoreTexSample(Parameters, Local180, 4);
	MaterialFloat3 Local182 = (((MaterialFloat3)Material.PreshaderBuffer[30].z) * Local180.rgb);
	MaterialFloat Local183 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 4);
	MaterialFloat4 Local184 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_35,GetMaterialSharedSampler(samplerMaterial_Texture2D_35,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local79)));
	MaterialFloat Local185 = MaterialStoreTexSample(Parameters, Local184, 4);
	MaterialFloat3 Local186 = (((MaterialFloat3)Material.PreshaderBuffer[30].w) * Local184.rgb);
	MaterialFloat3 Local187 = CustomExpression2(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local170,Local174,Local178,Local182,Local186,Local96,Local100,Local104,Local108,Local112);
	MaterialFloat4 Local188 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_36,GetMaterialSharedSampler(samplerMaterial_Texture2D_36,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local189 = MaterialStoreTexSample(Parameters, Local188, 4);
	MaterialFloat3 Local190 = (((MaterialFloat3)Material.PreshaderBuffer[31].x) * Local188.rgb);
	MaterialFloat4 Local191 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_37,GetMaterialSharedSampler(samplerMaterial_Texture2D_37,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local192 = MaterialStoreTexSample(Parameters, Local191, 4);
	MaterialFloat3 Local193 = (((MaterialFloat3)Material.PreshaderBuffer[31].y) * Local191.rgb);
	MaterialFloat4 Local194 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_38,GetMaterialSharedSampler(samplerMaterial_Texture2D_38,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local51)));
	MaterialFloat Local195 = MaterialStoreTexSample(Parameters, Local194, 4);
	MaterialFloat3 Local196 = (((MaterialFloat3)Material.PreshaderBuffer[31].z) * Local194.rgb);
	MaterialFloat4 Local197 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_39,GetMaterialSharedSampler(samplerMaterial_Texture2D_39,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local198 = MaterialStoreTexSample(Parameters, Local197, 4);
	MaterialFloat3 Local199 = (((MaterialFloat3)Material.PreshaderBuffer[31].w) * Local197.rgb);
	MaterialFloat4 Local200 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_40,GetMaterialSharedSampler(samplerMaterial_Texture2D_40,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local79)));
	MaterialFloat Local201 = MaterialStoreTexSample(Parameters, Local200, 4);
	MaterialFloat3 Local202 = (((MaterialFloat3)Material.PreshaderBuffer[32].x) * Local200.rgb);
	MaterialFloat3 Local203 = CustomExpression3(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local190,Local193,Local196,Local199,Local202,Local96,Local100,Local104,Local108,Local112);
	MaterialFloat Local204 = (Material.PreshaderBuffer[32].y * Local94.r);
	MaterialFloat Local205 = (Material.PreshaderBuffer[32].z * Local98.r);
	MaterialFloat Local206 = (Material.PreshaderBuffer[32].w * Local102.r);
	MaterialFloat Local207 = (Material.PreshaderBuffer[33].x * Local106.r);
	MaterialFloat Local208 = (Material.PreshaderBuffer[33].y * Local110.r);
	MaterialFloat3 Local209 = CustomExpression4(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local204,Local205,Local206,Local207,Local208,Local96,Local100,Local104,Local108,Local112);
	MaterialFloat Local210 = (Local110.b * Material.PreshaderBuffer[33].z);
	MaterialFloat3 Local211 = CustomExpression5(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local94.b,Local98.b,Local102.b,Local106.b,Local210,Local96,Local100,Local104,Local108,Local112);

	PixelMaterialInputs.EmissiveColor = Local114;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local166.rgb;
	PixelMaterialInputs.Metallic = Local187.r;
	PixelMaterialInputs.Specular = Local203.r;
	PixelMaterialInputs.Roughness = Local209.r;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local113.rgb;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local211.r;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();
	PixelMaterialInputs.SurfaceThickness = 0.01000000;
	PixelMaterialInputs.Displacement = 0.00000000;


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}

#define UnityObjectToWorldDir TransformObjectToWorld

void SetupCommonData( int Parameters_PrimitiveId )
{
	View_MaterialTextureBilinearWrapedSampler = SamplerState_Linear_Repeat;
	View_MaterialTextureBilinearClampedSampler = SamplerState_Linear_Clamp;

	Material_Wrap_WorldGroupSettings = SamplerState_Linear_Repeat;
	Material_Clamp_WorldGroupSettings = SamplerState_Linear_Clamp;

	View.GameTime = View.RealTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
	View.PrevFrameGameTime = View.GameTime - unity_DeltaTime.x;//(dt, 1/dt, smoothDt, 1/smoothDt)
	View.PrevFrameRealTime = View.RealTime;
	View.DeltaTime = unity_DeltaTime.x;
	View.MaterialTextureMipBias = 0.0;
	View.TemporalAAParams = float4( 0, 0, 0, 0 );
	View.ViewRectMin = float2( 0, 0 );
	View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
	View.MaterialTextureDerivativeMultiply = 1.0f;
	View.StateFrameIndexMod8 = 0;
	View.FrameNumber = (int)_Time.y;
	View.FieldOfViewWideAngles = float2( PI * 0.42f, PI * 0.42f );//75degrees, default unity
	View.RuntimeVirtualTextureMipLevel = float4( 0, 0, 0, 0 );
	View.PreExposure = 0;
	View.BufferBilinearUVMinMax = float4(
		View_BufferSizeAndInvSize.z * ( 0 + 0.5 ),//EffectiveViewRect.Min.X
		View_BufferSizeAndInvSize.w * ( 0 + 0.5 ),//EffectiveViewRect.Min.Y
		View_BufferSizeAndInvSize.z * ( View_BufferSizeAndInvSize.x - 0.5 ),//EffectiveViewRect.Max.X
		View_BufferSizeAndInvSize.w * ( View_BufferSizeAndInvSize.y - 0.5 ) );//EffectiveViewRect.Max.Y

	for( int i2 = 0; i2 < 40; i2++ )
		View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

	float4x4 LocalToWorld = transpose( UNITY_MATRIX_M );
    LocalToWorld[3] = float4(ToUnrealPos(LocalToWorld[3]), LocalToWorld[3].w);
	float4x4 WorldToLocal = transpose( UNITY_MATRIX_I_M );
	float4x4 ViewMatrix = transpose( UNITY_MATRIX_V );
	float4x4 InverseViewMatrix = transpose( UNITY_MATRIX_I_V );
	float4x4 ViewProjectionMatrix = transpose( UNITY_MATRIX_VP );
	uint PrimitiveBaseOffset = Parameters_PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = LocalToWorld[ 0 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = LocalToWorld[ 1 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = LocalToWorld[ 2 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = LocalToWorld[ 3 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 5 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 100.0 );//ObjectWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = WorldToLocal[ 0 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = WorldToLocal[ 1 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = WorldToLocal[ 2 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = WorldToLocal[ 3 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = LocalToWorld[ 0 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = LocalToWorld[ 1 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = LocalToWorld[ 2 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = LocalToWorld[ 3 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 18 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 0 );//ActorWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 19 ] = LocalObjectBoundsMax - LocalObjectBoundsMin;//ObjectBounds
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 21 ] = mul( LocalToWorld, float3( 1, 0, 0 ) );
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 23 ] = LocalObjectBoundsMin;//LocalObjectBoundsMin 
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 24 ] = LocalObjectBoundsMax;//LocalObjectBoundsMax

#ifdef UE5
	ResolvedView.WorldCameraOrigin = LWCPromote( ToUnrealPos( _WorldSpaceCameraPos.xyz ) );
	ResolvedView.PreViewTranslation = LWCPromote( float3( 0, 0, 0 ) );
	ResolvedView.WorldViewOrigin = LWCPromote( float3( 0, 0, 0 ) );
#else
	ResolvedView.WorldCameraOrigin = ToUnrealPos( _WorldSpaceCameraPos.xyz );
	ResolvedView.PreViewTranslation = float3( 0, 0, 0 );
	ResolvedView.WorldViewOrigin = float3( 0, 0, 0 );
#endif
	ResolvedView.PrevWorldCameraOrigin = ResolvedView.WorldCameraOrigin;
	ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
	ResolvedView.TranslatedWorldToView		 = ViewMatrix;
	ResolvedView.TranslatedWorldToCameraView = ViewMatrix;
	ResolvedView.TranslatedWorldToClip		 = ViewProjectionMatrix;
	ResolvedView.ViewToTranslatedWorld		 = InverseViewMatrix;
	ResolvedView.PrevViewToTranslatedWorld = ResolvedView.ViewToTranslatedWorld;
	ResolvedView.CameraViewToTranslatedWorld = InverseViewMatrix;
	ResolvedView.BufferBilinearUVMinMax = View.BufferBilinearUVMinMax;
	Primitive.WorldToLocal = WorldToLocal;
	Primitive.LocalToWorld = LocalToWorld;
}
#define VS_USES_UNREAL_SPACE 1
float3 PrepareAndGetWPO( float4 VertexColor, float3 UnrealWorldPos, float3 UnrealNormal, float4 InTangent,
						 float4 UV0, float4 UV1 )
{
	InitializeExpressions();
	FMaterialVertexParameters Parameters = (FMaterialVertexParameters)0;

	float3 InWorldNormal = UnrealNormal;
	float4 tangentWorld = InTangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	
	#ifdef VS_USES_UNREAL_SPACE
		UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	#endif
	Parameters.WorldPosition = UnrealWorldPos;
	#ifdef VS_USES_UNREAL_SPACE
		Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
		Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
		Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up
	#endif

	Parameters.VertexColor = VertexColor;

#if NUM_MATERIAL_TEXCOORDS_VERTEX > 0			
	Parameters.TexCoords[ 0 ] = float2( UV0.x, UV0.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 1
	Parameters.TexCoords[ 1 ] = float2( UV1.x, UV1.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( UV0.x, UV0.y );
	}
#endif

	Parameters.PrimitiveId = 0;

	SetupCommonData( Parameters.PrimitiveId );

#ifdef UE5
	Parameters.PrevFrameLocalToWorld = MakeLWCMatrix( float3( 0, 0, 0 ), Primitive.LocalToWorld );
#else
	Parameters.PrevFrameLocalToWorld = Primitive.LocalToWorld;
#endif
	
	float3 Offset = float3( 0, 0, 0 );
	//Offset = GetMaterialWorldPositionOffset( Parameters );
	#ifdef VS_USES_UNREAL_SPACE
		//Convert from unreal units to unity
		Offset /= float3( 100, 100, 100 );
		Offset = Offset.xzy;
	#endif
	return Offset;
}

void SurfaceReplacement( Input In, out SurfaceOutputStandard o )
{
	InitializeExpressions();

	float3 Z3 = float3( 0, 0, 0 );
	float4 Z4 = float4( 0, 0, 0, 0 );

	float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );

	float3 UnrealNormal = In.normal2;	

	FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
#if NUM_TEX_COORD_INTERPOLATORS > 0			
	Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 1
	Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, 1.0 - In.uv2_Material_Texture2D_0.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
	}
#endif
	Parameters.VertexColor = In.color;
	Parameters.WorldNormal = UnrealNormal;
	Parameters.ReflectionVector = half3( 0, 0, 1 );
	Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
	//Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
	Parameters.LightVector = half3( 0, 0, 0 );
	//float4 screenpos = In.screenPos;
	//screenpos /= screenpos.w;
	Parameters.SvPosition = In.screenPos;
	Parameters.ScreenPosition = Parameters.SvPosition;

	Parameters.UnMirrored = 1;

	Parameters.TwoSidedSign = 1;


	float3 InWorldNormal = UnrealNormal;	
	float4 tangentWorld = In.tangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
	//but watch out for any computation that might get skewed as a side effect
	UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	
	Parameters.AbsoluteWorldPosition = UnrealWorldPos;
	Parameters.WorldPosition_CamRelative = UnrealWorldPos;
	Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

	Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
	Parameters.LightingPositionOffset = float3( 0, 0, 0 );

	Parameters.AOMaterialMask = 0;

	Parameters.Particle.RelativeTime = 0;
	Parameters.Particle.MotionBlurFade;
	Parameters.Particle.Random = 0;
	Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
	Parameters.Particle.Color = half4( 1, 1, 1, 1 );
	Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
	Parameters.Particle.MacroUV = half4( 0, 0, 1, 1 );
	Parameters.Particle.DynamicParameter = half4( 0, 0, 0, 0 );
	Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
	Parameters.Particle.Size = float2( 1, 1 );
	Parameters.Particle.SubUVCoords[ 0 ] = Parameters.Particle.SubUVCoords[ 1 ] = float2( 0, 0 );
	Parameters.Particle.SubUVLerp = 0.0;
	Parameters.TexCoordScalesParams = float2( 0, 0 );
	Parameters.PrimitiveId = 0;
	Parameters.VirtualTextureFeedback = 0;

	FPixelMaterialInputs PixelMaterialInputs = (FPixelMaterialInputs)0;
	PixelMaterialInputs.Normal = float3( 0, 0, 1 );
	PixelMaterialInputs.ShadingModel = 0;
	PixelMaterialInputs.FrontMaterial = 0;

	SetupCommonData( Parameters.PrimitiveId );
	//CustomizedUVs
	#if NUM_TEX_COORD_INTERPOLATORS > 0 && HAS_CUSTOMIZED_UVS
		float2 OutTexCoords[ NUM_TEX_COORD_INTERPOLATORS ];
		//Prevent uninitialized reads
		for( int i = 0; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
		{
			OutTexCoords[ i ] = float2( 0, 0 );
		}
		GetMaterialCustomizedUVs( Parameters, OutTexCoords );
		for( int i = 0; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
		{
			Parameters.TexCoords[ i ] = OutTexCoords[ i ];
		}
	#endif
	//<-
	CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

	#define HAS_WORLDSPACE_NORMAL 0
	#if HAS_WORLDSPACE_NORMAL
		PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( Parameters.TangentToWorld ) ) );
	#endif

	o.Albedo = PixelMaterialInputs.BaseColor.rgb;
	o.Alpha = PixelMaterialInputs.Opacity;
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}