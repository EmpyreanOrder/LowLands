#define NUM_TEX_COORD_INTERPOLATORS 2
#define NUM_MATERIAL_TEXCOORDS_VERTEX 2
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
	float4 PreshaderBuffer[51];
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
	Material.PreshaderBuffer[1] = float4(0.000000,0.000000,0.000000,-0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,-0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(2.000000,2.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,-0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,1.000000,4.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,2.000000,-1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,2.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(2.000000,-1.000000,1.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(-0.000000,1.000000,1.000000,-0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,1.000000,1.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(-1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.096000,0.603186,0.274666,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.026667,0.167554,0.208933,0.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(0.000000,0.000000,0.136537,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.980938,6.163415,0.150000,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.150000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(1.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local1 = ((MaterialFloat2(0.50000000,0.50000000) * -1.00000000) + DERIV_BASE_VALUE(Local0));
	MaterialFloat Local2 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[2].yz);
	MaterialFloat Local3 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[3].xy);
	MaterialFloat2 Local4 = MaterialFloat2(DERIV_BASE_VALUE(Local2),DERIV_BASE_VALUE(Local3));
	MaterialFloat2 Local5 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local4));
	MaterialFloat2 Local6 = (DERIV_BASE_VALUE(Local5) + Material.PreshaderBuffer[4].xy);
	MaterialFloat2 Local7 = (DERIV_BASE_VALUE(Local6) * Material.PreshaderBuffer[6].xy);
	MaterialFloat2 Local8 = ddy((float2)DERIV_BASE_VALUE(Local7));
	MaterialFloat2 Local9 = ddx((float2)DERIV_BASE_VALUE(Local7));
	MaterialFloat2 Local10 = (DERIV_BASE_VALUE(Local9) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat2 Local11 = (DERIV_BASE_VALUE(Local8) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat Local12 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 2);
	MaterialFloat4 Local13 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local7),DERIV_BASE_VALUE(Local10),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 2);
	MaterialFloat Local15 = (Local13.r * Material.PreshaderBuffer[6].z);
	MaterialFloat Local16 = (Local13.g * Material.PreshaderBuffer[6].z);
	MaterialFloat Local17 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[8].xy);
	MaterialFloat Local18 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[8].zw);
	MaterialFloat2 Local19 = MaterialFloat2(DERIV_BASE_VALUE(Local17),DERIV_BASE_VALUE(Local18));
	MaterialFloat2 Local20 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local19));
	MaterialFloat2 Local21 = (DERIV_BASE_VALUE(Local20) + Material.PreshaderBuffer[9].zw);
	MaterialFloat2 Local22 = (DERIV_BASE_VALUE(Local21) * Material.PreshaderBuffer[11].yz);
	MaterialFloat2 Local23 = ddy((float2)DERIV_BASE_VALUE(Local22));
	MaterialFloat2 Local24 = ddx((float2)DERIV_BASE_VALUE(Local22));
	MaterialFloat2 Local25 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[11].w));
	MaterialFloat2 Local26 = (DERIV_BASE_VALUE(Local24) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat2 Local27 = (DERIV_BASE_VALUE(Local23) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat Local28 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local25), 2);
	MaterialFloat4 Local29 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local25),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local30 = MaterialStoreTexSample(Parameters, Local29, 2);
	MaterialFloat Local31 = (Local29.r * Material.PreshaderBuffer[12].x);
	MaterialFloat Local32 = (Local29.g * Material.PreshaderBuffer[12].x);
	MaterialFloat2 Local33 = Parameters.TexCoords[1].xy;
	MaterialFloat2 Local34 = (DERIV_BASE_VALUE(Local33) * ((MaterialFloat2)1.00000000));
	MaterialFloat Local35 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local34), 1);
	MaterialFloat4 Local36 = Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local34),View.MaterialTextureMipBias);
	MaterialFloat Local37 = MaterialStoreTexSample(Parameters, Local36, 1);
	MaterialFloat Local38 = (Local36.r * Material.PreshaderBuffer[12].z);
	MaterialFloat2 Local39 = (((MaterialFloat2)Material.PreshaderBuffer[12].w) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local40 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local39), 4);
	MaterialFloat4 Local41 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local39),View.MaterialTextureMipBias));
	MaterialFloat Local42 = MaterialStoreTexSample(Parameters, Local41, 4);
	MaterialFloat3 Local43 = (Local41.rgb * ((MaterialFloat3)Material.PreshaderBuffer[13].x));
	MaterialFloat3 Local44 = (((MaterialFloat3)Local36.r) + Local43);
	MaterialFloat3 Local45 = (((MaterialFloat3)Local38) * Local44);
	MaterialFloat Local46 = lerp(Material.PreshaderBuffer[13].z,Material.PreshaderBuffer[13].y,Local45.x);
	MaterialFloat Local47 = saturate(Local46);
	MaterialFloat Local48 = saturate(Local47.r);
	MaterialFloat3 Local49 = lerp(MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b),MaterialFloat3(MaterialFloat2(Local31,Local32),Local29.b),Local48);
	MaterialFloat2 Local50 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[13].w));
	MaterialFloat Local51 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 2);
	MaterialFloat4 Local52 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local50),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local53 = MaterialStoreTexSample(Parameters, Local52, 2);
	MaterialFloat Local54 = (Local52.r * Material.PreshaderBuffer[14].x);
	MaterialFloat Local55 = (Local52.g * Material.PreshaderBuffer[14].x);
	MaterialFloat Local56 = lerp(Material.PreshaderBuffer[14].w,Material.PreshaderBuffer[14].z,Local36.g);
	MaterialFloat Local57 = saturate(Local56);
	MaterialFloat Local58 = (Local57.r * Material.PreshaderBuffer[15].x);
	MaterialFloat Local59 = saturate(Local58);
	MaterialFloat3 Local60 = lerp(Local49,MaterialFloat3(MaterialFloat2(Local54,Local55),Local52.b),Local59);
	MaterialFloat2 Local61 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[15].y));
	MaterialFloat Local62 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local61), 2);
	MaterialFloat4 Local63 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local61),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local64 = MaterialStoreTexSample(Parameters, Local63, 2);
	MaterialFloat Local65 = (Local63.r * Material.PreshaderBuffer[15].z);
	MaterialFloat Local66 = (Local63.g * Material.PreshaderBuffer[15].z);
	MaterialFloat Local67 = lerp(Material.PreshaderBuffer[16].y,Material.PreshaderBuffer[16].x,Local36.b);
	MaterialFloat Local68 = saturate(Local67);
	MaterialFloat Local69 = (Local68.r * Material.PreshaderBuffer[16].z);
	MaterialFloat Local70 = saturate(Local69);
	MaterialFloat3 Local71 = lerp(Local60,MaterialFloat3(MaterialFloat2(Local65,Local66),Local63.b),Local70);
	MaterialFloat2 Local72 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[16].w));
	MaterialFloat Local73 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local72), 2);
	MaterialFloat4 Local74 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local72),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local75 = MaterialStoreTexSample(Parameters, Local74, 2);
	MaterialFloat Local76 = (Local74.r * Material.PreshaderBuffer[17].x);
	MaterialFloat Local77 = (Local74.g * Material.PreshaderBuffer[17].x);
	MaterialFloat Local78 = lerp(Material.PreshaderBuffer[17].w,Material.PreshaderBuffer[17].z,Local36.a);
	MaterialFloat Local79 = saturate(Local78);
	MaterialFloat Local80 = (Local79.r * Material.PreshaderBuffer[18].x);
	MaterialFloat Local81 = saturate(Local80);
	MaterialFloat3 Local82 = lerp(Local71,MaterialFloat3(MaterialFloat2(Local76,Local77),Local74.b),Local81);
	MaterialFloat Local83 = (Local82.b + 1.00000000);
	MaterialFloat2 Local84 = ((MaterialFloat2(0.50000000,0.50000000) * -1.00000000) + DERIV_BASE_VALUE(Local33));
	MaterialFloat Local85 = dot(DERIV_BASE_VALUE(Local84),Material.PreshaderBuffer[19].zw);
	MaterialFloat Local86 = dot(DERIV_BASE_VALUE(Local84),Material.PreshaderBuffer[20].xy);
	MaterialFloat2 Local87 = MaterialFloat2(DERIV_BASE_VALUE(Local85),DERIV_BASE_VALUE(Local86));
	MaterialFloat2 Local88 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local87));
	MaterialFloat2 Local89 = (DERIV_BASE_VALUE(Local88) + Material.PreshaderBuffer[21].xy);
	MaterialFloat2 Local90 = (DERIV_BASE_VALUE(Local89) * Material.PreshaderBuffer[23].xy);
	MaterialFloat2 Local91 = ddy((float2)DERIV_BASE_VALUE(Local90));
	MaterialFloat2 Local92 = ddx((float2)DERIV_BASE_VALUE(Local90));
	MaterialFloat2 Local93 = (DERIV_BASE_VALUE(Local92) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat2 Local94 = (DERIV_BASE_VALUE(Local91) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat Local95 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local90), 2);
	MaterialFloat4 Local96 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local90),DERIV_BASE_VALUE(Local93),DERIV_BASE_VALUE(Local94)));
	MaterialFloat Local97 = MaterialStoreTexSample(Parameters, Local96, 2);
	MaterialFloat Local98 = (Local96.r * Material.PreshaderBuffer[23].z);
	MaterialFloat Local99 = (Local96.g * Material.PreshaderBuffer[23].z);
	MaterialFloat2 Local100 = (MaterialFloat3(MaterialFloat2(Local98,Local99),Local96.b).rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local101 = dot(MaterialFloat3(Local82.rg,Local83),MaterialFloat3(Local100,MaterialFloat3(MaterialFloat2(Local98,Local99),Local96.b).b));
	MaterialFloat3 Local102 = (MaterialFloat3(Local82.rg,Local83) * ((MaterialFloat3)Local101));
	MaterialFloat3 Local103 = (((MaterialFloat3)Local83) * MaterialFloat3(Local100,MaterialFloat3(MaterialFloat2(Local98,Local99),Local96.b).b));
	MaterialFloat3 Local104 = (Local102 - Local103);
	MaterialFloat4 Local105 = Parameters.VertexColor;
	MaterialFloat Local106 = DERIV_BASE_VALUE(Local105).g;
	MaterialFloat Local107 = (DERIV_BASE_VALUE(Local106) * Material.PreshaderBuffer[24].x);
	MaterialFloat2 Local108 = (((MaterialFloat2)Material.PreshaderBuffer[24].y) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local109 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local108), 4);
	MaterialFloat4 Local110 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_8,samplerMaterial_Texture2D_8,DERIV_BASE_VALUE(Local108),View.MaterialTextureMipBias));
	MaterialFloat Local111 = MaterialStoreTexSample(Parameters, Local110, 4);
	MaterialFloat3 Local112 = (Local110.rgb * ((MaterialFloat3)Material.PreshaderBuffer[24].z));
	MaterialFloat3 Local113 = (((MaterialFloat3)DERIV_BASE_VALUE(Local106)) + Local112);
	MaterialFloat3 Local114 = (((MaterialFloat3)DERIV_BASE_VALUE(Local107)) * Local113);
	MaterialFloat Local115 = lerp(Material.PreshaderBuffer[25].x,Material.PreshaderBuffer[24].w,Local114.x);
	MaterialFloat Local116 = saturate(Local115);
	MaterialFloat Local117 = saturate(Local116.r);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local104;


