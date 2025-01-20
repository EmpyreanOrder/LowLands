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
	Material.PreshaderBuffer[1] = float4(0.000000,0.000000,0.000000,-0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,-0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,1.000000,1.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(-1.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(-0.000000,1.000000,1.000000,-0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(2.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,2.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.916667,0.875790,0.816406,1.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.000000,0.000000,0.918018,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.916667,0.875790,0.816406,2.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(3.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(1.000000,0.150000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.000000,1.000000,1.000000,0.000000);//(Unknown)
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
	MaterialFloat2 Local17 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)1.00000000));
	MaterialFloat Local18 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local17), 1);
	MaterialFloat4 Local19 = Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local17),View.MaterialTextureMipBias);
	MaterialFloat Local20 = MaterialStoreTexSample(Parameters, Local19, 1);
	MaterialFloat Local21 = (Local19.r * Material.PreshaderBuffer[7].x);
	MaterialFloat2 Local22 = (((MaterialFloat2)Material.PreshaderBuffer[7].y) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local23 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local22), 4);
	MaterialFloat4 Local24 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local22),View.MaterialTextureMipBias));
	MaterialFloat Local25 = MaterialStoreTexSample(Parameters, Local24, 4);
	MaterialFloat3 Local26 = (Local24.rgb * ((MaterialFloat3)Material.PreshaderBuffer[7].z));
	MaterialFloat3 Local27 = (((MaterialFloat3)Local19.r) + Local26);
	MaterialFloat3 Local28 = (((MaterialFloat3)Local21) * Local27);
	MaterialFloat Local29 = lerp(Material.PreshaderBuffer[8].x,Material.PreshaderBuffer[7].w,Local28.x);
	MaterialFloat Local30 = saturate(Local29);
	MaterialFloat Local31 = saturate(Local30.r);
	MaterialFloat3 Local32 = lerp(MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b),((MaterialFloat3)1.00000000),Local31);
	MaterialFloat Local33 = lerp(Material.PreshaderBuffer[8].w,Material.PreshaderBuffer[8].z,Local19.g);
	MaterialFloat Local34 = saturate(Local33);
	MaterialFloat Local35 = (Local34.r * Material.PreshaderBuffer[9].x);
	MaterialFloat Local36 = saturate(Local35);
	MaterialFloat3 Local37 = lerp(Local32,((MaterialFloat3)1.00000000),Local36);
	MaterialFloat Local38 = lerp(Material.PreshaderBuffer[9].w,Material.PreshaderBuffer[9].z,Local19.b);
	MaterialFloat Local39 = saturate(Local38);
	MaterialFloat Local40 = (Local39.r * Material.PreshaderBuffer[10].x);
	MaterialFloat Local41 = saturate(Local40);
	MaterialFloat3 Local42 = lerp(Local37,((MaterialFloat3)1.00000000),Local41);
	MaterialFloat Local43 = lerp(Material.PreshaderBuffer[10].w,Material.PreshaderBuffer[10].z,Local19.a);
	MaterialFloat Local44 = saturate(Local43);
	MaterialFloat Local45 = (Local44.r * Material.PreshaderBuffer[11].x);
	MaterialFloat Local46 = saturate(Local45);
	MaterialFloat3 Local47 = lerp(Local42,((MaterialFloat3)1.00000000),Local46);
	MaterialFloat2 Local48 = Parameters.TexCoords[1].xy;
	MaterialFloat2 Local49 = ((MaterialFloat2(0.50000000,0.50000000) * -1.00000000) + DERIV_BASE_VALUE(Local48));
	MaterialFloat Local50 = dot(DERIV_BASE_VALUE(Local49),Material.PreshaderBuffer[12].zw);
	MaterialFloat Local51 = dot(DERIV_BASE_VALUE(Local49),Material.PreshaderBuffer[13].xy);
	MaterialFloat2 Local52 = MaterialFloat2(DERIV_BASE_VALUE(Local50),DERIV_BASE_VALUE(Local51));
	MaterialFloat2 Local53 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local52));
	MaterialFloat2 Local54 = (DERIV_BASE_VALUE(Local53) + Material.PreshaderBuffer[14].xy);
	MaterialFloat2 Local55 = (DERIV_BASE_VALUE(Local54) * Material.PreshaderBuffer[16].xy);
	MaterialFloat2 Local56 = ddy((float2)DERIV_BASE_VALUE(Local55));
	MaterialFloat2 Local57 = ddx((float2)DERIV_BASE_VALUE(Local55));
	MaterialFloat2 Local58 = (DERIV_BASE_VALUE(Local55) * ((MaterialFloat2)Material.PreshaderBuffer[16].z));
	MaterialFloat2 Local59 = (DERIV_BASE_VALUE(Local57) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat2 Local60 = (DERIV_BASE_VALUE(Local56) * ((MaterialFloat2)View.MaterialTextureDerivativeMultiply));
	MaterialFloat Local61 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local58), 2);
	MaterialFloat4 Local62 = UnpackNormalMap(Texture2DSampleGrad(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local58),DERIV_BASE_VALUE(Local59),DERIV_BASE_VALUE(Local60)));
	MaterialFloat Local63 = MaterialStoreTexSample(Parameters, Local62, 2);
	MaterialFloat Local64 = (Local62.r * Material.PreshaderBuffer[16].w);
	MaterialFloat Local65 = (Local62.g * Material.PreshaderBuffer[16].w);
	MaterialFloat3 Local66 = mul(MaterialFloat3(0.00000000,0.00000000,1.00000000), Parameters.TangentToWorld);
	MaterialFloat Local67 = dot(Local66,MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat2 Local68 = (DERIV_BASE_VALUE(Local48) * ((MaterialFloat2)Material.PreshaderBuffer[17].x));
	MaterialFloat Local69 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local68), 3);
	MaterialFloat4 Local70 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local68),View.MaterialTextureMipBias));
	MaterialFloat Local71 = MaterialStoreTexSample(Parameters, Local70, 3);
	MaterialFloat Local72 = lerp(0.00000000,Material.PreshaderBuffer[17].y,Local70.rgb.r);
	MaterialFloat Local73 = (Local67 * Local72);
	MaterialFloat Local74 = saturate(Local73);
	MaterialFloat3 Local75 = lerp(Local47,MaterialFloat3(MaterialFloat2(Local64,Local65),Local62.b),Local74);
	MaterialFloat4 Local76 = Parameters.VertexColor;
	MaterialFloat Local77 = DERIV_BASE_VALUE(Local76).g;
	MaterialFloat Local78 = (DERIV_BASE_VALUE(Local77) * Material.PreshaderBuffer[17].w);
	MaterialFloat2 Local79 = (((MaterialFloat2)Material.PreshaderBuffer[18].x) * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local80 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 4);
	MaterialFloat4 Local81 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local79),View.MaterialTextureMipBias));
	MaterialFloat Local82 = MaterialStoreTexSample(Parameters, Local81, 4);
	MaterialFloat3 Local83 = (Local81.rgb * ((MaterialFloat3)Material.PreshaderBuffer[18].y));
	MaterialFloat3 Local84 = (((MaterialFloat3)DERIV_BASE_VALUE(Local77)) + Local83);
	MaterialFloat3 Local85 = (((MaterialFloat3)DERIV_BASE_VALUE(Local78)) * Local84);
	MaterialFloat Local86 = lerp(Material.PreshaderBuffer[18].w,Material.PreshaderBuffer[18].z,Local85.x);
	MaterialFloat Local87 = saturate(Local86);
	MaterialFloat Local88 = saturate(Local87.r);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local75;


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
	MaterialFloat Local89 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 0);
	MaterialFloat4 Local90 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local91 = MaterialStoreTexSample(Parameters, Local90, 0);
	MaterialFloat3 Local92 = (Local90.rgb * ((MaterialFloat3)Material.PreshaderBuffer[20].z));
	MaterialFloat Local93 = dot(Local92,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local94 = lerp(Local92,((MaterialFloat3)Local93),Material.PreshaderBuffer[20].w);
	MaterialFloat3 Local95 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[20].y),((MaterialFloat3)0.00000000),Local94);
	MaterialFloat3 Local96 = (Local95 + Local94);
	MaterialFloat3 Local97 = (Material.PreshaderBuffer[21].xyz * Local96);
	MaterialFloat3 Local98 = lerp(Local97,((MaterialFloat3)1.00000000),Local31);
	MaterialFloat3 Local99 = lerp(Local98,((MaterialFloat3)1.00000000),Local36);
	MaterialFloat3 Local100 = lerp(Local99,((MaterialFloat3)1.00000000),Local41);
	MaterialFloat3 Local101 = lerp(Local100,((MaterialFloat3)1.00000000),Local46);
	MaterialFloat Local102 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local58), 0);
	MaterialFloat4 Local103 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local58)));
	MaterialFloat Local104 = MaterialStoreTexSample(Parameters, Local103, 0);
	MaterialFloat3 Local105 = (Local103.rgb * ((MaterialFloat3)Material.PreshaderBuffer[23].z));
	MaterialFloat Local106 = dot(Local105,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local107 = lerp(Local105,((MaterialFloat3)Local106),Material.PreshaderBuffer[23].w);
	MaterialFloat3 Local108 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[23].y),((MaterialFloat3)0.00000000),Local107);
	MaterialFloat3 Local109 = (Local108 + Local107);
	MaterialFloat3 Local110 = (Material.PreshaderBuffer[24].xyz * Local109);
	MaterialFloat Local111 = dot(WorldNormalCopy,normalize(MaterialFloat3(0.00000000,1.00000000,0.00000000)));
	MaterialFloat Local112 = (Local111 * 0.50000000);
	MaterialFloat Local113 = (Local112 + 0.50000000);
	MaterialFloat Local114 = lerp(Material.PreshaderBuffer[25].x,Material.PreshaderBuffer[24].w,Local70.rgb.r);
	MaterialFloat Local115 = (Local113 * Local114);
	MaterialFloat Local116 = (Local114 * 0.50000000);
	MaterialFloat Local117 = (-1.00000000 - Local116);
	MaterialFloat Local118 = (Local115 + Local117);
	MaterialFloat Local119 = saturate(Local118);
	MaterialFloat3 Local120 = lerp(Local101,Local110,Local119);
	MaterialFloat3 Local121 = (Local120 * Material.PreshaderBuffer[28].xyz);
	MaterialFloat3 Local122 = lerp(Local121,Material.PreshaderBuffer[29].xyz,Material.PreshaderBuffer[28].w);
	MaterialFloat Local123 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 1);
	MaterialFloat4 Local124 = Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7));
	MaterialFloat Local125 = MaterialStoreTexSample(Parameters, Local124, 1);
	MaterialFloat Local126 = (Local124.b * Material.PreshaderBuffer[29].w);
	MaterialFloat Local127 = lerp(Local126,1.00000000,Local31);
	MaterialFloat Local128 = lerp(Local127,1.00000000,Local36);
	MaterialFloat Local129 = lerp(Local128,1.00000000,Local41);
	MaterialFloat Local130 = lerp(Local129,1.00000000,Local46);
	MaterialFloat Local131 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local58), 1);
	MaterialFloat4 Local132 = Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local58));
	MaterialFloat Local133 = MaterialStoreTexSample(Parameters, Local132, 1);
	MaterialFloat Local134 = PositiveClampedPow(Local132.b,Material.PreshaderBuffer[30].x);
	MaterialFloat Local135 = lerp(Local130,Local134,Local119);
	MaterialFloat Local136 = lerp(Material.PreshaderBuffer[30].w,Material.PreshaderBuffer[30].z,Local124.g);
	MaterialFloat Local137 = lerp(Local136,1.00000000,Local31);
	MaterialFloat Local138 = lerp(Local137,1.00000000,Local36);
	MaterialFloat Local139 = lerp(Local138,1.00000000,Local41);
	MaterialFloat Local140 = lerp(Local139,1.00000000,Local46);
	MaterialFloat Local141 = lerp(Material.PreshaderBuffer[31].y,Material.PreshaderBuffer[31].x,Local132.g);
	MaterialFloat Local142 = lerp(Local140,Local141,Local119);
	MaterialFloat Local143 = lerp(Local90.a,1.00000000,0.50000000);
	MaterialFloat Local144 = (Local143 * Material.PreshaderBuffer[31].z);
	MaterialFloat3 Local145 = (Local120 * ((MaterialFloat3)Material.PreshaderBuffer[31].w));
	MaterialFloat Local146 = PositiveClampedPow(Local124.r,Material.PreshaderBuffer[32].y);
	MaterialFloat Local147 = lerp(Local146,1.00000000,Local31);
	MaterialFloat Local148 = lerp(Local147,1.00000000,Local36);
	MaterialFloat Local149 = lerp(Local148,1.00000000,Local41);
	MaterialFloat Local150 = lerp(Local149,1.00000000,Local46);
	MaterialFloat Local151 = PositiveClampedPow(Local132.r,Material.PreshaderBuffer[32].z);
	MaterialFloat Local152 = lerp(Local150,Local151,Local119);

	PixelMaterialInputs.EmissiveColor = Local122;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local144;
	PixelMaterialInputs.BaseColor = Local120;
	PixelMaterialInputs.Metallic = Local135;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[30].y;
	PixelMaterialInputs.Roughness = Local142;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local75;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local145,Material.PreshaderBuffer[32].x);
	PixelMaterialInputs.AmbientOcclusion = Local152;
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