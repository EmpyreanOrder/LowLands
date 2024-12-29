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
	float4 PreshaderBuffer[38];
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
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,1.500000,-1.100000,0.560000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(-30.000000,0.260000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.600000,2.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(2.000000,2.000000,0.100000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.600000,-0.600000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,1.000000,0.520000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.810000,0.190000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,1.000000,1.000000,0.900000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.550000,-0.550000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.620000,0.416227,0.260400,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.280000,0.620000,0.416227,0.260400);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.541667,0.435873,0.330078,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.541667,0.435873,0.330078,0.100000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.340000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,0.854152,0.698812,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(1.000000,0.854152,0.698812,0.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(0.000000,0.000000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(0.500000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(0.000000,1.200000,0.910000,1.050000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(0.200000,0.920000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat Local12 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 5);
	MaterialFloat4 Local13 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 5);
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
	MaterialFloat Local25 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 5);
	MaterialFloat4 Local26 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local27 = MaterialStoreTexSample(Parameters, Local26, 5);
	MaterialFloat2 Local28 = (Local26.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[6].y));
	MaterialFloat Local29 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[8].x);
	MaterialFloat Local30 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[8].y);
	MaterialFloat2 Local31 = MaterialFloat2(DERIV_BASE_VALUE(Local29),DERIV_BASE_VALUE(Local30));
	MaterialFloat2 Local32 = (((MaterialFloat2)Material.PreshaderBuffer[8].z) * DERIV_BASE_VALUE(Local31));
	MaterialFloat Local33 = DERIV_BASE_VALUE(Local32).r;
	MaterialFloat Local34 = (DERIV_BASE_VALUE(Local33) + Material.PreshaderBuffer[8].w);
	MaterialFloat Local35 = DERIV_BASE_VALUE(Local32).g;
	MaterialFloat Local36 = (DERIV_BASE_VALUE(Local35) + Material.PreshaderBuffer[9].x);
	MaterialFloat2 Local37 = MaterialFloat2(DERIV_BASE_VALUE(Local34),DERIV_BASE_VALUE(Local36));
	MaterialFloat Local38 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 5);
	MaterialFloat4 Local39 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local40 = MaterialStoreTexSample(Parameters, Local39, 5);
	MaterialFloat2 Local41 = (Local39.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[9].y));
	MaterialFloat2 Local42 = (Local41 * ((MaterialFloat2)Material.PreshaderBuffer[9].z));
	MaterialFloat2 Local43 = Parameters.TexCoords[1].xy;
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local43), 1);
	MaterialFloat4 Local45 = Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local43));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 1);
	MaterialFloat Local47 = (Material.PreshaderBuffer[9].w * Local45.g);
	MaterialFloat2 Local48 = lerp(Local41,Local42,Local47);
	MaterialFloat2 Local49 = (Local41 * ((MaterialFloat2)Material.PreshaderBuffer[10].x));
	MaterialFloat Local50 = (Material.PreshaderBuffer[10].y * Local45.a);
	MaterialFloat2 Local51 = lerp(Local48,Local49,Local50);
	MaterialFloat Local52 = (MaterialFloat3(Local51,Local39.rgb.b).b + 1.00000000);
	MaterialFloat2 Local53 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[10].z));
	MaterialFloat Local54 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local53), 5);
	MaterialFloat4 Local55 = UnpackNormalMap(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local53)));
	MaterialFloat Local56 = MaterialStoreTexSample(Parameters, Local55, 5);
	MaterialFloat2 Local57 = (Local55.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[10].w));
	MaterialFloat2 Local58 = (MaterialFloat3(Local57,Local55.rgb.b).rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local59 = dot(MaterialFloat3(MaterialFloat3(Local51,Local39.rgb.b).rg,Local52),MaterialFloat3(Local58,MaterialFloat3(Local57,Local55.rgb.b).b));
	MaterialFloat3 Local60 = (MaterialFloat3(MaterialFloat3(Local51,Local39.rgb.b).rg,Local52) * ((MaterialFloat3)Local59));
	MaterialFloat3 Local61 = (((MaterialFloat3)Local52) * MaterialFloat3(Local58,MaterialFloat3(Local57,Local55.rgb.b).b));
	MaterialFloat3 Local62 = (Local60 - Local61);
	MaterialFloat Local63 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local64 = Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias);
	MaterialFloat Local65 = MaterialStoreTexSample(Parameters, Local64, 0);
	MaterialFloat Local66 = (Local64.rgb.r - 1.00000000);
	MaterialFloat4 Local67 = Parameters.VertexColor;
	MaterialFloat Local68 = DERIV_BASE_VALUE(Local67).r;
	MaterialFloat2 Local69 = (Material.PreshaderBuffer[12].xy * DERIV_BASE_VALUE(Local0));
	MaterialFloat Local70 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local69), 0);
	MaterialFloat4 Local71 = Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local69),View.MaterialTextureMipBias);
	MaterialFloat Local72 = MaterialStoreTexSample(Parameters, Local71, 0);
	MaterialFloat Local73 = max(Local71.r,Material.PreshaderBuffer[12].z);
	MaterialFloat Local74 = min(Local73,Material.PreshaderBuffer[12].w);
	MaterialFloat Local75 = (DERIV_BASE_VALUE(Local68) + Local74);
	MaterialFloat Local76 = (Local75 * DERIV_BASE_VALUE(Local68));
	MaterialFloat Local77 = lerp(Material.PreshaderBuffer[13].y,Material.PreshaderBuffer[13].x,Local76);
	MaterialFloat Local78 = saturate(Local77);
	MaterialFloat Local79 = (Local78.r * 2.00000000);
	MaterialFloat Local80 = (Local66 + Local79);
	MaterialFloat Local81 = saturate(Local80);
	MaterialFloat Local82 = lerp(Material.PreshaderBuffer[13].w,Material.PreshaderBuffer[13].z,Local81);
	MaterialFloat Local83 = saturate(Local82);
	MaterialFloat3 Local84 = lerp(MaterialFloat3(Local28,1.00000000),Local62,Local83.r.r);
	MaterialFloat Local85 = DERIV_BASE_VALUE(Local67).b;
	MaterialFloat Local86 = (DERIV_BASE_VALUE(Local85) + Local74);
	MaterialFloat Local87 = (Local86 * DERIV_BASE_VALUE(Local85));
	MaterialFloat Local88 = lerp(Material.PreshaderBuffer[13].y,Material.PreshaderBuffer[13].x,Local87);
	MaterialFloat Local89 = saturate(Local88);
	MaterialFloat Local90 = (Local89.r * 2.00000000);
	MaterialFloat Local91 = (Local66 + Local90);
	MaterialFloat Local92 = saturate(Local91);
	MaterialFloat Local93 = lerp(Material.PreshaderBuffer[13].w,Material.PreshaderBuffer[13].z,Local92);
	MaterialFloat Local94 = saturate(Local93);
	MaterialFloat3 Local95 = lerp(MaterialFloat3(Local15,1.00000000),Local84,Local94.r.r);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local95.rgb;


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
	MaterialFloat3 Local96 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[14].yzw,Material.PreshaderBuffer[14].x);
	MaterialFloat Local97 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 3);
	MaterialFloat4 Local98 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local99 = MaterialStoreTexSample(Parameters, Local98, 3);
	MaterialFloat3 Local100 = (Local98.rgb * Material.PreshaderBuffer[17].xyz);
	MaterialFloat3 Local101 = (Local100 * ((MaterialFloat3)Material.PreshaderBuffer[17].w));
	MaterialFloat Local102 = dot(Local101,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local103 = lerp(Local101,((MaterialFloat3)Local102),Material.PreshaderBuffer[18].y);
	MaterialFloat Local104 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 3);
	MaterialFloat4 Local105 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local106 = MaterialStoreTexSample(Parameters, Local105, 3);
	MaterialFloat3 Local107 = (Local105.rgb * Material.PreshaderBuffer[21].xyz);
	MaterialFloat3 Local108 = (Local107 * ((MaterialFloat3)Material.PreshaderBuffer[21].w));
	MaterialFloat Local109 = dot(Local108,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local110 = lerp(Local108,((MaterialFloat3)Local109),Material.PreshaderBuffer[22].y);
	MaterialFloat Local111 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 3);
	MaterialFloat4 Local112 = ProcessMaterialVirtualColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37)));
	MaterialFloat Local113 = MaterialStoreTexSample(Parameters, Local112, 3);
	MaterialFloat3 Local114 = (Local112.rgb * Material.PreshaderBuffer[25].xyz);
	MaterialFloat3 Local115 = (Local114 * ((MaterialFloat3)Material.PreshaderBuffer[25].w));
	MaterialFloat Local116 = dot(Local115,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local117 = lerp(Local115,((MaterialFloat3)Local116),Material.PreshaderBuffer[26].y);
	MaterialFloat Local118 = (Material.PreshaderBuffer[28].x * Local45.r);
	MaterialFloat3 Local119 = lerp(Local117,Material.PreshaderBuffer[28].yzw,Local118);
	MaterialFloat3 Local120 = lerp(Local119,Material.PreshaderBuffer[30].xyz,Local47);
	MaterialFloat3 Local121 = (Local120 - ((MaterialFloat3)Material.PreshaderBuffer[30].w));
	MaterialFloat Local122 = (Material.PreshaderBuffer[31].x * Local45.b);
	MaterialFloat3 Local123 = lerp(Local120,Local121,Local122);
	MaterialFloat3 Local124 = lerp(Local123,Material.PreshaderBuffer[33].xyz,Local50);
	MaterialFloat3 Local125 = lerp(Local110,Local124,Local83.r.r);
	MaterialFloat3 Local126 = lerp(Local103,Local125,Local94.r.r);
	MaterialFloat Local127 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 4);
	MaterialFloat4 Local128 = Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11));
	MaterialFloat Local129 = MaterialStoreTexSample(Parameters, Local128, 4);
	MaterialFloat Local130 = (Local128.rgb.b * Material.PreshaderBuffer[33].w);
	MaterialFloat Local131 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 4);
	MaterialFloat4 Local132 = Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24));
	MaterialFloat Local133 = MaterialStoreTexSample(Parameters, Local132, 4);
	MaterialFloat Local134 = (Local132.rgb.b * Material.PreshaderBuffer[34].x);
	MaterialFloat Local135 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local37), 4);
	MaterialFloat4 Local136 = Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local37));
	MaterialFloat Local137 = MaterialStoreTexSample(Parameters, Local136, 4);
	MaterialFloat Local138 = (Local136.rgb.b * Material.PreshaderBuffer[34].y);
	MaterialFloat Local139 = lerp(Local134,Local138,Local83.r.r);
	MaterialFloat Local140 = lerp(Local130,Local139,Local94.r.r);
	MaterialFloat Local141 = lerp(Material.PreshaderBuffer[34].w,Material.PreshaderBuffer[34].z,Local83.r.r);
	MaterialFloat Local142 = lerp(Material.PreshaderBuffer[35].x,Local141,Local94.r.r);
	MaterialFloat Local143 = (Local128.rgb.g * Material.PreshaderBuffer[35].y);
	MaterialFloat Local144 = (Local132.rgb.g * Material.PreshaderBuffer[35].z);
	MaterialFloat Local145 = lerp(Material.PreshaderBuffer[36].x,Material.PreshaderBuffer[35].w,Local136.rgb.g);
	MaterialFloat Local146 = (Local145 * Material.PreshaderBuffer[36].y);
	MaterialFloat Local147 = lerp(Local146,Material.PreshaderBuffer[36].z,Local45.r);
	MaterialFloat Local148 = lerp(Local147,Material.PreshaderBuffer[36].w,Local45.g);
	MaterialFloat Local149 = lerp(Local148,Material.PreshaderBuffer[37].x,Local45.b);
	MaterialFloat Local150 = lerp(Local149,Material.PreshaderBuffer[37].y,Local45.a);
	MaterialFloat Local151 = lerp(Local144,Local150,Local83.r.r);
	MaterialFloat Local152 = lerp(Local143,Local151,Local94.r.r);

	PixelMaterialInputs.EmissiveColor = Local96;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local126.rgb;
	PixelMaterialInputs.Metallic = Local140.r;
	PixelMaterialInputs.Specular = Local142.r;
	PixelMaterialInputs.Roughness = Local152.r;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local95.rgb;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000.r;
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