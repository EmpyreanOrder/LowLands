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
TEXTURECUBE(     Material_TextureCube_0 );
SAMPLER(  samplerMaterial_TextureCube_0 );

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
	float4 PreshaderBuffer[71];
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
	Material.PreshaderBuffer[1] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,8.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.000000,0.600000,2.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(2.000000,2.000000,2.000000,0.100000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.600000,-0.600000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,2.100000,2.100000,2.100000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(2.100000,2.100000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,1.000000,8.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,1.000000,0.926365,1.497787);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.200000,1.853140,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.440000,0.256108,0.110000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.440000,0.256108,0.110000,0.220000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.050000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.560000,0.159699,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(4.100000,0.560000,0.159699,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.050000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(38.000000,120.000000,21.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(38.000000,120.000000,21.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(30.000000,0.600000,1.800000,1.050000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(-0.050000,2.296000,0.654766,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,0.520000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.810000,0.190000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(1.000000,1.000000,5.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(1.000000,1.000000,5.000000,5.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(1.000000,1.000000,5.000000,5.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(0.400000,10.000000,2.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.800000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.947000,0.776750,0.662900,1.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.457000,0.323277,0.228500,1.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.457000,0.323277,0.228500,0.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.947000,0.776750,0.662900,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.917000,0.699410,0.341000,1.000000);//(Unknown)
	Material.PreshaderBuffer[49] = float4(1.000000,0.917000,0.699410,0.341000);//(Unknown)
	Material.PreshaderBuffer[50] = float4(0.800000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[51] = float4(0.693000,0.210000,0.047124,1.000000);//(Unknown)
	Material.PreshaderBuffer[52] = float4(0.693000,0.210000,0.047124,0.400000);//(Unknown)
	Material.PreshaderBuffer[53] = float4(0.250000,1.400000,-0.400000,0.000000);//(Unknown)
	Material.PreshaderBuffer[54] = float4(0.020000,0.012899,0.008160,1.000000);//(Unknown)
	Material.PreshaderBuffer[55] = float4(0.020000,0.012899,0.008160,0.700000);//(Unknown)
	Material.PreshaderBuffer[56] = float4(0.900000,0.500000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[57] = float4(1.000000,0.000000,1.000000,0.315000);//(Unknown)
	Material.PreshaderBuffer[58] = float4(0.720000,0.700000,0.500000,0.150000);//(Unknown)
	Material.PreshaderBuffer[59] = float4(0.350000,0.700000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[60] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[61] = float4(0.477000,0.130661,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[62] = float4(0.400000,0.317795,0.165200,1.000000);//(Unknown)
	Material.PreshaderBuffer[63] = float4(0.400000,0.317795,0.165200,0.000000);//(Unknown)
	Material.PreshaderBuffer[64] = float4(0.477000,0.130661,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[65] = float4(0.500000,0.482835,0.286500,1.000000);//(Unknown)
	Material.PreshaderBuffer[66] = float4(0.500000,0.482835,0.286500,0.000000);//(Unknown)
	Material.PreshaderBuffer[67] = float4(0.735000,0.019110,0.019110,1.000000);//(Unknown)
	Material.PreshaderBuffer[68] = float4(0.735000,0.019110,0.019110,0.000000);//(Unknown)
	Material.PreshaderBuffer[69] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[70] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
}float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	return MaterialFloat3(0.00000000,0.00000000,0.00000000);;
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
	MaterialFloat Local1 = DERIV_BASE_VALUE(Local0).r;
	MaterialFloat Local2 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[2].x);
	MaterialFloat Local3 = DERIV_BASE_VALUE(Local0).g;
	MaterialFloat Local4 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[2].y);
	MaterialFloat2 Local5 = MaterialFloat2(DERIV_BASE_VALUE(Local2),DERIV_BASE_VALUE(Local4));
	MaterialFloat2 Local6 = (((MaterialFloat2)Material.PreshaderBuffer[2].z) * DERIV_BASE_VALUE(Local5));
	MaterialFloat Local7 = DERIV_BASE_VALUE(Local6).r;
	MaterialFloat Local8 = (DERIV_BASE_VALUE(Local7) + Material.PreshaderBuffer[2].w);
	MaterialFloat Local9 = DERIV_BASE_VALUE(Local6).g;
	MaterialFloat Local10 = (DERIV_BASE_VALUE(Local9) + Material.PreshaderBuffer[3].x);
	MaterialFloat2 Local11 = MaterialFloat2(DERIV_BASE_VALUE(Local8),DERIV_BASE_VALUE(Local10));
	MaterialFloat Local12 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 7);
	MaterialFloat4 Local13 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 7);
	MaterialFloat2 Local15 = (Local13.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[3].y));
	MaterialFloat Local16 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[5].x);
	MaterialFloat Local17 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[5].y);
	MaterialFloat2 Local18 = MaterialFloat2(DERIV_BASE_VALUE(Local16),DERIV_BASE_VALUE(Local17));
	MaterialFloat2 Local19 = (((MaterialFloat2)Material.PreshaderBuffer[5].z) * DERIV_BASE_VALUE(Local18));
	MaterialFloat Local20 = DERIV_BASE_VALUE(Local19).r;
	MaterialFloat Local21 = (DERIV_BASE_VALUE(Local20) + Material.PreshaderBuffer[5].w);
	MaterialFloat Local22 = DERIV_BASE_VALUE(Local19).g;
	MaterialFloat Local23 = (DERIV_BASE_VALUE(Local22) + Material.PreshaderBuffer[6].x);
	MaterialFloat2 Local24 = MaterialFloat2(DERIV_BASE_VALUE(Local21),DERIV_BASE_VALUE(Local23));
	MaterialFloat Local25 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 7);
	MaterialFloat4 Local26 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local27 = MaterialStoreTexSample(Parameters, Local26, 7);
	MaterialFloat2 Local28 = (Local26.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[6].y));
	MaterialFloat Local29 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local30 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0)));
	MaterialFloat Local31 = MaterialStoreTexSample(Parameters, Local30, 7);
	MaterialFloat2 Local32 = (Local30.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[6].z));
	MaterialFloat Local33 = (MaterialFloat3(Local32,Local30.rgb.b).b + 1.00000000);
	MaterialFloat2 Local34 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[6].w));
	MaterialFloat Local35 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local34), 7);
	MaterialFloat4 Local36 = UnpackNormalMap(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local34)));
	MaterialFloat Local37 = MaterialStoreTexSample(Parameters, Local36, 7);
	MaterialFloat2 Local38 = (Local36.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[7].x));
	MaterialFloat2 Local39 = (MaterialFloat3(Local38,Local36.rgb.b).rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local40 = dot(MaterialFloat3(MaterialFloat3(Local32,Local30.rgb.b).rg,Local33),MaterialFloat3(Local39,MaterialFloat3(Local38,Local36.rgb.b).b));
	MaterialFloat3 Local41 = (MaterialFloat3(MaterialFloat3(Local32,Local30.rgb.b).rg,Local33) * ((MaterialFloat3)Local40));
	MaterialFloat3 Local42 = (((MaterialFloat3)Local33) * MaterialFloat3(Local39,MaterialFloat3(Local38,Local36.rgb.b).b));
	MaterialFloat3 Local43 = (Local41 - Local42);
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 12);
	MaterialFloat4 Local45 = Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias);
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 12);
	MaterialFloat Local47 = (Local45.rgb.r - 1.00000000);
	MaterialFloat4 Local48 = Parameters.VertexColor;
	MaterialFloat Local49 = DERIV_BASE_VALUE(Local48).r;
	MaterialFloat2 Local50 = (Material.PreshaderBuffer[8].yz * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local51 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 12);
	MaterialFloat4 Local52 = Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local50),View.MaterialTextureMipBias);
	MaterialFloat Local53 = MaterialStoreTexSample(Parameters, Local52, 12);
	MaterialFloat Local54 = max(Local52.r,Material.PreshaderBuffer[8].w);
	MaterialFloat Local55 = min(Local54,Material.PreshaderBuffer[9].x);
	MaterialFloat Local56 = (DERIV_BASE_VALUE(Local49) + Local55);
	MaterialFloat Local57 = (Local56 * DERIV_BASE_VALUE(Local49));
	MaterialFloat Local58 = lerp(Material.PreshaderBuffer[9].z,Material.PreshaderBuffer[9].y,Local57);
	MaterialFloat Local59 = saturate(Local58);
	MaterialFloat Local60 = (Local59.r * 2.00000000);
	MaterialFloat Local61 = (Local47 + Local60);
	MaterialFloat Local62 = saturate(Local61);
	MaterialFloat Local63 = lerp(Material.PreshaderBuffer[10].x,Material.PreshaderBuffer[9].w,Local62);
	MaterialFloat Local64 = saturate(Local63);
	MaterialFloat3 Local65 = lerp(MaterialFloat3(Local28,1.00000000),Local43,Local64.r.r);
	MaterialFloat Local66 = DERIV_BASE_VALUE(Local48).b;
	MaterialFloat Local67 = (DERIV_BASE_VALUE(Local66) + Local55);
	MaterialFloat Local68 = (Local67 * DERIV_BASE_VALUE(Local66));
	MaterialFloat Local69 = lerp(Material.PreshaderBuffer[9].z,Material.PreshaderBuffer[9].y,Local68);
	MaterialFloat Local70 = saturate(Local69);
	MaterialFloat Local71 = (Local70.r * 2.00000000);
	MaterialFloat Local72 = (Local47 + Local71);
	MaterialFloat Local73 = saturate(Local72);
	MaterialFloat Local74 = lerp(Material.PreshaderBuffer[10].x,Material.PreshaderBuffer[9].w,Local73);
	MaterialFloat Local75 = saturate(Local74);
	MaterialFloat3 Local76 = lerp(MaterialFloat3(Local15,1.00000000),Local65,Local75.r.r);
	MaterialFloat Local77 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 11);
	MaterialFloat4 Local78 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local79 = MaterialStoreTexSample(Parameters, Local78, 11);
	MaterialFloat3 Local80 = (Material.PreshaderBuffer[11].xyz * Local78.rgb);
	MaterialFloat Local81 = (Local80.b + 1.00000000);
	MaterialFloat Local82 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[13].x);
	MaterialFloat Local83 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[13].y);
	MaterialFloat2 Local84 = MaterialFloat2(DERIV_BASE_VALUE(Local82),DERIV_BASE_VALUE(Local83));
	MaterialFloat2 Local85 = (((MaterialFloat2)Material.PreshaderBuffer[13].z) * DERIV_BASE_VALUE(Local84));
	MaterialFloat Local86 = DERIV_BASE_VALUE(Local85).r;
	MaterialFloat Local87 = (DERIV_BASE_VALUE(Local86) + Material.PreshaderBuffer[13].w);
	MaterialFloat Local88 = DERIV_BASE_VALUE(Local85).g;
	MaterialFloat Local89 = (DERIV_BASE_VALUE(Local88) + Material.PreshaderBuffer[14].x);
	MaterialFloat2 Local90 = MaterialFloat2(DERIV_BASE_VALUE(Local87),DERIV_BASE_VALUE(Local89));
	MaterialFloat Local91 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local90), 4);
	MaterialFloat4 Local92 = UnpackNormalMap(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local90)));
	MaterialFloat Local93 = MaterialStoreTexSample(Parameters, Local92, 4);
	MaterialFloat2 Local94 = (Local92.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[14].y));
	MaterialFloat Local95 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local90), 3);
	MaterialFloat4 Local96 = UnpackNormalMap(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local90)));
	MaterialFloat Local97 = MaterialStoreTexSample(Parameters, Local96, 3);
	MaterialFloat2 Local98 = (Local96.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[14].z));
	MaterialFloat Local99 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local90), 2);
	MaterialFloat4 Local100 = UnpackNormalMap(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local90)));
	MaterialFloat Local101 = MaterialStoreTexSample(Parameters, Local100, 2);
	MaterialFloat2 Local102 = (Local100.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[14].w));
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 10);
	MaterialFloat4 Local104 = Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 10);
	MaterialFloat Local106 = (Local104.r * Material.PreshaderBuffer[15].x);
	MaterialFloat3 Local107 = lerp(MaterialFloat3(Local98,Local96.rgb.b),MaterialFloat3(Local102,Local100.rgb.b),Local106);
	MaterialFloat Local108 = (Local104.g * Material.PreshaderBuffer[15].y);
	MaterialFloat3 Local109 = lerp(MaterialFloat3(Local94,Local92.rgb.b),Local107,Local108);
	MaterialFloat2 Local110 = (Local109.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local111 = dot(MaterialFloat3(Local80.rg,Local81),MaterialFloat3(Local110,Local109.b));
	MaterialFloat3 Local112 = (MaterialFloat3(Local80.rg,Local81) * ((MaterialFloat3)Local111));
	MaterialFloat3 Local113 = (((MaterialFloat3)Local81) * MaterialFloat3(Local110,Local109.b));
	MaterialFloat3 Local114 = (Local112 - Local113);
	MaterialFloat Local115 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 9);
	MaterialFloat4 Local116 = Texture2DSampleBias(Material_Texture2D_11,samplerMaterial_Texture2D_11,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias);
	MaterialFloat Local117 = MaterialStoreTexSample(Parameters, Local116, 9);
	MaterialFloat Local118 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local116.r);
	MaterialFloat Local119 = saturate(Local118);
	MaterialFloat Local120 = (Local119.r * Material.PreshaderBuffer[15].z);
	MaterialFloat3 Local121 = lerp(Local76.rgb,Local114,Local120);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local121;


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
	MaterialFloat Local122 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local123 = Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0));
	MaterialFloat Local124 = MaterialStoreTexSample(Parameters, Local123, 8);
	MaterialFloat3 Local125 = (Material.PreshaderBuffer[17].xyz * ((MaterialFloat3)Local123.r));
	MaterialFloat3 Local126 = (Local125 * ((MaterialFloat3)Material.PreshaderBuffer[17].w));
	MaterialFloat Local127 = (1.00000000 - Local123.r);
	MaterialFloat Local128 = (Local127 * Material.PreshaderBuffer[18].x);
	MaterialFloat3 Local129 = (Local126 - ((MaterialFloat3)Local128));
	MaterialFloat3 Local130 = mul(Local114, Parameters.TangentToWorld);
	FLWCVector3 Local131 = GetWorldPosition(Parameters);
	FLWCVector3 Local132 = LWCAdd(GetObjectWorldPosition(Parameters), LWCPromote(Material.PreshaderBuffer[23].xyz));
	FLWCVector3 Local133 = LWCSubtract(DERIV_BASE_VALUE(Local131), Local132);
	MaterialFloat3 Local134 = LWCToFloat(DERIV_BASE_VALUE(Local133));
	MaterialFloat3 Local135 = (Local130 * ((MaterialFloat3)Material.PreshaderBuffer[24].x));
	MaterialFloat3 Local136 = (DERIV_BASE_VALUE(Local134) + Local135);
	MaterialFloat3 Local137 = normalize(Local136);
	MaterialFloat3 Local138 = lerp(Local130,Local137,Material.PreshaderBuffer[24].y);
	MaterialFloat Local139 = dot(Local138,Parameters.CameraVector);
	MaterialFloat Local140 = max(0.00000000,Local139);
	MaterialFloat Local141 = (1.00000000 - Local140);
	MaterialFloat Local142 = abs(Local141);
	MaterialFloat Local143 = max(Local142,0.00010000);
	MaterialFloat Local144 = PositiveClampedPow(Local143,Material.PreshaderBuffer[24].z);
	MaterialFloat Local145 = (Local144 * (1.00000000 - 0.04000000));
	MaterialFloat Local146 = (Local145 + 0.04000000);
	MaterialFloat Local147 = lerp(Material.PreshaderBuffer[25].x,Material.PreshaderBuffer[24].w,Local146);
	MaterialFloat Local148 = saturate(Local147);
	MaterialFloat3 Local149 = lerp(Local129,Material.PreshaderBuffer[25].yzw,Local148.r);
	MaterialFloat3 Local150 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Local149,Local120);
	MaterialFloat3 Local151 = lerp(Local150,Material.PreshaderBuffer[26].yzw,Material.PreshaderBuffer[26].x);
	MaterialFloat Local152 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 15);
	MaterialFloat4 Local153 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local154 = MaterialStoreTexSample(Parameters, Local153, 15);
	MaterialFloat3 Local155 = (Local153.rgb * Material.PreshaderBuffer[29].xyz);
	MaterialFloat3 Local156 = (Local155 * ((MaterialFloat3)Material.PreshaderBuffer[29].w));
	MaterialFloat Local157 = dot(Local156,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local158 = lerp(Local156,((MaterialFloat3)Local157),Material.PreshaderBuffer[30].y);
	MaterialFloat Local159 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 15);
	MaterialFloat4 Local160 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local161 = MaterialStoreTexSample(Parameters, Local160, 15);
	MaterialFloat3 Local162 = (Local160.rgb * Material.PreshaderBuffer[33].xyz);
	MaterialFloat3 Local163 = (Local162 * ((MaterialFloat3)Material.PreshaderBuffer[33].w));
	MaterialFloat Local164 = dot(Local163,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local165 = lerp(Local163,((MaterialFloat3)Local164),Material.PreshaderBuffer[34].y);
	MaterialFloat Local166 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 5);
	MaterialFloat4 Local167 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0)));
	MaterialFloat Local168 = MaterialStoreTexSample(Parameters, Local167, 5);
	MaterialFloat3 Local169 = (Local167.rgb * Material.PreshaderBuffer[37].xyz);
	MaterialFloat3 Local170 = (Local169 * ((MaterialFloat3)Material.PreshaderBuffer[37].w));
	MaterialFloat Local171 = dot(Local170,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local172 = lerp(Local170,((MaterialFloat3)Local171),Material.PreshaderBuffer[38].y);
	MaterialFloat3 Local173 = lerp(Local165,Local172,Local64.r.r);
	MaterialFloat3 Local174 = lerp(Local158,Local173,Local75.r.r);
	MaterialFloat2 Local175 = (DERIV_BASE_VALUE(Local0) * Material.PreshaderBuffer[41].zw);
	MaterialFloat2 Local176 = (Local109.rg * ((MaterialFloat2)Material.PreshaderBuffer[42].x));
	MaterialFloat2 Local177 = (DERIV_BASE_VALUE(Local175) + MaterialFloat3(Local176,Local109.b).rg);
	MaterialFloat Local178 = (-0.05000000 * Material.PreshaderBuffer[42].y);
	MaterialFloat Local179 = (Local178 + 0.02500000);
	MaterialFloat3 Local180 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Parameters.CameraVector);
	MaterialFloat2 Local181 = (Local180.rg * ((MaterialFloat2)Local179));
	MaterialFloat2 Local182 = (Local181 + Local177);
	MaterialFloat Local183 = MaterialStoreTexCoordScale(Parameters, Local182, 1);
	MaterialFloat4 Local184 = Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),Local182);
	MaterialFloat Local185 = MaterialStoreTexSample(Parameters, Local184, 1);
	MaterialFloat Local186 = PositiveClampedPow(Local104.g,Material.PreshaderBuffer[42].z);
	MaterialFloat Local187 = lerp(Material.PreshaderBuffer[43].x,Material.PreshaderBuffer[42].w,Local186);
	MaterialFloat Local188 = lerp(1.00000000,Local184.g,Local187);
	MaterialFloat3 Local189 = lerp(Material.PreshaderBuffer[47].xyz,Material.PreshaderBuffer[46].xyz,Local186);
	MaterialFloat Local190 = PositiveClampedPow(Local104.b,Material.PreshaderBuffer[49].x);
	MaterialFloat3 Local191 = lerp(Local189,Material.PreshaderBuffer[49].yzw,Local190);
	MaterialFloat3 Local192 = (((MaterialFloat3)Local188) * Local191);
	MaterialFloat Local193 = lerp(1.00000000,Local184.g,Material.PreshaderBuffer[50].x);
	MaterialFloat3 Local194 = (((MaterialFloat3)Local193) * Material.PreshaderBuffer[52].xyz);
	MaterialFloat Local195 = PositiveClampedPow(Local143,Material.PreshaderBuffer[53].x);
	MaterialFloat Local196 = (Local195 * (1.00000000 - 0.04000000));
	MaterialFloat Local197 = (Local196 + 0.04000000);
	MaterialFloat Local198 = (1.00000000 - Local197);
	MaterialFloat Local199 = lerp(Material.PreshaderBuffer[53].z,Material.PreshaderBuffer[53].y,Local198);
	MaterialFloat Local200 = saturate(Local199);
	MaterialFloat3 Local201 = lerp(Local192,Local194,Local200.r);
	MaterialFloat3 Local202 = ReflectionAboutCustomWorldNormal(Parameters, Local130, false);
	MaterialFloat Local203 = MaterialStoreTexCoordScale(Parameters, Local202, 0);
	MaterialFloat4 Local204 = ProcessMaterialLinearColorTextureLookup(TextureCubeSample(Material_TextureCube_0,GetMaterialSharedSampler(samplerMaterial_TextureCube_0,Material_Wrap_WorldGroupSettings),Local202));
	MaterialFloat Local205 = MaterialStoreTexSample(Parameters, Local204, 0);
	MaterialFloat3 Local206 = (Local204.rgb * Material.PreshaderBuffer[55].xyz);
	MaterialFloat3 Local207 = (Local201 + Local206);
	MaterialFloat3 Local208 = lerp(Local174.rgb,Local207,Local120);
	MaterialFloat Local209 = lerp(0.00000000,Material.PreshaderBuffer[55].w,Local120);
	MaterialFloat Local210 = lerp(Material.PreshaderBuffer[56].y,Material.PreshaderBuffer[56].x,Local120);
	MaterialFloat Local211 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 6);
	MaterialFloat4 Local212 = Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11));
	MaterialFloat Local213 = MaterialStoreTexSample(Parameters, Local212, 6);
	MaterialFloat Local214 = (Local212.rgb.g * Material.PreshaderBuffer[56].z);
	MaterialFloat Local215 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 6);
	MaterialFloat4 Local216 = Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24));
	MaterialFloat Local217 = MaterialStoreTexSample(Parameters, Local216, 6);
	MaterialFloat Local218 = (Local216.rgb.g * Material.PreshaderBuffer[56].w);
	MaterialFloat Local219 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 6);
	MaterialFloat4 Local220 = Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0));
	MaterialFloat Local221 = MaterialStoreTexSample(Parameters, Local220, 6);
	MaterialFloat Local222 = lerp(Material.PreshaderBuffer[57].y,Material.PreshaderBuffer[57].x,Local220.rgb.g);
	MaterialFloat Local223 = (Local222 * Material.PreshaderBuffer[57].z);
	MaterialFloat Local224 = lerp(Local218,Local223,Local64.r.r);
	MaterialFloat Local225 = lerp(Local214,Local224,Local75.r.r);
	MaterialFloat Local226 = lerp(Material.PreshaderBuffer[58].x,Material.PreshaderBuffer[57].w,Local104.g);
	MaterialFloat Local227 = lerp(Local226,Material.PreshaderBuffer[58].y,Local104.b);
	MaterialFloat Local228 = lerp(Local225.r,Local227,Local120);
	MaterialFloat Local229 = lerp(Material.PreshaderBuffer[58].w,Material.PreshaderBuffer[58].z,Local186);
	MaterialFloat Local230 = lerp(Local229,Material.PreshaderBuffer[59].x,Local190);
	MaterialFloat Local231 = lerp(Local230,Material.PreshaderBuffer[59].y,Local200.r);
	MaterialFloat Local232 = lerp(Material.PreshaderBuffer[59].z,Local231,Local120);
	MaterialFloat3 Local238 = lerp(Material.PreshaderBuffer[64].xyz,Material.PreshaderBuffer[63].xyz,Local186);
	MaterialFloat3 Local239 = lerp(Local238,Material.PreshaderBuffer[66].xyz,Local190);
	MaterialFloat3 Local240 = (((MaterialFloat3)Local188) * Local239);
	MaterialFloat3 Local241 = (((MaterialFloat3)Local193) * Material.PreshaderBuffer[68].xyz);
	MaterialFloat3 Local242 = lerp(Local240,Local241,Local200.r);
	MaterialFloat3 Local243 = lerp(Material.PreshaderBuffer[69].xyz,Local242,Local120);
	MaterialFloat Local244 = (Local212.rgb.r * Material.PreshaderBuffer[70].x);
	MaterialFloat Local245 = (Local216.rgb.r * Material.PreshaderBuffer[70].y);
	MaterialFloat Local246 = (Local220.rgb.r * Material.PreshaderBuffer[70].z);
	MaterialFloat Local247 = lerp(Local245,Local246,Local64.r.r);
	MaterialFloat Local248 = lerp(Local244,Local247,Local75.r.r);
	MaterialFloat Local249 = lerp(Local248.r,Local220.r,Local120);

	PixelMaterialInputs.EmissiveColor = Local151;
	PixelMaterialInputs.Opacity = Local232;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local208;
	PixelMaterialInputs.Metallic = Local209;
	PixelMaterialInputs.Specular = Local210;
	PixelMaterialInputs.Roughness = Local228;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local121;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local243,Material.PreshaderBuffer[69].w);
	PixelMaterialInputs.AmbientOcclusion = Local249;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 2;
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
	Offset = GetMaterialWorldPositionOffset( Parameters );
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