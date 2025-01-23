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
	float4 PreshaderBuffer[45];
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
	Material.PreshaderBuffer[1] = float4(2.000000,2.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(2.000000,2.000000,1.000000,0.200000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.050000,1200.000000,1500.000000,0.000667);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,0.000000,0.200000,0.050000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,0.000000,0.300000,0.070000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.000000,0.300000,0.100000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.000000,0.200000,0.100000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.200000,0.050000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,1.000000,0.250000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.200000,0.200000,0.050000,0.050000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.200000,0.200000,0.200000,0.200000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.050000,0.050000,0.050000,0.050000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.400000,0.600000,16.000000,0.700000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.000000,0.000000,-0.200000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,0.865451,0.677083,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(1.000000,0.865451,0.677083,1.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.000000,0.000000,-0.200000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,0.721153,0.520833,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,0.721153,0.520833,1.200000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(1.000000,1.000000,1.000000,0.650000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(1.000000,1.000000,1.000000,0.794234);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(1.000000,1.000000,1.000000,0.800000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(-0.500000,0.500000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(0.057292,0.051375,0.034017,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(1.000000,0.057292,0.051375,0.034017);//(Unknown)
	Material.PreshaderBuffer[37] = float4(0.750000,0.057292,0.051375,0.034017);//(Unknown)
	Material.PreshaderBuffer[38] = float4(0.213400,0.500000,0.053410,0.500000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.002000,0.500000,-0.400000,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(0.500000,0.500000,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(0.500000,0.500000,0.500000,10.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(-10.000000,20.000000,0.050000,0.500000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.500000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.150000,0.850000,0.100000,0.750000);//(Unknown)
}
MaterialFloat3 CustomExpression9(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat3 Grass,MaterialFloat3 Mud,MaterialFloat3 Rock,MaterialFloat3 Cooblestone,MaterialFloat3 Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression8(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression7(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression6(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat3 Grass,MaterialFloat3 Mud,MaterialFloat3 Rock,MaterialFloat3 Cooblestone,MaterialFloat3 Sand,MaterialFloat3 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression5(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression4(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression3(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat Grass,MaterialFloat Mud,MaterialFloat Rock,MaterialFloat Cooblestone,MaterialFloat Sand,MaterialFloat Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat3 Grass,MaterialFloat3 Mud,MaterialFloat3 Rock,MaterialFloat3 Cooblestone,MaterialFloat3 Sand,MaterialFloat3 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat GrassWeight,MaterialFloat MudWeight,MaterialFloat RockWeight,MaterialFloat CooblestoneWeight,MaterialFloat SandWeight,MaterialFloat Sand2Weight,MaterialFloat3 Grass,MaterialFloat3 Mud,MaterialFloat3 Rock,MaterialFloat3 Cooblestone,MaterialFloat3 Sand,MaterialFloat4 Sand2,MaterialFloat GrassHeight,MaterialFloat MudHeight,MaterialFloat RockHeight,MaterialFloat CooblestoneHeight,MaterialFloat SandHeight,MaterialFloat Sand2Height)
{
float  lerpres;
float  Local0;
lerpres = lerp( -1.0, 1.0, GrassWeight );
Local0 = ( lerpres + GrassHeight );
float Layer1WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, MudWeight );
Local0 = ( lerpres + MudHeight );
float Layer2WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, RockWeight );
Local0 = ( lerpres + RockHeight );
float Layer3WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, CooblestoneWeight );
Local0 = ( lerpres + CooblestoneHeight );
float Layer4WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, SandWeight );
Local0 = ( lerpres + SandHeight );
float Layer5WithHeight = clamp(Local0, 0.0001, 1.0);

lerpres = lerp( -1.0, 1.0, Sand2Weight );
Local0 = ( lerpres + Sand2Height );
float Layer6WithHeight = clamp(Local0, 0.0001, 1.0);

float  AllWeightsAndHeights = Layer1WithHeight + Layer2WithHeight + Layer3WithHeight + Layer4WithHeight + Layer5WithHeight + Layer6WithHeight + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(Layer1WithHeight,Layer1WithHeight,Layer1WithHeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(Layer2WithHeight,Layer2WithHeight,Layer2WithHeight) * Mud;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(Layer3WithHeight,Layer3WithHeight,Layer3WithHeight) * Rock;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(Layer4WithHeight,Layer4WithHeight,Layer4WithHeight) * Cooblestone;
float3  Layer5Contribution = float3(Divider,Divider,Divider) * float3(Layer5WithHeight,Layer5WithHeight,Layer5WithHeight) * Sand;
float3  Layer6Contribution = float3(Divider,Divider,Divider) * float3(Layer6WithHeight,Layer6WithHeight,Layer6WithHeight) * Sand2;
float3  Result = Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + Layer5Contribution + Layer6Contribution + float3(0,0,0);
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
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) + MaterialFloat4(1.00000000,1.00000000,1.00000000,1.00000000).rg);
	MaterialFloat2 Local2 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[2].xy);
	MaterialFloat2 Local3 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)Material.PreshaderBuffer[2].z));
	MaterialFloat Local4 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local3), 17);
	MaterialFloat4 Local5 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 17);
	MaterialFloat4 Local7 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local8 = MaterialStoreTexSample(Parameters, Local7, 17);
	MaterialFloat4 Local9 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 17);
	MaterialFloat4 Local11 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local12 = MaterialStoreTexSample(Parameters, Local11, 17);
	MaterialFloat4 Local13 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 17);
	MaterialFloat4 Local15 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local16 = MaterialStoreTexSample(Parameters, Local15, 17);
	MaterialFloat2 Local17 = (DERIV_BASE_VALUE(Local2) + MaterialFloat4(1.00000000,1.00000000,1.00000000,1.00000000).rg);
	MaterialFloat2 Local18 = (DERIV_BASE_VALUE(Local17) * Material.PreshaderBuffer[2].xy);
	MaterialFloat2 Local19 = (((MaterialFloat2)Material.PreshaderBuffer[2].w) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local19), 7);
	MaterialFloat4 Local21 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local19)));
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 7);
	MaterialFloat2 Local23 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local21.r,Local21.g));
	MaterialFloat2 Local24 = (Local23 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local25 = dot(Local24,Local24);
	MaterialFloat Local26 = (1.00000000 - Local25);
	MaterialFloat Local27 = saturate(Local26);
	MaterialFloat Local28 = sqrt(Local27);
	MaterialFloat2 Local29 = (((MaterialFloat2)Material.PreshaderBuffer[3].x) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local30 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local29), 7);
	MaterialFloat4 Local31 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local29)));
	MaterialFloat Local32 = MaterialStoreTexSample(Parameters, Local31, 7);
	MaterialFloat2 Local33 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local31.r,Local31.g));
	MaterialFloat2 Local34 = (Local33 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local35 = dot(Local34,Local34);
	MaterialFloat Local36 = (1.00000000 - Local35);
	MaterialFloat Local37 = saturate(Local36);
	MaterialFloat Local38 = sqrt(Local37);
	FLWCVector3 Local39 = GetWorldPosition(Parameters);
	FLWCVector3 Local40 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local39)), LWCGetY(DERIV_BASE_VALUE(Local39)), LWCGetZ(DERIV_BASE_VALUE(Local39)));
	FLWCVector3 Local41 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local42 = LWCSubtract(DERIV_BASE_VALUE(Local40), Local41);
	MaterialFloat3 Local43 = LWCToFloat(DERIV_BASE_VALUE(Local42));
	MaterialFloat Local44 = length(DERIV_BASE_VALUE(Local43));
	MaterialFloat Local45 = (DERIV_BASE_VALUE(Local44) * 0.10000000);
	MaterialFloat Local46 = View.RuntimeVirtualTextureMipLevel.x;
	MaterialFloat Local47 = PositiveClampedPow(2.00000000,Local46);
	MaterialFloat Local48 = (GetRuntimeVirtualTextureOutputSwitch() ? (Local47) : (DERIV_BASE_VALUE(Local45)));
	MaterialFloat Local49 = (Local48 - Material.PreshaderBuffer[3].y);
	MaterialFloat Local50 = (Local49 * Material.PreshaderBuffer[3].w);
	MaterialFloat Local51 = (Local50 * 100.00000000);
	MaterialFloat Local52 = saturate(Local51);
	MaterialFloat3 Local53 = lerp(MaterialFloat3(Local24,Local28),MaterialFloat3(Local34,Local38),Local52);
	MaterialFloat3 Local54 = lerp(Local53,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[4].y);
	MaterialFloat2 Local55 = (((MaterialFloat2)Material.PreshaderBuffer[4].z) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local56 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local55), 9);
	MaterialFloat4 Local57 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local55)));
	MaterialFloat Local58 = MaterialStoreTexSample(Parameters, Local57, 9);
	MaterialFloat2 Local59 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local57.r,Local57.g));
	MaterialFloat2 Local60 = (Local59 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local61 = dot(Local60,Local60);
	MaterialFloat Local62 = (1.00000000 - Local61);
	MaterialFloat Local63 = saturate(Local62);
	MaterialFloat Local64 = sqrt(Local63);
	MaterialFloat2 Local65 = (((MaterialFloat2)Material.PreshaderBuffer[4].w) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local66 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 9);
	MaterialFloat4 Local67 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local68 = MaterialStoreTexSample(Parameters, Local67, 9);
	MaterialFloat2 Local69 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local67.r,Local67.g));
	MaterialFloat2 Local70 = (Local69 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local71 = dot(Local70,Local70);
	MaterialFloat Local72 = (1.00000000 - Local71);
	MaterialFloat Local73 = saturate(Local72);
	MaterialFloat Local74 = sqrt(Local73);
	MaterialFloat3 Local75 = lerp(MaterialFloat3(Local60,Local64),MaterialFloat3(Local70,Local74),Local52);
	MaterialFloat3 Local76 = lerp(Local75,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[5].y);
	MaterialFloat2 Local77 = (((MaterialFloat2)Material.PreshaderBuffer[5].z) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local78 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local77), 12);
	MaterialFloat4 Local79 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local77)));
	MaterialFloat Local80 = MaterialStoreTexSample(Parameters, Local79, 12);
	MaterialFloat2 Local81 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local79.r,Local79.g));
	MaterialFloat2 Local82 = (Local81 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local83 = dot(Local82,Local82);
	MaterialFloat Local84 = (1.00000000 - Local83);
	MaterialFloat Local85 = saturate(Local84);
	MaterialFloat Local86 = sqrt(Local85);
	MaterialFloat2 Local87 = (((MaterialFloat2)Material.PreshaderBuffer[5].w) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local88 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local87), 12);
	MaterialFloat4 Local89 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local87)));
	MaterialFloat Local90 = MaterialStoreTexSample(Parameters, Local89, 12);
	MaterialFloat2 Local91 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local89.r,Local89.g));
	MaterialFloat2 Local92 = (Local91 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local93 = dot(Local92,Local92);
	MaterialFloat Local94 = (1.00000000 - Local93);
	MaterialFloat Local95 = saturate(Local94);
	MaterialFloat Local96 = sqrt(Local95);
	MaterialFloat3 Local97 = lerp(MaterialFloat3(Local82,Local86),MaterialFloat3(Local92,Local96),Local52);
	MaterialFloat3 Local98 = lerp(Local97,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[6].y);
	MaterialFloat2 Local99 = (((MaterialFloat2)Material.PreshaderBuffer[6].z) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local100 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local99), 14);
	MaterialFloat4 Local101 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local99)));
	MaterialFloat Local102 = MaterialStoreTexSample(Parameters, Local101, 14);
	MaterialFloat2 Local103 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local101.r,Local101.g));
	MaterialFloat2 Local104 = (Local103 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local105 = dot(Local104,Local104);
	MaterialFloat Local106 = (1.00000000 - Local105);
	MaterialFloat Local107 = saturate(Local106);
	MaterialFloat Local108 = sqrt(Local107);
	MaterialFloat2 Local109 = (((MaterialFloat2)Material.PreshaderBuffer[6].w) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local110 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local109), 14);
	MaterialFloat4 Local111 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local109)));
	MaterialFloat Local112 = MaterialStoreTexSample(Parameters, Local111, 14);
	MaterialFloat2 Local113 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local111.r,Local111.g));
	MaterialFloat2 Local114 = (Local113 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local115 = dot(Local114,Local114);
	MaterialFloat Local116 = (1.00000000 - Local115);
	MaterialFloat Local117 = saturate(Local116);
	MaterialFloat Local118 = sqrt(Local117);
	MaterialFloat3 Local119 = lerp(MaterialFloat3(Local104,Local108),MaterialFloat3(Local114,Local118),Local52);
	MaterialFloat3 Local120 = lerp(Local119,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[7].y);
	MaterialFloat2 Local121 = (((MaterialFloat2)Material.PreshaderBuffer[7].z) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local122 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local121), 16);
	MaterialFloat4 Local123 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local121)));
	MaterialFloat Local124 = MaterialStoreTexSample(Parameters, Local123, 16);
	MaterialFloat2 Local125 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local123.r,Local123.g));
	MaterialFloat2 Local126 = (Local125 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local127 = dot(Local126,Local126);
	MaterialFloat Local128 = (1.00000000 - Local127);
	MaterialFloat Local129 = saturate(Local128);
	MaterialFloat Local130 = sqrt(Local129);
	MaterialFloat2 Local131 = (((MaterialFloat2)Material.PreshaderBuffer[7].w) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local132 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local131), 16);
	MaterialFloat4 Local133 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local131)));
	MaterialFloat Local134 = MaterialStoreTexSample(Parameters, Local133, 16);
	MaterialFloat2 Local135 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local133.r,Local133.g));
	MaterialFloat2 Local136 = (Local135 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local137 = dot(Local136,Local136);
	MaterialFloat Local138 = (1.00000000 - Local137);
	MaterialFloat Local139 = saturate(Local138);
	MaterialFloat Local140 = sqrt(Local139);
	MaterialFloat3 Local141 = lerp(MaterialFloat3(Local126,Local130),MaterialFloat3(Local136,Local140),Local52);
	MaterialFloat3 Local142 = lerp(Local141,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[7].y);
	MaterialFloat2 Local143 = (((MaterialFloat2)Material.PreshaderBuffer[8].x) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local144 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local143), 5);
	MaterialFloat4 Local145 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local143)));
	MaterialFloat Local146 = MaterialStoreTexSample(Parameters, Local145, 5);
	MaterialFloat Local147 = (Local145.a * 2.00000000);
	MaterialFloat Local148 = (Local147 + -1.00000000);
	MaterialFloat2 Local149 = (((MaterialFloat2)Material.PreshaderBuffer[8].y) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local150 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local149), 5);
	MaterialFloat4 Local151 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local149)));
	MaterialFloat Local152 = MaterialStoreTexSample(Parameters, Local151, 5);
	MaterialFloat Local153 = (Local151.a * 2.00000000);
	MaterialFloat Local154 = (Local153 + -1.00000000);
	MaterialFloat Local155 = lerp(Local148,Local154,Local52);
	MaterialFloat Local156 = (Local155 * Material.PreshaderBuffer[8].z);
	MaterialFloat Local157 = PositiveClampedPow(Local156,Material.PreshaderBuffer[8].w);
	MaterialFloat Local158 = (Local21.a * 2.00000000);
	MaterialFloat Local159 = (Local158 + -1.00000000);
	MaterialFloat Local160 = (Local31.a * 2.00000000);
	MaterialFloat Local161 = (Local160 + -1.00000000);
	MaterialFloat Local162 = lerp(Local159,Local161,Local52);
	MaterialFloat Local163 = (Local162 * Material.PreshaderBuffer[9].x);
	MaterialFloat Local164 = PositiveClampedPow(Local163,Material.PreshaderBuffer[9].y);
	MaterialFloat Local165 = (Local57.a * 2.00000000);
	MaterialFloat Local166 = (Local165 + -1.00000000);
	MaterialFloat Local167 = (Local67.a * 2.00000000);
	MaterialFloat Local168 = (Local167 + -1.00000000);
	MaterialFloat Local169 = lerp(Local166,Local168,Local52);
	MaterialFloat Local170 = (Local169 * Material.PreshaderBuffer[9].z);
	MaterialFloat Local171 = PositiveClampedPow(Local170,Material.PreshaderBuffer[9].w);
	MaterialFloat Local172 = (Local79.a * 2.00000000);
	MaterialFloat Local173 = (Local172 + -1.00000000);
	MaterialFloat Local174 = (Local89.a * 2.00000000);
	MaterialFloat Local175 = (Local174 + -1.00000000);
	MaterialFloat Local176 = lerp(Local173,Local175,Local52);
	MaterialFloat Local177 = (Local176 * Material.PreshaderBuffer[10].x);
	MaterialFloat Local178 = PositiveClampedPow(Local177,Material.PreshaderBuffer[10].y);
	MaterialFloat Local179 = (Local101.a * 2.00000000);
	MaterialFloat Local180 = (Local179 + -1.00000000);
	MaterialFloat Local181 = (Local111.a * 2.00000000);
	MaterialFloat Local182 = (Local181 + -1.00000000);
	MaterialFloat Local183 = lerp(Local180,Local182,Local52);
	MaterialFloat Local184 = (Local183 * Material.PreshaderBuffer[10].z);
	MaterialFloat Local185 = PositiveClampedPow(Local184,Material.PreshaderBuffer[10].w);
	MaterialFloat Local186 = (Local123.a * 2.00000000);
	MaterialFloat Local187 = (Local186 + -1.00000000);
	MaterialFloat Local188 = (Local133.a * 2.00000000);
	MaterialFloat Local189 = (Local188 + -1.00000000);
	MaterialFloat Local190 = lerp(Local187,Local189,Local52);
	MaterialFloat Local191 = (Local190 * Material.PreshaderBuffer[11].x);
	MaterialFloat Local192 = PositiveClampedPow(Local191,Material.PreshaderBuffer[11].y);
	MaterialFloat3 Local193 = CustomExpression0(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,Local54,Local76,Local98,Local120,Local142,MaterialFloat4(0.00000000,0.00000000,0.00000000,0.00000000),Local157,Local164,Local171,Local178,Local185,Local192);
	MaterialFloat4 Local194 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local3)));
	MaterialFloat Local195 = MaterialStoreTexSample(Parameters, Local194, 17);
	MaterialFloat Local196 = (Local194.r * 2.00000000);
	MaterialFloat Local197 = ((1.00000000 - 1.00000000) + Local196);
	MaterialFloat Local198 = saturate(Local197);
	MaterialFloat3 Local199 = lerp(Local193,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[13].x);
	MaterialFloat Local200 = (Local194.r - 0.50000000);
	MaterialFloat Local201 = (Local200 / 0.50000000);
	MaterialFloat Local202 = saturate(Local201);
	MaterialFloat Local203 = (1.00000000 - Local202);
	MaterialFloat Local204 = (1.00000000 + Local203);
	MaterialFloat Local205 = (Local204 + 1.00000000);
	MaterialFloat Local206 = (2.00000000 * Local202);
	MaterialFloat Local207 = (Local206 + 1.00000000);
	MaterialFloat Local208 = (Local205 - Local207);
	MaterialFloat Local209 = saturate(Local208);
	MaterialFloat Local210 = lerp((0.00000000 - 0.00000000),(0.00000000 + 1.00000000),Local209);
	MaterialFloat Local211 = saturate(Local210);
	MaterialFloat3 Local212 = lerp(Local199,Local193,Local211.r.r);
	MaterialFloat2 Local213 = (DERIV_BASE_VALUE(Local18) * Material.PreshaderBuffer[15].zw);
	MaterialFloat2 Local214 = (Material.PreshaderBuffer[16].zw * ((MaterialFloat2)View.GameTime));
	MaterialFloat2 Local215 = (DERIV_BASE_VALUE(Local213) + Local214);
	MaterialFloat Local216 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local215), 0);
	MaterialFloat4 Local217 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_13,samplerMaterial_Texture2D_13,DERIV_BASE_VALUE(Local215),View.MaterialTextureMipBias));
	MaterialFloat Local218 = MaterialStoreTexSample(Parameters, Local217, 0);
	MaterialFloat3 Local219 = lerp(Local217.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[17].y);
	MaterialFloat Local220 = PositiveClampedPow(Local194.r,Material.PreshaderBuffer[17].z);
	MaterialFloat Local221 = (Local220 * Material.PreshaderBuffer[17].w);
	MaterialFloat Local222 = saturate(Local221);
	MaterialFloat3 Local223 = lerp(Local212,Local219,Local222);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local223;


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
	MaterialFloat3 Local224 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[18].yzw,Material.PreshaderBuffer[18].x);
	MaterialFloat Local225 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local19), 6);
	MaterialFloat4 Local226 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local19)));
	MaterialFloat Local227 = MaterialStoreTexSample(Parameters, Local226, 6);
	MaterialFloat Local228 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local29), 6);
	MaterialFloat4 Local229 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local29)));
	MaterialFloat Local230 = MaterialStoreTexSample(Parameters, Local229, 6);
	MaterialFloat3 Local231 = lerp(Local226.rgb,Local229.rgb,Local52);
	MaterialFloat Local232 = dot(Local231,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local233 = lerp(Local231,((MaterialFloat3)Local232),Material.PreshaderBuffer[19].z);
	MaterialFloat3 Local234 = (Local233 * Material.PreshaderBuffer[21].xyz);
	MaterialFloat3 Local235 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[19].y),((MaterialFloat3)0.00000000),Local234);
	MaterialFloat3 Local236 = (Local235 + Local234);
	MaterialFloat3 Local237 = (((MaterialFloat3)Material.PreshaderBuffer[21].w) * Local236);
	MaterialFloat Local238 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local55), 8);
	MaterialFloat4 Local239 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local55)));
	MaterialFloat Local240 = MaterialStoreTexSample(Parameters, Local239, 8);
	MaterialFloat Local241 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local65), 8);
	MaterialFloat4 Local242 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local65)));
	MaterialFloat Local243 = MaterialStoreTexSample(Parameters, Local242, 8);
	MaterialFloat3 Local244 = lerp(Local239.rgb,Local242.rgb,Local52);
	MaterialFloat Local245 = dot(Local244,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local246 = lerp(Local244,((MaterialFloat3)Local245),Material.PreshaderBuffer[22].z);
	MaterialFloat3 Local247 = (Local246 * Material.PreshaderBuffer[24].xyz);
	MaterialFloat3 Local248 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[22].y),((MaterialFloat3)0.00000000),Local247);
	MaterialFloat3 Local249 = (Local248 + Local247);
	MaterialFloat3 Local250 = (((MaterialFloat3)Material.PreshaderBuffer[24].w) * Local249);
	MaterialFloat Local251 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local77), 11);
	MaterialFloat4 Local252 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local77)));
	MaterialFloat Local253 = MaterialStoreTexSample(Parameters, Local252, 11);
	MaterialFloat Local254 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local87), 11);
	MaterialFloat4 Local255 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local87)));
	MaterialFloat Local256 = MaterialStoreTexSample(Parameters, Local255, 11);
	MaterialFloat3 Local257 = lerp(Local252.rgb,Local255.rgb,Local52);
	MaterialFloat Local258 = dot(Local257,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local259 = lerp(Local257,((MaterialFloat3)Local258),Material.PreshaderBuffer[25].z);
	MaterialFloat3 Local260 = (Local259 * Material.PreshaderBuffer[27].xyz);
	MaterialFloat3 Local261 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[25].y),((MaterialFloat3)0.00000000),Local260);
	MaterialFloat3 Local262 = (Local261 + Local260);
	MaterialFloat3 Local263 = (((MaterialFloat3)Material.PreshaderBuffer[27].w) * Local262);
	MaterialFloat Local264 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local99), 13);
	MaterialFloat4 Local265 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local99)));
	MaterialFloat Local266 = MaterialStoreTexSample(Parameters, Local265, 13);
	MaterialFloat Local267 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local109), 13);
	MaterialFloat4 Local268 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local109)));
	MaterialFloat Local269 = MaterialStoreTexSample(Parameters, Local268, 13);
	MaterialFloat3 Local270 = lerp(Local265.rgb,Local268.rgb,Local52);
	MaterialFloat Local271 = dot(Local270,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local272 = lerp(Local270,((MaterialFloat3)Local271),Material.PreshaderBuffer[28].z);
	MaterialFloat3 Local273 = (Local272 * Material.PreshaderBuffer[30].xyz);
	MaterialFloat3 Local274 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[28].y),((MaterialFloat3)0.00000000),Local273);
	MaterialFloat3 Local275 = (Local274 + Local273);
	MaterialFloat3 Local276 = (((MaterialFloat3)Material.PreshaderBuffer[30].w) * Local275);
	MaterialFloat Local277 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local121), 15);
	MaterialFloat4 Local278 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local121)));
	MaterialFloat Local279 = MaterialStoreTexSample(Parameters, Local278, 15);
	MaterialFloat Local280 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local131), 15);
	MaterialFloat4 Local281 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local131)));
	MaterialFloat Local282 = MaterialStoreTexSample(Parameters, Local281, 15);
	MaterialFloat3 Local283 = lerp(Local278.rgb,Local281.rgb,Local52);
	MaterialFloat Local284 = dot(Local283,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local285 = lerp(Local283,((MaterialFloat3)Local284),Material.PreshaderBuffer[31].z);
	MaterialFloat3 Local286 = (Local285 * Material.PreshaderBuffer[33].xyz);
	MaterialFloat3 Local287 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[31].y),((MaterialFloat3)0.00000000),Local286);
	MaterialFloat3 Local288 = (Local287 + Local286);
	MaterialFloat3 Local289 = (((MaterialFloat3)Material.PreshaderBuffer[33].w) * Local288);
	MaterialFloat3 Local290 = CustomExpression1(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,Local237,Local250,Local263,Local276,Local289,Local289,Local157,Local164,Local171,Local178,Local185,Local192);
	MaterialFloat Local291 = dot(Local290,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local292 = lerp(Local290,((MaterialFloat3)Local291),Material.PreshaderBuffer[34].x);
	MaterialFloat3 Local293 = saturate(Local292);
	MaterialFloat3 Local294 = (Local293 * ((MaterialFloat3)Material.PreshaderBuffer[34].y));
	MaterialFloat3 Local295 = lerp(Local290,Local294,Local198);
	MaterialFloat3 Local296 = lerp(Local295,Material.PreshaderBuffer[37].yzw,Material.PreshaderBuffer[37].x);
	MaterialFloat3 Local297 = lerp(Local295,Local296,Material.PreshaderBuffer[13].x);
	MaterialFloat3 Local298 = lerp(Local297,Local295,Local211.r.r);
	MaterialFloat2 Local299 = (DERIV_BASE_VALUE(Local18) * ((MaterialFloat2)Material.PreshaderBuffer[38].x));
	MaterialFloat Local300 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local299), 2);
	MaterialFloat4 Local301 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local299)));
	MaterialFloat Local302 = MaterialStoreTexSample(Parameters, Local301, 2);
	MaterialFloat3 Local303 = (Local301.rgb + ((MaterialFloat3)Material.PreshaderBuffer[38].y));
	MaterialFloat2 Local304 = (DERIV_BASE_VALUE(Local18) * ((MaterialFloat2)Material.PreshaderBuffer[38].z));
	MaterialFloat Local305 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local304), 2);
	MaterialFloat4 Local306 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local304)));
	MaterialFloat Local307 = MaterialStoreTexSample(Parameters, Local306, 2);
	MaterialFloat3 Local308 = (Local306.rgb + ((MaterialFloat3)Material.PreshaderBuffer[38].w));
	MaterialFloat2 Local309 = (DERIV_BASE_VALUE(Local18) * ((MaterialFloat2)Material.PreshaderBuffer[39].x));
	MaterialFloat Local310 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local309), 2);
	MaterialFloat4 Local311 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local309)));
	MaterialFloat Local312 = MaterialStoreTexSample(Parameters, Local311, 2);
	MaterialFloat3 Local313 = (Local311.rgb + ((MaterialFloat3)Material.PreshaderBuffer[39].y));
	MaterialFloat3 Local314 = (Local308 * Local313);
	MaterialFloat3 Local315 = (Local303 * Local314);
	MaterialFloat3 Local316 = lerp(MaterialFloat3(0.50000000,0.50000000,0.50000000),((MaterialFloat3)1.00000000),Local315);
	MaterialFloat3 Local317 = (Local298 * Local316);
	MaterialFloat Local318 = dot(Local317,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local319 = lerp(Local317,((MaterialFloat3)Local318),Material.PreshaderBuffer[39].z);
	MaterialFloat3 Local320 = (Local319 * Material.PreshaderBuffer[41].xyz);
	FLWCScalar Local321 = LWCGetZ(DERIV_BASE_VALUE(Local39));
	FLWCScalar Local322 = LWCAdd(DERIV_BASE_VALUE(Local321), LWCPromote(Material.PreshaderBuffer[42].x));
	FLWCScalar Local323 = LWCMultiply(DERIV_BASE_VALUE(Local322), LWCPromote(-1.00000000));
	MaterialFloat Local324 = LWCSaturate(DERIV_BASE_VALUE(Local323));
	FLWCScalar Local325 = LWCSubtract(DERIV_BASE_VALUE(Local322), LWCPromote(0.00000000));
	FLWCScalar Local326 = LWCLength(DERIV_BASE_VALUE(Local325));
	FLWCScalar Local327 = LWCMultiply(DERIV_BASE_VALUE(Local326), LWCPromote(Material.PreshaderBuffer[42].z));
	MaterialFloat Local328 = LWCSaturate(DERIV_BASE_VALUE(Local327));
	MaterialFloat Local329 = (1.00000000 - DERIV_BASE_VALUE(Local328));
	MaterialFloat Local330 = max(DERIV_BASE_VALUE(Local324),DERIV_BASE_VALUE(Local329));
	MaterialFloat3 Local331 = lerp(Local317,Local320,DERIV_BASE_VALUE(Local330));
	MaterialFloat3 Local332 = CustomExpression2(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,0.00000000,0.00000000,0.00000000,0.00000000,0.00000000,Local192,Local157,Local164,Local171,Local178,Local185,Local192);
	MaterialFloat3 Local333 = CustomExpression3(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,Material.PreshaderBuffer[42].w,Material.PreshaderBuffer[43].x,Material.PreshaderBuffer[43].y,Material.PreshaderBuffer[43].z,Material.PreshaderBuffer[43].w,MaterialFloat4(0.00000000,0.00000000,0.00000000,0.00000000),Local157,Local164,Local171,Local178,Local185,Local192);
	MaterialFloat3 Local334 = lerp(Local333,((MaterialFloat3)Material.PreshaderBuffer[44].y),Material.PreshaderBuffer[13].x);
	MaterialFloat3 Local335 = lerp(Local334,Local333,Local211.r.r);
	MaterialFloat Local336 = lerp(Local226.a,Local229.a,Local52);
	MaterialFloat Local337 = lerp(Local239.a,Local242.a,Local52);
	MaterialFloat Local338 = lerp(Local252.a,Local255.a,Local52);
	MaterialFloat Local339 = lerp(Local265.a,Local268.a,Local52);
	MaterialFloat Local340 = lerp(Local278.a,Local281.a,Local52);
	MaterialFloat3 Local341 = CustomExpression4(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,Local336,Local337,Local338,Local339,Local340,MaterialFloat4(0.00000000,0.00000000,0.00000000,0.00000000),Local157,Local164,Local171,Local178,Local185,Local192);
	MaterialFloat3 Local342 = lerp(Local341,((MaterialFloat3)Material.PreshaderBuffer[44].z),Local198);
	MaterialFloat3 Local343 = lerp(Local342,((MaterialFloat3)Material.PreshaderBuffer[44].x),Material.PreshaderBuffer[13].x);
	MaterialFloat3 Local344 = lerp(Local343,Local342,Local211.r.r);
	MaterialFloat3 Local345 = (Local344 * ((MaterialFloat3)Material.PreshaderBuffer[44].w));
	FLWCScalar Local346 = LWCAdd(DERIV_BASE_VALUE(Local321), LWCPromote(0.50000000));
	MaterialFloat Local347 = LWCSaturate(DERIV_BASE_VALUE(Local346));
	MaterialFloat Local348 = (DERIV_BASE_VALUE(Local330) * DERIV_BASE_VALUE(Local347));
	MaterialFloat3 Local349 = lerp(Local344,Local345,DERIV_BASE_VALUE(Local348));
	MaterialFloat Local370 = lerp(Local21.b,Local31.b,Local52);
	MaterialFloat Local371 = lerp(Local57.b,Local67.b,Local52);
	MaterialFloat Local372 = lerp(Local79.b,Local89.b,Local52);
	MaterialFloat Local373 = lerp(Local101.b,Local111.b,Local52);
	MaterialFloat Local374 = lerp(Local123.b,Local133.b,Local52);
	MaterialFloat3 Local375 = CustomExpression5(Parameters,Local5.r,Local7.r,Local9.r,Local11.r,Local13.r,Local15.r,Local370,Local371,Local372,Local373,Local374,MaterialFloat4(0.00000000,0.00000000,0.00000000,0.00000000),Local157,Local164,Local171,Local178,Local185,Local192);

	PixelMaterialInputs.EmissiveColor = Local224;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local331;
	PixelMaterialInputs.Metallic = Local332;
	PixelMaterialInputs.Specular = Local335;
	PixelMaterialInputs.Roughness = Local349;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local223;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local375;
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