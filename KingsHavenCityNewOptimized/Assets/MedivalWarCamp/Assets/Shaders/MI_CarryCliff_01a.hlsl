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
	float4 PreshaderBuffer[33];
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
	Material.PreshaderBuffer[1] = float4(0.000000,0.000000,-0.000000,100000.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1014.098694,1014.098694,-1014.098694,-0.000986);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,490.615234,490.615234,-490.615234);//(Unknown)
	Material.PreshaderBuffer[4] = float4(-0.002038,1.000000,1793.305054,1793.305054);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-1793.305054,-0.000558,1.000000,540.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(540.000000,-540.000000,-0.001852,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,9.153681,4.576840,-2.570849);//(Unknown)
	Material.PreshaderBuffer[8] = float4(-7.147689,2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.229738,1.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.503808,0.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.833428,0.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.484375,0.484375,0.484375,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.484375,0.484375,0.484375,1.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,0.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.500000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,0.928000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.000000,0.496000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	FLWCVector3 Local0 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local1 = LWCMultiply(DERIV_BASE_VALUE(Local0), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[1].w)));
	FLWCVector2 Local2 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local1)), LWCGetZ(DERIV_BASE_VALUE(Local1)));
	MaterialFloat2 Local3 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local2), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local4 = MaterialStoreTexCoordScale(Parameters, Local3, 7);
	MaterialFloat4 Local5 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local3));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 7);
	FLWCVector2 Local7 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local1)), LWCGetZ(DERIV_BASE_VALUE(Local1)));
	MaterialFloat2 Local8 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local7), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local9 = MaterialStoreTexCoordScale(Parameters, Local8, 7);
	MaterialFloat4 Local10 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local11 = MaterialStoreTexSample(Parameters, Local10, 7);
	MaterialFloat Local12 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local13 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local12);
	MaterialFloat Local14 = saturate(Local13);
	MaterialFloat3 Local15 = lerp(Local5.rgb,Local10.rgb,Local14.r.r);
	FLWCVector2 Local16 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local1)), LWCGetY(DERIV_BASE_VALUE(Local1)));
	MaterialFloat2 Local17 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local16), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local18 = MaterialStoreTexCoordScale(Parameters, Local17, 7);
	MaterialFloat4 Local19 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local17));
	MaterialFloat Local20 = MaterialStoreTexSample(Parameters, Local19, 7);
	MaterialFloat Local21 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local22 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local21);
	MaterialFloat Local23 = saturate(Local22);
	MaterialFloat3 Local24 = lerp(Local15,Local19.rgb,Local23.r.r);
	MaterialFloat3 Local25 = (((MaterialFloat3)1.00000000) - Local24);
	FLWCVector3 Local26 = LWCMultiply(DERIV_BASE_VALUE(Local0), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[2].w)));
	FLWCVector2 Local27 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local26)), LWCGetZ(DERIV_BASE_VALUE(Local26)));
	MaterialFloat2 Local28 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local27), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local29 = MaterialStoreTexCoordScale(Parameters, Local28, 0);
	MaterialFloat4 Local30 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local28));
	MaterialFloat Local31 = MaterialStoreTexSample(Parameters, Local30, 0);
	FLWCVector2 Local32 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local26)), LWCGetZ(DERIV_BASE_VALUE(Local26)));
	MaterialFloat2 Local33 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local32), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local34 = MaterialStoreTexCoordScale(Parameters, Local33, 0);
	MaterialFloat4 Local35 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local33));
	MaterialFloat Local36 = MaterialStoreTexSample(Parameters, Local35, 0);
	MaterialFloat3 Local37 = lerp(Local30.rgb,Local35.rgb,Local14.r.r);
	FLWCVector2 Local38 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local26)), LWCGetY(DERIV_BASE_VALUE(Local26)));
	MaterialFloat2 Local39 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local38), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local40 = MaterialStoreTexCoordScale(Parameters, Local39, 0);
	MaterialFloat4 Local41 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local39));
	MaterialFloat Local42 = MaterialStoreTexSample(Parameters, Local41, 0);
	MaterialFloat3 Local43 = lerp(Local37,Local41.rgb,Local23.r.r);
	MaterialFloat2 Local44 = (Local43.rg * ((MaterialFloat2)Material.PreshaderBuffer[3].x));
	FLWCVector3 Local45 = LWCMultiply(DERIV_BASE_VALUE(Local0), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[4].x)));
	FLWCVector2 Local46 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local45)), LWCGetZ(DERIV_BASE_VALUE(Local45)));
	MaterialFloat2 Local47 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local46), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local48 = MaterialStoreTexCoordScale(Parameters, Local47, 0);
	MaterialFloat4 Local49 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local47));
	MaterialFloat Local50 = MaterialStoreTexSample(Parameters, Local49, 0);
	FLWCVector2 Local51 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local45)), LWCGetZ(DERIV_BASE_VALUE(Local45)));
	MaterialFloat2 Local52 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local51), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local53 = MaterialStoreTexCoordScale(Parameters, Local52, 0);
	MaterialFloat4 Local54 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local52));
	MaterialFloat Local55 = MaterialStoreTexSample(Parameters, Local54, 0);
	MaterialFloat3 Local56 = lerp(Local49.rgb,Local54.rgb,Local14.r.r);
	FLWCVector2 Local57 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local45)), LWCGetY(DERIV_BASE_VALUE(Local45)));
	MaterialFloat2 Local58 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local57), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local59 = MaterialStoreTexCoordScale(Parameters, Local58, 0);
	MaterialFloat4 Local60 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local58));
	MaterialFloat Local61 = MaterialStoreTexSample(Parameters, Local60, 0);
	MaterialFloat3 Local62 = lerp(Local56,Local60.rgb,Local23.r.r);
	MaterialFloat2 Local63 = (Local62.rg * ((MaterialFloat2)Material.PreshaderBuffer[4].y));
	MaterialFloat2 Local64 = Parameters.TexCoords[0].xy;
	MaterialFloat Local65 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local64), 1);
	MaterialFloat4 Local66 = Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local64));
	MaterialFloat Local67 = MaterialStoreTexSample(Parameters, Local66, 1);
	MaterialFloat3 Local68 = lerp(MaterialFloat3(Local44,Local43.b),MaterialFloat3(Local63,Local62.b),Local66.rgb.g);
	FLWCVector3 Local69 = LWCMultiply(DERIV_BASE_VALUE(Local0), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[5].y)));
	FLWCVector2 Local70 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local69)), LWCGetZ(DERIV_BASE_VALUE(Local69)));
	MaterialFloat2 Local71 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local70), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local72 = MaterialStoreTexCoordScale(Parameters, Local71, 0);
	MaterialFloat4 Local73 = UnpackNormalMap(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),Local71));
	MaterialFloat Local74 = MaterialStoreTexSample(Parameters, Local73, 0);
	FLWCVector2 Local75 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local69)), LWCGetZ(DERIV_BASE_VALUE(Local69)));
	MaterialFloat2 Local76 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local75), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local77 = MaterialStoreTexCoordScale(Parameters, Local76, 0);
	MaterialFloat4 Local78 = UnpackNormalMap(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),Local76));
	MaterialFloat Local79 = MaterialStoreTexSample(Parameters, Local78, 0);
	MaterialFloat3 Local80 = lerp(Local73.rgb,Local78.rgb,Local14.r.r);
	FLWCVector2 Local81 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local69)), LWCGetY(DERIV_BASE_VALUE(Local69)));
	MaterialFloat2 Local82 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local81), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local83 = MaterialStoreTexCoordScale(Parameters, Local82, 0);
	MaterialFloat4 Local84 = UnpackNormalMap(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),Local82));
	MaterialFloat Local85 = MaterialStoreTexSample(Parameters, Local84, 0);
	MaterialFloat3 Local86 = lerp(Local80,Local84.rgb,Local23.r.r);
	MaterialFloat2 Local87 = (Local86.rg * ((MaterialFloat2)Material.PreshaderBuffer[5].z));
	MaterialFloat3 Local88 = lerp(Local68,MaterialFloat3(Local87,Local86.b),Local66.rgb.r);
	FLWCVector3 Local89 = LWCMultiply(DERIV_BASE_VALUE(Local0), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[6].z)));
	FLWCVector2 Local90 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local89)), LWCGetZ(DERIV_BASE_VALUE(Local89)));
	MaterialFloat2 Local91 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local90), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local92 = MaterialStoreTexCoordScale(Parameters, Local91, 0);
	MaterialFloat4 Local93 = UnpackNormalMap(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local91));
	MaterialFloat Local94 = MaterialStoreTexSample(Parameters, Local93, 0);
	FLWCVector2 Local95 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local89)), LWCGetZ(DERIV_BASE_VALUE(Local89)));
	MaterialFloat2 Local96 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local95), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local97 = MaterialStoreTexCoordScale(Parameters, Local96, 0);
	MaterialFloat4 Local98 = UnpackNormalMap(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local96));
	MaterialFloat Local99 = MaterialStoreTexSample(Parameters, Local98, 0);
	MaterialFloat3 Local100 = lerp(Local93.rgb,Local98.rgb,Local14.r.r);
	FLWCVector2 Local101 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local89)), LWCGetY(DERIV_BASE_VALUE(Local89)));
	MaterialFloat2 Local102 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local101), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, Local102, 0);
	MaterialFloat4 Local104 = UnpackNormalMap(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local102));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 0);
	MaterialFloat3 Local106 = lerp(Local100,Local104.rgb,Local23.r.r);
	MaterialFloat2 Local107 = (Local106.rg * ((MaterialFloat2)Material.PreshaderBuffer[6].w));
	MaterialFloat2 Local108 = (DERIV_BASE_VALUE(Local64) * ((MaterialFloat2)Material.PreshaderBuffer[7].x));
	MaterialFloat Local109 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local108), 0);
	MaterialFloat4 Local110 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local108),View.MaterialTextureMipBias));
	MaterialFloat Local111 = MaterialStoreTexSample(Parameters, Local110, 0);
	MaterialFloat3 Local112 = mul(Local110.rgb, Parameters.TangentToWorld);
	MaterialFloat3 Local113 = normalize(Local112);
	MaterialFloat Local114 = dot(Local113,normalize(MaterialFloat3(0.00000000,0.00000000,1.00000000)));
	MaterialFloat Local115 = (Local114 * 0.50000000);
	MaterialFloat Local116 = (Local115 + 0.50000000);
	MaterialFloat Local117 = (Local116 * Material.PreshaderBuffer[7].y);
	MaterialFloat Local118 = (Local117 + Material.PreshaderBuffer[8].x);
	MaterialFloat Local119 = saturate(Local118);
	MaterialFloat3 Local120 = lerp(Local88,MaterialFloat3(Local107,Local106.b),Local119.r);
	MaterialFloat3 Local121 = (Local120.rgb * MaterialFloat3(1.00000000,1.00000000,0.50000000));
	MaterialFloat2 Local122 = (Local110.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[8].y));
	MaterialFloat3 Local123 = (Local121 + MaterialFloat3(Local122,Local110.rgb.b));
	MaterialFloat3 Local124 = (Local123 * MaterialFloat3(1.00000000,1.00000000,0.67500001));
	MaterialFloat3 Local125 = (((MaterialFloat3)1.00000000) - Local124.rgb);
	MaterialFloat3 Local126 = (Local25 * Local125);
	MaterialFloat3 Local127 = (((MaterialFloat3)1.00000000) - Local126);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local127;


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
	MaterialFloat3 Local128 = lerp(0.00000000.rrr.rgb,Material.PreshaderBuffer[9].xyz,Material.PreshaderBuffer[8].z);
	MaterialFloat Local129 = MaterialStoreTexCoordScale(Parameters, Local28, 2);
	MaterialFloat4 Local130 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local28));
	MaterialFloat Local131 = MaterialStoreTexSample(Parameters, Local130, 2);
	MaterialFloat Local132 = MaterialStoreTexCoordScale(Parameters, Local33, 2);
	MaterialFloat4 Local133 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local33));
	MaterialFloat Local134 = MaterialStoreTexSample(Parameters, Local133, 2);
	MaterialFloat3 Local135 = lerp(Local130.rgb,Local133.rgb,Local14.r.r);
	MaterialFloat Local136 = MaterialStoreTexCoordScale(Parameters, Local39, 2);
	MaterialFloat4 Local137 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local39));
	MaterialFloat Local138 = MaterialStoreTexSample(Parameters, Local137, 2);
	MaterialFloat3 Local139 = lerp(Local135,Local137.rgb,Local23.r.r);
	MaterialFloat3 Local140 = (Local139 * Material.PreshaderBuffer[12].xyz);
	MaterialFloat3 Local141 = lerp(Local139,Local140,Material.PreshaderBuffer[12].w);
	MaterialFloat3 Local142 = (Local141 * ((MaterialFloat3)Material.PreshaderBuffer[13].x));
	MaterialFloat3 Local143 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[10].x),((MaterialFloat3)0.00000000),Local142);
	MaterialFloat3 Local144 = (Local143 + Local142);
	MaterialFloat Local145 = dot(Local144,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local146 = lerp(Local144,((MaterialFloat3)Local145),Material.PreshaderBuffer[13].y);
	MaterialFloat Local147 = MaterialStoreTexCoordScale(Parameters, Local28, 4);
	MaterialFloat4 Local148 = Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local28);
	MaterialFloat Local149 = MaterialStoreTexSample(Parameters, Local148, 4);
	MaterialFloat Local150 = MaterialStoreTexCoordScale(Parameters, Local33, 4);
	MaterialFloat4 Local151 = Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local33);
	MaterialFloat Local152 = MaterialStoreTexSample(Parameters, Local151, 4);
	MaterialFloat3 Local153 = lerp(Local148.rgb,Local151.rgb,Local14.r.r);
	MaterialFloat Local154 = MaterialStoreTexCoordScale(Parameters, Local39, 4);
	MaterialFloat4 Local155 = Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local39);
	MaterialFloat Local156 = MaterialStoreTexSample(Parameters, Local155, 4);
	MaterialFloat3 Local157 = lerp(Local153,Local155.rgb,Local23.r.r);
	MaterialFloat Local158 = (Local157.r * Material.PreshaderBuffer[13].z);
	MaterialFloat Local159 = PositiveClampedPow(Local158,Material.PreshaderBuffer[13].w);
	MaterialFloat Local160 = (Local159 * Material.PreshaderBuffer[14].x);
	MaterialFloat3 Local161 = (Local146 * ((MaterialFloat3)Local160));
	MaterialFloat Local162 = MaterialStoreTexCoordScale(Parameters, Local47, 2);
	MaterialFloat4 Local163 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local47));
	MaterialFloat Local164 = MaterialStoreTexSample(Parameters, Local163, 2);
	MaterialFloat Local165 = MaterialStoreTexCoordScale(Parameters, Local52, 2);
	MaterialFloat4 Local166 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local52));
	MaterialFloat Local167 = MaterialStoreTexSample(Parameters, Local166, 2);
	MaterialFloat3 Local168 = lerp(Local163.rgb,Local166.rgb,Local14.r.r);
	MaterialFloat Local169 = MaterialStoreTexCoordScale(Parameters, Local58, 2);
	MaterialFloat4 Local170 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local58));
	MaterialFloat Local171 = MaterialStoreTexSample(Parameters, Local170, 2);
	MaterialFloat3 Local172 = lerp(Local168,Local170.rgb,Local23.r.r);
	MaterialFloat3 Local173 = (Local172 * Material.PreshaderBuffer[16].xyz);
	MaterialFloat3 Local174 = lerp(Local172,Local173,Material.PreshaderBuffer[16].w);
	MaterialFloat3 Local175 = (Local174 * ((MaterialFloat3)Material.PreshaderBuffer[17].x));
	MaterialFloat3 Local176 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[14].z),((MaterialFloat3)0.00000000),Local175);
	MaterialFloat3 Local177 = (Local176 + Local175);
	MaterialFloat Local178 = dot(Local177,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local179 = lerp(Local177,((MaterialFloat3)Local178),Material.PreshaderBuffer[17].y);
	MaterialFloat Local180 = MaterialStoreTexCoordScale(Parameters, Local47, 4);
	MaterialFloat4 Local181 = Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local47);
	MaterialFloat Local182 = MaterialStoreTexSample(Parameters, Local181, 4);
	MaterialFloat Local183 = MaterialStoreTexCoordScale(Parameters, Local52, 4);
	MaterialFloat4 Local184 = Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local52);
	MaterialFloat Local185 = MaterialStoreTexSample(Parameters, Local184, 4);
	MaterialFloat3 Local186 = lerp(Local181.rgb,Local184.rgb,Local14.r.r);
	MaterialFloat Local187 = MaterialStoreTexCoordScale(Parameters, Local58, 4);
	MaterialFloat4 Local188 = Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local58);
	MaterialFloat Local189 = MaterialStoreTexSample(Parameters, Local188, 4);
	MaterialFloat3 Local190 = lerp(Local186,Local188.rgb,Local23.r.r);
	MaterialFloat Local191 = (Local190.r * Material.PreshaderBuffer[17].z);
	MaterialFloat Local192 = PositiveClampedPow(Local191,Material.PreshaderBuffer[17].w);
	MaterialFloat Local193 = (Local192 * Material.PreshaderBuffer[18].x);
	MaterialFloat3 Local194 = (Local179 * ((MaterialFloat3)Local193));
	MaterialFloat3 Local195 = saturate(Local194);
	MaterialFloat3 Local196 = lerp(Local161,Local195,Local66.rgb.g);
	MaterialFloat Local197 = MaterialStoreTexCoordScale(Parameters, Local71, 2);
	MaterialFloat4 Local198 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local71));
	MaterialFloat Local199 = MaterialStoreTexSample(Parameters, Local198, 2);
	MaterialFloat Local200 = MaterialStoreTexCoordScale(Parameters, Local76, 2);
	MaterialFloat4 Local201 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local76));
	MaterialFloat Local202 = MaterialStoreTexSample(Parameters, Local201, 2);
	MaterialFloat3 Local203 = lerp(Local198.rgb,Local201.rgb,Local14.r.r);
	MaterialFloat Local204 = MaterialStoreTexCoordScale(Parameters, Local82, 2);
	MaterialFloat4 Local205 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local82));
	MaterialFloat Local206 = MaterialStoreTexSample(Parameters, Local205, 2);
	MaterialFloat3 Local207 = lerp(Local203,Local205.rgb,Local23.r.r);
	MaterialFloat3 Local208 = (Local207 * Material.PreshaderBuffer[20].xyz);
	MaterialFloat3 Local209 = lerp(Local207,Local208,Material.PreshaderBuffer[20].w);
	MaterialFloat3 Local210 = (Local209 * ((MaterialFloat3)Material.PreshaderBuffer[21].x));
	MaterialFloat3 Local211 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[18].z),((MaterialFloat3)0.00000000),Local210);
	MaterialFloat3 Local212 = (Local211 + Local210);
	MaterialFloat Local213 = dot(Local212,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local214 = lerp(Local212,((MaterialFloat3)Local213),Material.PreshaderBuffer[21].y);
	MaterialFloat Local215 = MaterialStoreTexCoordScale(Parameters, Local71, 4);
	MaterialFloat4 Local216 = Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),Local71);
	MaterialFloat Local217 = MaterialStoreTexSample(Parameters, Local216, 4);
	MaterialFloat Local218 = MaterialStoreTexCoordScale(Parameters, Local76, 4);
	MaterialFloat4 Local219 = Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),Local76);
	MaterialFloat Local220 = MaterialStoreTexSample(Parameters, Local219, 4);
	MaterialFloat3 Local221 = lerp(Local216.rgb,Local219.rgb,Local14.r.r);
	MaterialFloat Local222 = MaterialStoreTexCoordScale(Parameters, Local82, 4);
	MaterialFloat4 Local223 = Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),Local82);
	MaterialFloat Local224 = MaterialStoreTexSample(Parameters, Local223, 4);
	MaterialFloat3 Local225 = lerp(Local221,Local223.rgb,Local23.r.r);
	MaterialFloat Local226 = (Local225.r * Material.PreshaderBuffer[21].z);
	MaterialFloat Local227 = PositiveClampedPow(Local226,Material.PreshaderBuffer[21].w);
	MaterialFloat Local228 = (Local227 * Material.PreshaderBuffer[22].x);
	MaterialFloat3 Local229 = (Local214 * ((MaterialFloat3)Local228));
	MaterialFloat3 Local230 = saturate(Local229);
	MaterialFloat3 Local231 = lerp(Local196,Local230,Local66.rgb.r);
	MaterialFloat Local232 = MaterialStoreTexCoordScale(Parameters, Local91, 2);
	MaterialFloat4 Local233 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),Local91));
	MaterialFloat Local234 = MaterialStoreTexSample(Parameters, Local233, 2);
	MaterialFloat Local235 = MaterialStoreTexCoordScale(Parameters, Local96, 2);
	MaterialFloat4 Local236 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),Local96));
	MaterialFloat Local237 = MaterialStoreTexSample(Parameters, Local236, 2);
	MaterialFloat3 Local238 = lerp(Local233.rgb,Local236.rgb,Local14.r.r);
	MaterialFloat Local239 = MaterialStoreTexCoordScale(Parameters, Local102, 2);
	MaterialFloat4 Local240 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),Local102));
	MaterialFloat Local241 = MaterialStoreTexSample(Parameters, Local240, 2);
	MaterialFloat3 Local242 = lerp(Local238,Local240.rgb,Local23.r.r);
	MaterialFloat3 Local243 = (Local242 * Material.PreshaderBuffer[24].xyz);
	MaterialFloat3 Local244 = lerp(Local242,Local243,Material.PreshaderBuffer[24].w);
	MaterialFloat3 Local245 = (Local244 * ((MaterialFloat3)Material.PreshaderBuffer[25].x));
	MaterialFloat3 Local246 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[22].z),((MaterialFloat3)0.00000000),Local245);
	MaterialFloat3 Local247 = (Local246 + Local245);
	MaterialFloat Local248 = dot(Local247,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local249 = lerp(Local247,((MaterialFloat3)Local248),Material.PreshaderBuffer[25].y);
	MaterialFloat Local250 = MaterialStoreTexCoordScale(Parameters, Local91, 4);
	MaterialFloat4 Local251 = Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),Local91);
	MaterialFloat Local252 = MaterialStoreTexSample(Parameters, Local251, 4);
	MaterialFloat Local253 = MaterialStoreTexCoordScale(Parameters, Local96, 4);
	MaterialFloat4 Local254 = Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),Local96);
	MaterialFloat Local255 = MaterialStoreTexSample(Parameters, Local254, 4);
	MaterialFloat3 Local256 = lerp(Local251.rgb,Local254.rgb,Local14.r.r);
	MaterialFloat Local257 = MaterialStoreTexCoordScale(Parameters, Local102, 4);
	MaterialFloat4 Local258 = Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),Local102);
	MaterialFloat Local259 = MaterialStoreTexSample(Parameters, Local258, 4);
	MaterialFloat3 Local260 = lerp(Local256,Local258.rgb,Local23.r.r);
	MaterialFloat Local261 = (Local260.r * Material.PreshaderBuffer[25].z);
	MaterialFloat Local262 = PositiveClampedPow(Local261,Material.PreshaderBuffer[25].w);
	MaterialFloat Local263 = (Local262 * Material.PreshaderBuffer[26].x);
	MaterialFloat3 Local264 = (Local249 * ((MaterialFloat3)Local263));
	MaterialFloat3 Local265 = saturate(Local264);
	MaterialFloat3 Local266 = lerp(Local231,Local265,Local119.r);
	MaterialFloat Local267 = (Local139.r * Material.PreshaderBuffer[26].y);
	MaterialFloat Local268 = (Local172.r * Material.PreshaderBuffer[26].z);
	MaterialFloat Local269 = lerp(Local267,Local268,Local66.rgb.g);
	MaterialFloat Local270 = (Local207.r * Material.PreshaderBuffer[26].w);
	MaterialFloat Local271 = lerp(Local269,Local270,Local66.rgb.r);
	MaterialFloat Local272 = lerp(Local271,Material.PreshaderBuffer[27].z,Local119.r);
	MaterialFloat Local273 = lerp(Material.PreshaderBuffer[28].y,Material.PreshaderBuffer[28].x,Local157.g);
	MaterialFloat Local274 = lerp(Material.PreshaderBuffer[28].w,Material.PreshaderBuffer[28].z,Local273);
	MaterialFloat Local275 = saturate(Local274);
	MaterialFloat Local276 = lerp(Material.PreshaderBuffer[29].z,Material.PreshaderBuffer[29].y,Local190.g);
	MaterialFloat Local277 = lerp(Material.PreshaderBuffer[30].x,Material.PreshaderBuffer[29].w,Local276);
	MaterialFloat Local278 = saturate(Local277);
	MaterialFloat Local279 = lerp(Local275.r,Local278.r,Local66.rgb.g);
	MaterialFloat Local280 = lerp(Material.PreshaderBuffer[30].w,Material.PreshaderBuffer[30].z,Local225.g);
	MaterialFloat Local281 = lerp(Material.PreshaderBuffer[31].y,Material.PreshaderBuffer[31].x,Local280);
	MaterialFloat Local282 = saturate(Local281);
	MaterialFloat Local283 = lerp(Local279,Local282.r,Local66.rgb.r);
	MaterialFloat Local284 = lerp(Material.PreshaderBuffer[32].x,Material.PreshaderBuffer[31].w,Local260.g);
	MaterialFloat Local285 = lerp(Material.PreshaderBuffer[32].z,Material.PreshaderBuffer[32].y,Local284);
	MaterialFloat Local286 = saturate(Local285);
	MaterialFloat Local287 = lerp(Local283,Local286.r,Local119.r);
	MaterialFloat Local288 = lerp(Local159,Local192,Local66.rgb.g);
	MaterialFloat Local289 = lerp(Local288,Local227,Local66.rgb.r);
	MaterialFloat Local290 = lerp(Local289,Local262,Local119.r);

	PixelMaterialInputs.EmissiveColor = Local128;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local266.rgb.rgb;
	PixelMaterialInputs.Metallic = 0.00000000.r.r;
	PixelMaterialInputs.Specular = Local272.r.r;
	PixelMaterialInputs.Roughness = Local287.r.r;
	PixelMaterialInputs.Anisotropy = 0.00000000.r;
	PixelMaterialInputs.Normal = Local127;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000).rgb;
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local290.r.r;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000.r.r;
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