#if TEMPLATE_USES_STRATA
	Parameters.StrataPixelFootprint = StrataGetPixelFootprint(Parameters.WorldPosition_CamRelative, GetRoughnessFromNormalCurvature(Parameters));
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
	Parameters.StrataTree = GetInitialisedStrataTree();
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
	MaterialFloat Local118 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 0);
	MaterialFloat4 Local119 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local120 = MaterialStoreTexSample(Parameters, Local119, 0);
	MaterialFloat3 Local121 = (Local119.rgb * ((MaterialFloat3)Material.PreshaderBuffer[27].z));
	MaterialFloat Local122 = dot(Local121,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local123 = lerp(Local121,((MaterialFloat3)Local122),Material.PreshaderBuffer[27].w);
	MaterialFloat3 Local124 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[27].y),((MaterialFloat3)0.00000000),Local123);
	MaterialFloat3 Local125 = (Local124 + Local123);
	MaterialFloat3 Local126 = (Material.PreshaderBuffer[28].xyz * Local125);
	MaterialFloat Local127 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local25), 0);
	MaterialFloat4 Local128 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local25)));
	MaterialFloat Local129 = MaterialStoreTexSample(Parameters, Local128, 0);
	MaterialFloat3 Local130 = (Local128.rgb * ((MaterialFloat3)Material.PreshaderBuffer[30].z));
	MaterialFloat Local131 = dot(Local130,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local132 = lerp(Local130,((MaterialFloat3)Local131),Material.PreshaderBuffer[30].w);
	MaterialFloat3 Local133 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[30].y),((MaterialFloat3)0.00000000),Local132);
	MaterialFloat3 Local134 = (Local133 + Local132);
	MaterialFloat3 Local135 = (Material.PreshaderBuffer[31].xyz * Local134);
	MaterialFloat3 Local136 = lerp(Local126,Local135,Local48);
	MaterialFloat Local137 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 0);
	MaterialFloat4 Local138 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local50)));
	MaterialFloat Local139 = MaterialStoreTexSample(Parameters, Local138, 0);
	MaterialFloat3 Local140 = (Local138.rgb * ((MaterialFloat3)Material.PreshaderBuffer[33].z));
	MaterialFloat Local141 = dot(Local140,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local142 = lerp(Local140,((MaterialFloat3)Local141),Material.PreshaderBuffer[33].w);
	MaterialFloat3 Local143 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[33].y),((MaterialFloat3)0.00000000),Local142);
	MaterialFloat3 Local144 = (Local143 + Local142);
	MaterialFloat3 Local145 = (Material.PreshaderBuffer[34].xyz * Local144);
	MaterialFloat3 Local146 = lerp(Local136,Local145,Local59);
	MaterialFloat Local147 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local61), 0);
	MaterialFloat4 Local148 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local61)));
	MaterialFloat Local149 = MaterialStoreTexSample(Parameters, Local148, 0);
	MaterialFloat3 Local150 = (Local148.rgb * ((MaterialFloat3)Material.PreshaderBuffer[36].z));
	MaterialFloat Local151 = dot(Local150,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local152 = lerp(Local150,((MaterialFloat3)Local151),Material.PreshaderBuffer[36].w);
	MaterialFloat3 Local153 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[36].y),((MaterialFloat3)0.00000000),Local152);
	MaterialFloat3 Local154 = (Local153 + Local152);
	MaterialFloat3 Local155 = (Material.PreshaderBuffer[37].xyz * Local154);
	MaterialFloat3 Local156 = lerp(Local146,Local155,Local70);
	MaterialFloat Local157 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local72), 0);
	MaterialFloat4 Local158 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local72)));
	MaterialFloat Local159 = MaterialStoreTexSample(Parameters, Local158, 0);
	MaterialFloat3 Local160 = (Local158.rgb * ((MaterialFloat3)Material.PreshaderBuffer[39].z));
	MaterialFloat Local161 = dot(Local160,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local162 = lerp(Local160,((MaterialFloat3)Local161),Material.PreshaderBuffer[39].w);
	MaterialFloat3 Local163 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[39].y),((MaterialFloat3)0.00000000),Local162);
	MaterialFloat3 Local164 = (Local163 + Local162);
	MaterialFloat3 Local165 = (Material.PreshaderBuffer[40].xyz * Local164);
	MaterialFloat3 Local166 = lerp(Local156,Local165,Local81);
	MaterialFloat3 Local167 = (Local166 * Material.PreshaderBuffer[43].xyz);
	MaterialFloat3 Local168 = lerp(Local167,Material.PreshaderBuffer[44].xyz,Material.PreshaderBuffer[43].w);
	MaterialFloat Local169 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 1);
	MaterialFloat4 Local170 = Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7));
	MaterialFloat Local171 = MaterialStoreTexSample(Parameters, Local170, 1);
	MaterialFloat Local172 = (Local170.b * Material.PreshaderBuffer[44].w);
	MaterialFloat Local173 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local25), 1);
	MaterialFloat4 Local174 = Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local25));
	MaterialFloat Local175 = MaterialStoreTexSample(Parameters, Local174, 1);
	MaterialFloat Local176 = (Local174.b * Material.PreshaderBuffer[45].x);
	MaterialFloat Local177 = lerp(Local172,Local176,Local48);
	MaterialFloat Local178 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 1);
	MaterialFloat4 Local179 = Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local50));
	MaterialFloat Local180 = MaterialStoreTexSample(Parameters, Local179, 1);
	MaterialFloat Local181 = PositiveClampedPow(Local179.b,Material.PreshaderBuffer[45].y);
	MaterialFloat Local182 = lerp(Local177,Local181,Local59);
	MaterialFloat Local183 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local61), 1);
	MaterialFloat4 Local184 = Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local61));
	MaterialFloat Local185 = MaterialStoreTexSample(Parameters, Local184, 1);
	MaterialFloat Local186 = PositiveClampedPow(Local184.b,Material.PreshaderBuffer[45].z);
	MaterialFloat Local187 = lerp(Local182,Local186,Local70);
	MaterialFloat Local188 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local72), 1);
	MaterialFloat4 Local189 = Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local72));
	MaterialFloat Local190 = MaterialStoreTexSample(Parameters, Local189, 1);
	MaterialFloat Local191 = PositiveClampedPow(Local189.b,Material.PreshaderBuffer[45].w);
	MaterialFloat Local192 = lerp(Local187,Local191,Local81);
	MaterialFloat Local193 = lerp(Material.PreshaderBuffer[46].z,Material.PreshaderBuffer[46].y,Local170.g);
	MaterialFloat Local194 = lerp(Material.PreshaderBuffer[47].x,Material.PreshaderBuffer[46].w,Local174.g);
	MaterialFloat Local195 = lerp(Local193,Local194,Local48);
	MaterialFloat Local196 = lerp(Material.PreshaderBuffer[47].z,Material.PreshaderBuffer[47].y,Local179.g);
	MaterialFloat Local197 = lerp(Local195,Local196,Local59);
	MaterialFloat Local198 = lerp(Material.PreshaderBuffer[48].x,Material.PreshaderBuffer[47].w,Local184.g);
	MaterialFloat Local199 = lerp(Local197,Local198,Local70);
	MaterialFloat Local200 = lerp(Material.PreshaderBuffer[48].z,Material.PreshaderBuffer[48].y,Local189.g);
	MaterialFloat Local201 = lerp(Local199,Local200,Local81);
	MaterialFloat Local202 = lerp(Local119.a,1.00000000,0.50000000);
	MaterialFloat Local203 = (Local202 * Material.PreshaderBuffer[48].w);
	MaterialFloat3 Local204 = (Local166 * ((MaterialFloat3)Material.PreshaderBuffer[49].x));
	MaterialFloat Local205 = PositiveClampedPow(Local170.r,Material.PreshaderBuffer[49].z);
	MaterialFloat Local206 = PositiveClampedPow(Local174.r,Material.PreshaderBuffer[49].w);
	MaterialFloat Local207 = lerp(Local205,Local206,Local48);
	MaterialFloat Local208 = PositiveClampedPow(Local179.r,Material.PreshaderBuffer[50].x);
	MaterialFloat Local209 = lerp(Local207,Local208,Local59);
	MaterialFloat Local210 = PositiveClampedPow(Local184.r,Material.PreshaderBuffer[50].y);
	MaterialFloat Local211 = lerp(Local209,Local210,Local70);
	MaterialFloat Local212 = PositiveClampedPow(Local189.r,Material.PreshaderBuffer[50].z);
	MaterialFloat Local213 = lerp(Local211,Local212,Local81);

	PixelMaterialInputs.EmissiveColor = Local168;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local203;
	PixelMaterialInputs.BaseColor = Local166;
	PixelMaterialInputs.Metallic = Local192;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[46].x;
	PixelMaterialInputs.Roughness = Local201;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local104;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local204,Material.PreshaderBuffer[49].y);
	PixelMaterialInputs.AmbientOcclusion = Local213;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 6;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();
	PixelMaterialInputs.SurfaceThickness = 0.01000000;


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
	if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}