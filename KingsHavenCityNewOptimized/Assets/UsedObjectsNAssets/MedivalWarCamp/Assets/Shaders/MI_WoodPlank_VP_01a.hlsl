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
	float4 PreshaderBuffer[49];
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
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.500000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-0.500000,-0.500000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.500000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(-0.500000,-0.500000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(2.000000,0.043510,1.043510,-0.043510);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.500000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-0.500000,-0.500000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,55.688049,56.688049,-55.688049);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.895040,0.400000,1.039647,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.895040,0.104960,0.400000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.984375,0.984375,0.984375,1.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.984375,0.984375,0.984375,1.039647);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.984615,0.768000,1.304472,1.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.984615,0.015385,0.768000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(1.000000,1.000000,1.000000,1.304472);//(Unknown)
	Material.PreshaderBuffer[34] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(-0.280000,973.020691,973.020691,-973.020691);//(Unknown)
	Material.PreshaderBuffer[39] = float4(-0.001028,0.720000,0.280000,0.624000);//(Unknown)
	Material.PreshaderBuffer[40] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(1.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(0.000000,0.000000,0.000000,0.416000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(-0.416000,-0.416000,-0.416000,0.688000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(0.552000,1.416000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(-0.416000,-0.416000,-0.416000,0.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[47] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[48] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) * Material.PreshaderBuffer[2].zw);
	MaterialFloat2 Local2 = (DERIV_BASE_VALUE(Local1) + Material.PreshaderBuffer[3].zw);
	MaterialFloat2 Local3 = (Material.PreshaderBuffer[5].xy + DERIV_BASE_VALUE(Local2));
	MaterialFloat Local4 = dot(DERIV_BASE_VALUE(Local3),Material.PreshaderBuffer[7].xy);
	MaterialFloat Local5 = dot(DERIV_BASE_VALUE(Local3),Material.PreshaderBuffer[7].zw);
	MaterialFloat2 Local6 = MaterialFloat2(DERIV_BASE_VALUE(Local4),DERIV_BASE_VALUE(Local5));
	MaterialFloat2 Local7 = (Material.PreshaderBuffer[4].zw + DERIV_BASE_VALUE(Local6));
	MaterialFloat Local8 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 7);
	MaterialFloat4 Local9 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 7);
	MaterialFloat2 Local11 = (Local9.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[8].x));
	MaterialFloat2 Local12 = (((MaterialFloat2)0.00000000) + Local11);
	MaterialFloat Local13 = dot(Local12,MaterialFloat2(cos(0.00000000),0.00000000));
	MaterialFloat Local14 = dot(Local12,MaterialFloat2(sin(0.00000000),cos(0.00000000)));
	MaterialFloat2 Local15 = (((MaterialFloat2)0.00000000) + MaterialFloat2(Local13,Local14));
	MaterialFloat2 Local16 = (DERIV_BASE_VALUE(Local0) * Material.PreshaderBuffer[10].zw);
	MaterialFloat2 Local17 = (DERIV_BASE_VALUE(Local16) + Material.PreshaderBuffer[11].zw);
	MaterialFloat2 Local18 = (Material.PreshaderBuffer[13].xy + DERIV_BASE_VALUE(Local17));
	MaterialFloat Local19 = dot(DERIV_BASE_VALUE(Local18),Material.PreshaderBuffer[15].xy);
	MaterialFloat Local20 = dot(DERIV_BASE_VALUE(Local18),Material.PreshaderBuffer[15].zw);
	MaterialFloat2 Local21 = MaterialFloat2(DERIV_BASE_VALUE(Local19),DERIV_BASE_VALUE(Local20));
	MaterialFloat2 Local22 = (Material.PreshaderBuffer[12].zw + DERIV_BASE_VALUE(Local21));
	MaterialFloat Local23 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local22), 7);
	MaterialFloat4 Local24 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local22)));
	MaterialFloat Local25 = MaterialStoreTexSample(Parameters, Local24, 7);
	MaterialFloat2 Local26 = (Local24.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[16].x));
	MaterialFloat2 Local27 = (((MaterialFloat2)0.00000000) + Local26);
	MaterialFloat Local28 = dot(Local27,MaterialFloat2(cos(0.00000000),0.00000000));
	MaterialFloat Local29 = dot(Local27,MaterialFloat2(sin(0.00000000),cos(0.00000000)));
	MaterialFloat2 Local30 = (((MaterialFloat2)0.00000000) + MaterialFloat2(Local28,Local29));
	MaterialFloat Local31 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local22), 8);
	MaterialFloat4 Local32 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local22)));
	MaterialFloat Local33 = MaterialStoreTexSample(Parameters, Local32, 8);
	MaterialFloat Local34 = (1.00000000 - Local32.g);
	MaterialFloat Local35 = (Local34 - 1.00000000);
	MaterialFloat4 Local36 = Parameters.VertexColor;
	MaterialFloat Local37 = DERIV_BASE_VALUE(Local36).r;
	MaterialFloat Local38 = (DERIV_BASE_VALUE(Local37) * 2.00000000);
	MaterialFloat Local39 = (Local35 + DERIV_BASE_VALUE(Local38));
	MaterialFloat Local40 = saturate(Local39);
	MaterialFloat Local41 = lerp(Material.PreshaderBuffer[16].w,Material.PreshaderBuffer[16].z,Local40);
	MaterialFloat Local42 = saturate(Local41);
	MaterialFloat3 Local43 = lerp(MaterialFloat3(Local15,Local9.rgb.b).rgb,MaterialFloat3(Local30,Local24.rgb.b).rgb,Local42.r);
	MaterialFloat2 Local44 = (DERIV_BASE_VALUE(Local0) * Material.PreshaderBuffer[18].zw);
	MaterialFloat2 Local45 = (DERIV_BASE_VALUE(Local44) + Material.PreshaderBuffer[19].zw);
	MaterialFloat2 Local46 = (Material.PreshaderBuffer[21].xy + DERIV_BASE_VALUE(Local45));
	MaterialFloat Local47 = dot(DERIV_BASE_VALUE(Local46),Material.PreshaderBuffer[23].xy);
	MaterialFloat Local48 = dot(DERIV_BASE_VALUE(Local46),Material.PreshaderBuffer[23].zw);
	MaterialFloat2 Local49 = MaterialFloat2(DERIV_BASE_VALUE(Local47),DERIV_BASE_VALUE(Local48));
	MaterialFloat2 Local50 = (Material.PreshaderBuffer[20].zw + DERIV_BASE_VALUE(Local49));
	MaterialFloat Local51 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 7);
	MaterialFloat4 Local52 = UnpackNormalMap(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local50)));
	MaterialFloat Local53 = MaterialStoreTexSample(Parameters, Local52, 7);
	MaterialFloat2 Local54 = (Local52.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[24].x));
	MaterialFloat2 Local55 = (((MaterialFloat2)0.00000000) + Local54);
	MaterialFloat Local56 = dot(Local55,MaterialFloat2(cos(0.00000000),0.00000000));
	MaterialFloat Local57 = dot(Local55,MaterialFloat2(sin(0.00000000),cos(0.00000000)));
	MaterialFloat2 Local58 = (((MaterialFloat2)0.00000000) + MaterialFloat2(Local56,Local57));
	MaterialFloat Local59 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 8);
	MaterialFloat4 Local60 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local61 = MaterialStoreTexSample(Parameters, Local60, 8);
	MaterialFloat Local62 = (Local60.g - 1.00000000);
	MaterialFloat Local63 = DERIV_BASE_VALUE(Local36).g;
	MaterialFloat Local64 = (DERIV_BASE_VALUE(Local63) * 2.00000000);
	MaterialFloat Local65 = (Local62 + DERIV_BASE_VALUE(Local64));
	MaterialFloat Local66 = saturate(Local65);
	MaterialFloat Local67 = lerp(Material.PreshaderBuffer[24].w,Material.PreshaderBuffer[24].z,Local66);
	MaterialFloat Local68 = saturate(Local67);
	MaterialFloat3 Local69 = lerp(Local43,MaterialFloat3(Local58,Local52.rgb.b).rgb,Local68.r);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local69.rgb;


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
	MaterialFloat3 Local70 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000).rgb,Material.PreshaderBuffer[25].yzw,Material.PreshaderBuffer[25].x);
	MaterialFloat Local71 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 6);
	MaterialFloat4 Local72 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local7)));
	MaterialFloat Local73 = MaterialStoreTexSample(Parameters, Local72, 6);
	MaterialFloat Local74 = dot(Local72.rgb,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local75 = lerp(Local72.rgb,((MaterialFloat3)Local74),Material.PreshaderBuffer[27].y);
	MaterialFloat3 Local76 = (Local75 * ((MaterialFloat3)Material.PreshaderBuffer[27].z));
	MaterialFloat3 Local77 = (Local76 * Material.PreshaderBuffer[29].xyz);
	MaterialFloat3 Local78 = PositiveClampedPow(Local77,((MaterialFloat3)Material.PreshaderBuffer[29].w));
	MaterialFloat Local79 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local22), 6);
	MaterialFloat4 Local80 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local22)));
	MaterialFloat Local81 = MaterialStoreTexSample(Parameters, Local80, 6);
	MaterialFloat Local82 = dot(Local80.rgb,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local83 = lerp(Local80.rgb,((MaterialFloat3)Local82),Material.PreshaderBuffer[31].y);
	MaterialFloat3 Local84 = (Local83 * ((MaterialFloat3)Material.PreshaderBuffer[31].z));
	MaterialFloat3 Local85 = (Local84 * Material.PreshaderBuffer[33].xyz);
	MaterialFloat3 Local86 = PositiveClampedPow(Local85,((MaterialFloat3)Material.PreshaderBuffer[33].w));
	MaterialFloat3 Local87 = lerp(Local78.rgb,Local86.rgb,Local42.r);
	MaterialFloat Local88 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 6);
	MaterialFloat4 Local89 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local50)));
	MaterialFloat Local90 = MaterialStoreTexSample(Parameters, Local89, 6);
	MaterialFloat Local91 = dot(Local89.rgb,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local92 = lerp(Local89.rgb,((MaterialFloat3)Local91),Material.PreshaderBuffer[35].y);
	MaterialFloat3 Local93 = (Local92 * ((MaterialFloat3)Material.PreshaderBuffer[35].z));
	MaterialFloat3 Local94 = (Local93 * Material.PreshaderBuffer[37].xyz);
	MaterialFloat3 Local95 = PositiveClampedPow(Local94,((MaterialFloat3)Material.PreshaderBuffer[37].w));
	MaterialFloat3 Local96 = lerp(Local87,Local95.rgb,Local68.r);
	MaterialFloat3 Local97 = (((MaterialFloat3)1.00000000) - Local96.rgb);
	MaterialFloat3 Local98 = (Local97 * ((MaterialFloat3)2.00000000));
	FLWCVector3 Local99 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local100 = LWCMultiply(DERIV_BASE_VALUE(Local99), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[39].x)));
	FLWCVector2 Local101 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local100)), LWCGetZ(DERIV_BASE_VALUE(Local100)));
	MaterialFloat2 Local102 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local101), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, Local102, 1);
	MaterialFloat4 Local104 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local102));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 1);
	FLWCVector2 Local106 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local100)), LWCGetZ(DERIV_BASE_VALUE(Local100)));
	MaterialFloat2 Local107 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local106), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local108 = MaterialStoreTexCoordScale(Parameters, Local107, 1);
	MaterialFloat4 Local109 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local107));
	MaterialFloat Local110 = MaterialStoreTexSample(Parameters, Local109, 1);
	MaterialFloat Local111 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local112 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local111);
	MaterialFloat Local113 = saturate(Local112);
	MaterialFloat3 Local114 = lerp(Local104.rgb,Local109.rgb,Local113.r.r);
	FLWCVector2 Local115 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local100)), LWCGetY(DERIV_BASE_VALUE(Local100)));
	MaterialFloat2 Local116 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local115), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local117 = MaterialStoreTexCoordScale(Parameters, Local116, 1);
	MaterialFloat4 Local118 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local116));
	MaterialFloat Local119 = MaterialStoreTexSample(Parameters, Local118, 1);
	MaterialFloat Local120 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local121 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local120);
	MaterialFloat Local122 = saturate(Local121);
	MaterialFloat3 Local123 = lerp(Local114,Local118.rgb,Local122.r.r);
	MaterialFloat Local124 = lerp(Material.PreshaderBuffer[39].z,Material.PreshaderBuffer[39].y,Local123.x);
	MaterialFloat Local125 = saturate(Local124);
	MaterialFloat Local126 = PositiveClampedPow(Local125.r,Material.PreshaderBuffer[39].w);
	MaterialFloat Local127 = (1.00000000 - Local126);
	MaterialFloat3 Local128 = (Local98 * ((MaterialFloat3)Local127));
	MaterialFloat3 Local129 = (((MaterialFloat3)1.00000000) - Local128);
	MaterialFloat3 Local130 = (Local96.rgb * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local131 = (Local130 * ((MaterialFloat3)Local126));
	MaterialFloat Local132 = select((Local96.rgb.r >= 0.50000000), Local129.r, Local131.r);
	MaterialFloat Local133 = select((Local96.rgb.g >= 0.50000000), Local129.g, Local131.g);
	MaterialFloat Local134 = select((Local96.rgb.b >= 0.50000000), Local129.b, Local131.b);
	MaterialFloat Local135 = lerp(Material.PreshaderBuffer[41].y,Material.PreshaderBuffer[41].x,Local60.r.r);
	MaterialFloat3 Local136 = lerp(Material.PreshaderBuffer[42].xyz,((MaterialFloat3)Material.PreshaderBuffer[41].z),Local135);
	MaterialFloat3 Local137 = saturate(Local136);
	MaterialFloat Local138 = lerp(Material.PreshaderBuffer[44].x,Material.PreshaderBuffer[43].w,Local32.r.r);
	MaterialFloat3 Local139 = lerp(Material.PreshaderBuffer[45].xyz,((MaterialFloat3)Material.PreshaderBuffer[44].y),Local138);
	MaterialFloat3 Local140 = saturate(Local139);
	MaterialFloat3 Local141 = lerp(MaterialFloat3(MaterialFloat2(Local137.r,Local60.g),Local60.b.r),MaterialFloat3(MaterialFloat2(Local140.r,Local32.g),Local32.b.r),Local42.r);
	MaterialFloat Local142 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 8);
	MaterialFloat4 Local143 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local50)));
	MaterialFloat Local144 = MaterialStoreTexSample(Parameters, Local143, 8);
	MaterialFloat Local145 = lerp(Material.PreshaderBuffer[47].x,Material.PreshaderBuffer[46].w,Local143.r.r);
	MaterialFloat3 Local146 = lerp(Material.PreshaderBuffer[48].xyz,((MaterialFloat3)Material.PreshaderBuffer[47].y),Local145);
	MaterialFloat3 Local147 = saturate(Local146);
	MaterialFloat3 Local148 = lerp(Local141,MaterialFloat3(MaterialFloat2(Local147.r,Local143.g),Local143.b.r),Local68.r);

	PixelMaterialInputs.EmissiveColor = Local70;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = MaterialFloat3(MaterialFloat2(Local132,Local133),Local134);
	PixelMaterialInputs.Metallic = 0.00000000.r;
	PixelMaterialInputs.Specular = 0.50000000.r;
	PixelMaterialInputs.Roughness = Local148.r.r;
	PixelMaterialInputs.Anisotropy = 0.00000000.r;
	PixelMaterialInputs.Normal = Local69.rgb;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000).rgb;
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local148.b.r;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000.r;
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