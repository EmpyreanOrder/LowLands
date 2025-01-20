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
	float4 PreshaderBuffer[52];
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
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,4.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(4.000000,4.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,-0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,1.000000,4.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,-0.184427,3.433537,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,0.815573,0.184427,10.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,0.573696);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.573696,-0.573696,0.776276,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(2.000000,-1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.000000,0.000000,-0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(2.000000,-1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.000000,0.000000,0.600000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.000000,0.000000,0.793265,0.168000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(0.000000,0.000000,0.104000,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(0.916667,0.875790,0.816406,1.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.000000,0.000000,0.918018,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(0.916667,0.875790,0.816406,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.150000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[51] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
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
	MaterialFloat2 Local33 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)1.00000000));
	MaterialFloat Local34 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local33), 1);
	MaterialFloat4 Local35 = Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local33),View.MaterialTextureMipBias);
	MaterialFloat Local36 = MaterialStoreTexSample(Parameters, Local35, 1);
	MaterialFloat Local37 = (Local35.r * Material.PreshaderBuffer[12].z);
	MaterialFloat2 Local38 = (((MaterialFloat2)Material.PreshaderBuffer[12].w) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local39 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local38), 4);
	MaterialFloat4 Local40 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local38),View.MaterialTextureMipBias));
	MaterialFloat Local41 = MaterialStoreTexSample(Parameters, Local40, 4);
	MaterialFloat3 Local42 = (Local40.rgb * ((MaterialFloat3)Material.PreshaderBuffer[13].x));
	MaterialFloat3 Local43 = (((MaterialFloat3)Local35.r) + Local42);
	MaterialFloat3 Local44 = (((MaterialFloat3)Local37) * Local43);
	MaterialFloat Local45 = lerp(Material.PreshaderBuffer[13].z,Material.PreshaderBuffer[13].y,Local44.x);
	MaterialFloat Local46 = saturate(Local45);
	MaterialFloat Local47 = saturate(Local46.r);
	MaterialFloat3 Local48 = lerp(MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b),MaterialFloat3(MaterialFloat2(Local31,Local32),Local29.b),Local47);
	MaterialFloat2 Local49 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[13].w));
	MaterialFloat Local50 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local49), 2);
	MaterialFloat4 Local51 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local49),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local52 = MaterialStoreTexSample(Parameters, Local51, 2);
	MaterialFloat Local53 = (Local51.r * Material.PreshaderBuffer[14].x);
	MaterialFloat Local54 = (Local51.g * Material.PreshaderBuffer[14].x);
	MaterialFloat Local55 = lerp(Material.PreshaderBuffer[14].w,Material.PreshaderBuffer[14].z,Local35.g);
	MaterialFloat Local56 = saturate(Local55);
	MaterialFloat Local57 = (Local56.r * Material.PreshaderBuffer[15].x);
	MaterialFloat Local58 = saturate(Local57);
	MaterialFloat3 Local59 = lerp(Local48,MaterialFloat3(MaterialFloat2(Local53,Local54),Local51.b),Local58);
	MaterialFloat2 Local60 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[15].y));
	MaterialFloat Local61 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local60), 2);
	MaterialFloat4 Local62 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local60),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local63 = MaterialStoreTexSample(Parameters, Local62, 2);
	MaterialFloat Local64 = (Local62.r * Material.PreshaderBuffer[15].z);
	MaterialFloat Local65 = (Local62.g * Material.PreshaderBuffer[15].z);
	MaterialFloat Local66 = lerp(Material.PreshaderBuffer[16].y,Material.PreshaderBuffer[16].x,Local35.b);
	MaterialFloat Local67 = saturate(Local66);
	MaterialFloat Local68 = (Local67.r * Material.PreshaderBuffer[16].z);
	MaterialFloat Local69 = saturate(Local68);
	MaterialFloat3 Local70 = lerp(Local59,MaterialFloat3(MaterialFloat2(Local64,Local65),Local62.b),Local69);
	MaterialFloat Local71 = lerp(Material.PreshaderBuffer[17].y,Material.PreshaderBuffer[17].x,Local35.a);
	MaterialFloat Local72 = saturate(Local71);
	MaterialFloat Local73 = (Local72.r * Material.PreshaderBuffer[17].z);
	MaterialFloat Local74 = saturate(Local73);
	MaterialFloat3 Local75 = lerp(Local70,((MaterialFloat3)1.00000000),Local74);
	MaterialFloat2 Local76 = (DERIV_BASE_VALUE(Local22) * ((MaterialFloat2)Material.PreshaderBuffer[17].w));
	MaterialFloat Local77 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local76), 2);
	MaterialFloat4 Local78 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local76),DERIV_BASE_VALUE(Local26),DERIV_BASE_VALUE(Local27)));
	MaterialFloat Local79 = MaterialStoreTexSample(Parameters, Local78, 2);
	MaterialFloat Local80 = (Local78.r * Material.PreshaderBuffer[18].x);
	MaterialFloat Local81 = (Local78.g * Material.PreshaderBuffer[18].x);
	MaterialFloat3 Local82 = mul(MaterialFloat3(0.00000000,0.00000000,1.00000000), Parameters.TangentToWorld);
	MaterialFloat Local83 = dot(Local82,MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat2 Local84 = Parameters.TexCoords[1].xy;
	MaterialFloat2 Local85 = (DERIV_BASE_VALUE(Local84) * ((MaterialFloat2)Material.PreshaderBuffer[18].y));
	MaterialFloat Local86 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local85), 3);
	MaterialFloat4 Local87 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local85),View.MaterialTextureMipBias));
	MaterialFloat Local88 = MaterialStoreTexSample(Parameters, Local87, 3);
	MaterialFloat Local89 = lerp(0.00000000,Material.PreshaderBuffer[18].z,Local87.rgb.r);
	MaterialFloat Local90 = (Local83 * Local89);
	MaterialFloat Local91 = saturate(Local90);
	MaterialFloat3 Local92 = lerp(Local75,MaterialFloat3(MaterialFloat2(Local80,Local81),Local78.b),Local91);
	MaterialFloat Local93 = (Local92.b + 1.00000000);
	MaterialFloat Local94 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[20].xy);
	MaterialFloat Local95 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[20].zw);
	MaterialFloat2 Local96 = MaterialFloat2(DERIV_BASE_VALUE(Local94),DERIV_BASE_VALUE(Local95));
	MaterialFloat2 Local97 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local96));
	MaterialFloat2 Local98 = (DERIV_BASE_VALUE(Local97) + Material.PreshaderBuffer[21].zw);
	MaterialFloat2 Local99 = (DERIV_BASE_VALUE(Local98) * Material.PreshaderBuffer[23].yz);
	MaterialFloat2 Local100 = ddy((float2)DERIV_BASE_VALUE(Local99));
	MaterialFloat2 Local101 = ddx((float2)DERIV_BASE_VALUE(Local99));
	MaterialFloat2 Local102 = (DERIV_BASE_VALUE(Local101) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat2 Local103 = (DERIV_BASE_VALUE(Local100) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat Local104 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local99), 2);
	MaterialFloat4 Local105 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_8,samplerMaterial_Texture2D_8,DERIV_BASE_VALUE(Local99),DERIV_BASE_VALUE(Local102),DERIV_BASE_VALUE(Local103)));
	MaterialFloat Local106 = MaterialStoreTexSample(Parameters, Local105, 2);
	MaterialFloat Local107 = (Local105.r * Material.PreshaderBuffer[23].w);
	MaterialFloat Local108 = (Local105.g * Material.PreshaderBuffer[23].w);
	MaterialFloat2 Local109 = (MaterialFloat3(MaterialFloat2(Local107,Local108),Local105.b).rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local110 = dot(MaterialFloat3(Local92.rg,Local93),MaterialFloat3(Local109,MaterialFloat3(MaterialFloat2(Local107,Local108),Local105.b).b));
	MaterialFloat3 Local111 = (MaterialFloat3(Local92.rg,Local93) * ((MaterialFloat3)Local110));
	MaterialFloat3 Local112 = (((MaterialFloat3)Local93) * MaterialFloat3(Local109,MaterialFloat3(MaterialFloat2(Local107,Local108),Local105.b).b));
	MaterialFloat3 Local113 = (Local111 - Local112);
	MaterialFloat4 Local114 = Parameters.VertexColor;
	MaterialFloat Local115 = DERIV_BASE_VALUE(Local114).g;
	MaterialFloat Local116 = (DERIV_BASE_VALUE(Local115) * Material.PreshaderBuffer[24].y);
	MaterialFloat2 Local117 = (((MaterialFloat2)Material.PreshaderBuffer[24].z) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local118 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local117), 4);
	MaterialFloat4 Local119 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local117),View.MaterialTextureMipBias));
	MaterialFloat Local120 = MaterialStoreTexSample(Parameters, Local119, 4);
	MaterialFloat3 Local121 = (Local119.rgb * ((MaterialFloat3)Material.PreshaderBuffer[24].w));
	MaterialFloat3 Local122 = (((MaterialFloat3)DERIV_BASE_VALUE(Local115)) + Local121);
	MaterialFloat3 Local123 = (((MaterialFloat3)DERIV_BASE_VALUE(Local116)) * Local122);
	MaterialFloat Local124 = lerp(Material.PreshaderBuffer[25].y,Material.PreshaderBuffer[25].x,Local123.x);
	MaterialFloat Local125 = saturate(Local124);
	MaterialFloat Local126 = saturate(Local125.r);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local113;


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
	MaterialFloat Local127 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 0);
	MaterialFloat4 Local128 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local129 = MaterialStoreTexSample(Parameters, Local128, 0);
	MaterialFloat3 Local130 = (Local128.rgb * ((MaterialFloat3)Material.PreshaderBuffer[27].z));
	MaterialFloat Local131 = dot(Local130,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local132 = lerp(Local130,((MaterialFloat3)Local131),Material.PreshaderBuffer[27].w);
	MaterialFloat3 Local133 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[27].y),((MaterialFloat3)0.00000000),Local132);
	MaterialFloat3 Local134 = (Local133 + Local132);
	MaterialFloat3 Local135 = (Material.PreshaderBuffer[28].xyz * Local134);
	MaterialFloat Local136 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local25), 0);
	MaterialFloat4 Local137 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local25)));
	MaterialFloat Local138 = MaterialStoreTexSample(Parameters, Local137, 0);
	MaterialFloat3 Local139 = (Local137.rgb * ((MaterialFloat3)Material.PreshaderBuffer[30].z));
	MaterialFloat Local140 = dot(Local139,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local141 = lerp(Local139,((MaterialFloat3)Local140),Material.PreshaderBuffer[30].w);
	MaterialFloat3 Local142 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[30].y),((MaterialFloat3)0.00000000),Local141);
	MaterialFloat3 Local143 = (Local142 + Local141);
	MaterialFloat3 Local144 = (Material.PreshaderBuffer[31].xyz * Local143);
	MaterialFloat3 Local145 = lerp(Local135,Local144,Local47);
	MaterialFloat Local146 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local49), 0);
	MaterialFloat4 Local147 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local49)));
	MaterialFloat Local148 = MaterialStoreTexSample(Parameters, Local147, 0);
	MaterialFloat3 Local149 = (Local147.rgb * ((MaterialFloat3)Material.PreshaderBuffer[33].z));
	MaterialFloat Local150 = dot(Local149,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local151 = lerp(Local149,((MaterialFloat3)Local150),Material.PreshaderBuffer[33].w);
	MaterialFloat3 Local152 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[33].y),((MaterialFloat3)0.00000000),Local151);
	MaterialFloat3 Local153 = (Local152 + Local151);
	MaterialFloat3 Local154 = (Material.PreshaderBuffer[34].xyz * Local153);
	MaterialFloat3 Local155 = lerp(Local145,Local154,Local58);
	MaterialFloat Local156 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local60), 0);
	MaterialFloat4 Local157 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local60)));
	MaterialFloat Local158 = MaterialStoreTexSample(Parameters, Local157, 0);
	MaterialFloat3 Local159 = (Local157.rgb * ((MaterialFloat3)Material.PreshaderBuffer[36].z));
	MaterialFloat Local160 = dot(Local159,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local161 = lerp(Local159,((MaterialFloat3)Local160),Material.PreshaderBuffer[36].w);
	MaterialFloat3 Local162 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[36].y),((MaterialFloat3)0.00000000),Local161);
	MaterialFloat3 Local163 = (Local162 + Local161);
	MaterialFloat3 Local164 = (Material.PreshaderBuffer[37].xyz * Local163);
	MaterialFloat3 Local165 = lerp(Local155,Local164,Local69);
	MaterialFloat3 Local166 = lerp(Local165,((MaterialFloat3)1.00000000),Local74);
	MaterialFloat Local167 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local76), 0);
	MaterialFloat4 Local168 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local76)));
	MaterialFloat Local169 = MaterialStoreTexSample(Parameters, Local168, 0);
	MaterialFloat3 Local170 = (Local168.rgb * ((MaterialFloat3)Material.PreshaderBuffer[39].z));
	MaterialFloat Local171 = dot(Local170,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local172 = lerp(Local170,((MaterialFloat3)Local171),Material.PreshaderBuffer[39].w);
	MaterialFloat3 Local173 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[39].y),((MaterialFloat3)0.00000000),Local172);
	MaterialFloat3 Local174 = (Local173 + Local172);
	MaterialFloat3 Local175 = (Material.PreshaderBuffer[40].xyz * Local174);
	MaterialFloat Local176 = dot(WorldNormalCopy,normalize(MaterialFloat3(0.00000000,1.00000000,0.00000000)));
	MaterialFloat Local177 = (Local176 * 0.50000000);
	MaterialFloat Local178 = (Local177 + 0.50000000);
	MaterialFloat Local179 = lerp(Material.PreshaderBuffer[41].x,Material.PreshaderBuffer[40].w,Local87.rgb.r);
	MaterialFloat Local180 = (Local178 * Local179);
	MaterialFloat Local181 = (Local179 * 0.50000000);
	MaterialFloat Local182 = (-1.00000000 - Local181);
	MaterialFloat Local183 = (Local180 + Local182);
	MaterialFloat Local184 = saturate(Local183);
	MaterialFloat3 Local185 = lerp(Local166,Local175,Local184);
	MaterialFloat3 Local186 = (Local185 * Material.PreshaderBuffer[44].xyz);
	MaterialFloat3 Local187 = lerp(Local186,Material.PreshaderBuffer[45].xyz,Material.PreshaderBuffer[44].w);
	MaterialFloat Local188 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 1);
	MaterialFloat4 Local189 = Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7));
	MaterialFloat Local190 = MaterialStoreTexSample(Parameters, Local189, 1);
	MaterialFloat Local191 = (Local189.b * Material.PreshaderBuffer[45].w);
	MaterialFloat Local192 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local25), 1);
	MaterialFloat4 Local193 = Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local25));
	MaterialFloat Local194 = MaterialStoreTexSample(Parameters, Local193, 1);
	MaterialFloat Local195 = (Local193.b * Material.PreshaderBuffer[46].x);
	MaterialFloat Local196 = lerp(Local191,Local195,Local47);
	MaterialFloat Local197 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local49), 1);
	MaterialFloat4 Local198 = Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local49));
	MaterialFloat Local199 = MaterialStoreTexSample(Parameters, Local198, 1);
	MaterialFloat Local200 = PositiveClampedPow(Local198.b,Material.PreshaderBuffer[46].y);
	MaterialFloat Local201 = lerp(Local196,Local200,Local58);
	MaterialFloat Local202 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local60), 1);
	MaterialFloat4 Local203 = Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local60));
	MaterialFloat Local204 = MaterialStoreTexSample(Parameters, Local203, 1);
	MaterialFloat Local205 = PositiveClampedPow(Local203.b,Material.PreshaderBuffer[46].z);
	MaterialFloat Local206 = lerp(Local201,Local205,Local69);
	MaterialFloat Local207 = lerp(Local206,1.00000000,Local74);
	MaterialFloat Local208 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local76), 1);
	MaterialFloat4 Local209 = Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local76));
	MaterialFloat Local210 = MaterialStoreTexSample(Parameters, Local209, 1);
	MaterialFloat Local211 = PositiveClampedPow(Local209.b,Material.PreshaderBuffer[46].w);
	MaterialFloat Local212 = lerp(Local207,Local211,Local184);
	MaterialFloat Local213 = lerp(Material.PreshaderBuffer[47].z,Material.PreshaderBuffer[47].y,Local189.g);
	MaterialFloat Local214 = lerp(Material.PreshaderBuffer[48].x,Material.PreshaderBuffer[47].w,Local193.g);
	MaterialFloat Local215 = lerp(Local213,Local214,Local47);
	MaterialFloat Local216 = lerp(Material.PreshaderBuffer[48].z,Material.PreshaderBuffer[48].y,Local198.g);
	MaterialFloat Local217 = lerp(Local215,Local216,Local58);
	MaterialFloat Local218 = lerp(Material.PreshaderBuffer[49].x,Material.PreshaderBuffer[48].w,Local203.g);
	MaterialFloat Local219 = lerp(Local217,Local218,Local69);
	MaterialFloat Local220 = lerp(Local219,1.00000000,Local74);
	MaterialFloat Local221 = lerp(Material.PreshaderBuffer[49].z,Material.PreshaderBuffer[49].y,Local209.g);
	MaterialFloat Local222 = lerp(Local220,Local221,Local184);
	MaterialFloat Local223 = lerp(Local128.a,1.00000000,0.50000000);
	MaterialFloat Local224 = (Local223 * Material.PreshaderBuffer[49].w);
	MaterialFloat3 Local225 = (Local185 * ((MaterialFloat3)Material.PreshaderBuffer[50].x));
	MaterialFloat Local226 = PositiveClampedPow(Local189.r,Material.PreshaderBuffer[50].z);
	MaterialFloat Local227 = PositiveClampedPow(Local193.r,Material.PreshaderBuffer[50].w);
	MaterialFloat Local228 = lerp(Local226,Local227,Local47);
	MaterialFloat Local229 = PositiveClampedPow(Local198.r,Material.PreshaderBuffer[51].x);
	MaterialFloat Local230 = lerp(Local228,Local229,Local58);
	MaterialFloat Local231 = PositiveClampedPow(Local203.r,Material.PreshaderBuffer[51].y);
	MaterialFloat Local232 = lerp(Local230,Local231,Local69);
	MaterialFloat Local233 = lerp(Local232,1.00000000,Local74);
	MaterialFloat Local234 = PositiveClampedPow(Local209.r,Material.PreshaderBuffer[51].z);
	MaterialFloat Local235 = lerp(Local233,Local234,Local184);

	PixelMaterialInputs.EmissiveColor = Local187;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local224;
	PixelMaterialInputs.BaseColor = Local185;
	PixelMaterialInputs.Metallic = Local212;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[47].x;
	PixelMaterialInputs.Roughness = Local222;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local113;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local225,Material.PreshaderBuffer[50].y);
	PixelMaterialInputs.AmbientOcclusion = Local235;
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