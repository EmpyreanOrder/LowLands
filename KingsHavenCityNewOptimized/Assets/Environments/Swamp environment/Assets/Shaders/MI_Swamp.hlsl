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
	float4 PreshaderBuffer[20];
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
	Material.PreshaderBuffer[0] = float4(0.100000,0.010000,-0.100000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(5.000000,3.000000,0.033333,2.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.100000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.750000,-0.010000,-0.150000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,0.750000,0.010000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.250000,-0.800000,-1.000000,0.750000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(-0.010000,0.350000,-1.000000,-2.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.750000,2.000000,0.010000,-0.100000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,0.010000,-0.300000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(2.000000,2.000000,0.500000,-0.010000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(-0.400000,1.000000,1.000000,0.800000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.050000,-0.010000,-0.120000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(-2.000000,2.000000,1.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.196793,0.369792,0.135294,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.102242,0.063010,0.033105,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.255000,0.050000,0.750000,0.010000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.050000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.003437,0.002852,0.001385,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.021679,0.022274,0.030000,1.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat Local0 = (View.GameTime * Material.PreshaderBuffer[0].x);
	MaterialFloat Local1 = (Local0 * Material.PreshaderBuffer[0].y);
	MaterialFloat Local2 = (Local0 * Material.PreshaderBuffer[0].z);
	MaterialFloat2 Local3 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local4 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[1].xy);
	FWSVector3 Local5 = GetWorldPosition(Parameters);
	MaterialFloat3 Local6 = GetDistanceFieldGradientGlobal(DERIV_BASE_VALUE(Local5));
	MaterialFloat3 Local7 = normalize(Local6);
	MaterialFloat3 Local8 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Local7);
	MaterialFloat2 Local9 = (Local8.rg * MaterialFloat2(-1.00000000,1.00000000).rg);
	MaterialFloat Local10 = GetDistanceToNearestSurfaceGlobal(DERIV_BASE_VALUE(Local5));
	MaterialFloat Local11 = (Local10 * Material.PreshaderBuffer[1].z);
	MaterialFloat Local12 = saturate(Local11);
	MaterialFloat Local13 = (1.00000000 - Local12);
	MaterialFloat Local14 = PositiveClampedPow(Local13,Material.PreshaderBuffer[1].w);
	MaterialFloat2 Local15 = (Local9 * ((MaterialFloat2)Local14));
	MaterialFloat2 Local16 = (Local15 * Material.PreshaderBuffer[2].xy);
	MaterialFloat2 Local17 = (DERIV_BASE_VALUE(Local4) + Local16);
	MaterialFloat2 Local18 = (Local17 * Material.PreshaderBuffer[2].zw);
	MaterialFloat2 Local19 = (MaterialFloat2(Local1,Local2) + Local18);
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, Local19, 0);
	MaterialFloat4 Local21 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local19));
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 0);
	MaterialFloat3 Local23 = lerp(Local21.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[3].x);
	MaterialFloat Local24 = (Local23.b + 1.00000000);
	MaterialFloat Local25 = (Local0 * Material.PreshaderBuffer[3].y);
	MaterialFloat Local26 = (Local0 * Material.PreshaderBuffer[3].z);
	MaterialFloat2 Local27 = (Local17 * Material.PreshaderBuffer[4].xy);
	MaterialFloat2 Local28 = (MaterialFloat2(Local25,Local26) + Local27);
	MaterialFloat Local29 = MaterialStoreTexCoordScale(Parameters, Local28, 0);
	MaterialFloat4 Local30 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local28));
	MaterialFloat Local31 = MaterialStoreTexSample(Parameters, Local30, 0);
	MaterialFloat3 Local32 = lerp(Local30.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[4].z);
	MaterialFloat2 Local33 = (Local32.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local34 = dot(MaterialFloat3(Local23.rg,Local24),MaterialFloat3(Local33,Local32.b));
	MaterialFloat3 Local35 = (MaterialFloat3(Local23.rg,Local24) * ((MaterialFloat3)Local34));
	MaterialFloat3 Local36 = (((MaterialFloat3)Local24) * MaterialFloat3(Local33,Local32.b));
	MaterialFloat3 Local37 = (Local35 - Local36);
	MaterialFloat Local38 = (Local37.b + 1.00000000);
	MaterialFloat Local39 = (Local0 * Material.PreshaderBuffer[4].w);
	MaterialFloat Local40 = (Local0 * Material.PreshaderBuffer[5].x);
	MaterialFloat2 Local41 = (Local17 * Material.PreshaderBuffer[5].yz);
	MaterialFloat2 Local42 = (MaterialFloat2(Local39,Local40) + Local41);
	MaterialFloat Local43 = MaterialStoreTexCoordScale(Parameters, Local42, 0);
	MaterialFloat4 Local44 = UnpackNormalMap(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),Local42));
	MaterialFloat Local45 = MaterialStoreTexSample(Parameters, Local44, 0);
	MaterialFloat3 Local46 = lerp(Local44.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[5].w);
	MaterialFloat Local47 = (Local46.b + 1.00000000);
	MaterialFloat Local48 = (Local0 * Material.PreshaderBuffer[6].x);
	MaterialFloat Local49 = (Local0 * Material.PreshaderBuffer[6].y);
	MaterialFloat2 Local50 = (Local17 * Material.PreshaderBuffer[6].zw);
	MaterialFloat2 Local51 = (MaterialFloat2(Local48,Local49) + Local50);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, Local51, 0);
	MaterialFloat4 Local53 = UnpackNormalMap(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local51));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 0);
	MaterialFloat3 Local55 = lerp(Local53.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[7].x);
	MaterialFloat2 Local56 = (Local55.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local57 = dot(MaterialFloat3(Local46.rg,Local47),MaterialFloat3(Local56,Local55.b));
	MaterialFloat3 Local58 = (MaterialFloat3(Local46.rg,Local47) * ((MaterialFloat3)Local57));
	MaterialFloat3 Local59 = (((MaterialFloat3)Local47) * MaterialFloat3(Local56,Local55.b));
	MaterialFloat3 Local60 = (Local58 - Local59);
	MaterialFloat2 Local61 = (Local60.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local62 = dot(MaterialFloat3(Local37.rg,Local38),MaterialFloat3(Local61,Local60.b));
	MaterialFloat3 Local63 = (MaterialFloat3(Local37.rg,Local38) * ((MaterialFloat3)Local62));
	MaterialFloat3 Local64 = (((MaterialFloat3)Local38) * MaterialFloat3(Local61,Local60.b));
	MaterialFloat3 Local65 = (Local63 - Local64);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local65;


#if TEMPLATE_USES_SUBSTRATE
	Parameters.SubstratePixelFootprint = SubstrateGetPixelFootprint(Parameters.WorldPosition_CamRelative, GetRoughnessFromNormalCurvature(Parameters));
	Parameters.SharedLocalBases = SubstrateInitialiseSharedLocalBases();
	Parameters.SubstrateTree = GetInitialisedSubstrateTree();
#if SUBSTRATE_USE_FULLYSIMPLIFIED_MATERIAL == 1
	Parameters.SharedLocalBasesFullySimplified = SubstrateInitialiseSharedLocalBases();
	Parameters.SubstrateTreeFullySimplified = GetInitialisedSubstrateTree();
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

#if MATERIAL_TANGENTSPACENORMAL || TWO_SIDED_WORLD_SPACE_SINGLELAYERWATER_NORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat Local66 = (Local0 * Material.PreshaderBuffer[7].y);
	MaterialFloat Local67 = (Local66 * Material.PreshaderBuffer[7].z);
	MaterialFloat Local68 = (Local66 * Material.PreshaderBuffer[7].w);
	MaterialFloat2 Local69 = (Local17 * Material.PreshaderBuffer[8].xy);
	MaterialFloat2 Local70 = (MaterialFloat2(Local67,Local68) + Local69);
	MaterialFloat Local71 = (Local0 * Material.PreshaderBuffer[8].z);
	MaterialFloat Local72 = (Local0 * Material.PreshaderBuffer[8].w);
	MaterialFloat2 Local73 = (Local17 * Material.PreshaderBuffer[9].xy);
	MaterialFloat2 Local74 = (MaterialFloat2(Local71,Local72) + Local73);
	MaterialFloat Local75 = MaterialStoreTexCoordScale(Parameters, Local74, 1);
	MaterialFloat4 Local76 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),Local74));
	MaterialFloat Local77 = MaterialStoreTexSample(Parameters, Local76, 1);
	MaterialFloat3 Local78 = lerp(Local76.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[9].z);
	MaterialFloat Local79 = (Local78.b + 1.00000000);
	MaterialFloat Local80 = (Local0 * Material.PreshaderBuffer[9].w);
	MaterialFloat Local81 = (Local0 * Material.PreshaderBuffer[10].x);
	MaterialFloat2 Local82 = (Local17 * Material.PreshaderBuffer[10].yz);
	MaterialFloat2 Local83 = (MaterialFloat2(Local80,Local81) + Local82);
	MaterialFloat Local84 = MaterialStoreTexCoordScale(Parameters, Local83, 1);
	MaterialFloat4 Local85 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local83));
	MaterialFloat Local86 = MaterialStoreTexSample(Parameters, Local85, 1);
	MaterialFloat3 Local87 = lerp(Local85.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[10].w);
	MaterialFloat2 Local88 = (Local87.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local89 = dot(MaterialFloat3(Local78.rg,Local79),MaterialFloat3(Local88,Local87.b));
	MaterialFloat3 Local90 = (MaterialFloat3(Local78.rg,Local79) * ((MaterialFloat3)Local89));
	MaterialFloat3 Local91 = (((MaterialFloat3)Local79) * MaterialFloat3(Local88,Local87.b));
	MaterialFloat3 Local92 = (Local90 - Local91);
	MaterialFloat2 Local93 = (Local92.rg * ((MaterialFloat2)Material.PreshaderBuffer[11].x));
	MaterialFloat2 Local94 = (Local70 + Local93);
	MaterialFloat Local95 = MaterialStoreTexCoordScale(Parameters, Local94, 2);
	MaterialFloat4 Local96 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local94));
	MaterialFloat Local97 = MaterialStoreTexSample(Parameters, Local96, 2);
	MaterialFloat Local98 = (Local66 * Material.PreshaderBuffer[11].y);
	MaterialFloat Local99 = (Local66 * Material.PreshaderBuffer[11].z);
	MaterialFloat2 Local100 = (Local17 * Material.PreshaderBuffer[12].xy);
	MaterialFloat2 Local101 = (MaterialFloat2(Local98,Local99) + Local100);
	MaterialFloat2 Local102 = (Local101 + Local93);
	MaterialFloat Local103 = MaterialStoreTexCoordScale(Parameters, Local102, 2);
	MaterialFloat4 Local104 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local102));
	MaterialFloat Local105 = MaterialStoreTexSample(Parameters, Local104, 2);
	MaterialFloat3 Local106 = (Local96.rgb + Local104.rgb);
	MaterialFloat3 Local107 = (Local106 / ((MaterialFloat3)2.00000000));
	MaterialFloat Local108 = dot(Local107,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local109 = lerp(Local107,((MaterialFloat3)Local108),Material.PreshaderBuffer[12].z);
	MaterialFloat3 Local110 = PositiveClampedPow(Local109,((MaterialFloat3)Material.PreshaderBuffer[12].w));
	MaterialFloat4 Local111 = Parameters.VertexColor;
	MaterialFloat Local112 = DERIV_BASE_VALUE(Local111).r;
	MaterialFloat Local113 = (Local14 + DERIV_BASE_VALUE(Local112));
	MaterialFloat Local114 = DERIV_BASE_VALUE(Local111).g;
	MaterialFloat Local115 = (Local113 - DERIV_BASE_VALUE(Local114));
	MaterialFloat Local116 = saturate(Local115);
	MaterialFloat3 Local117 = (Local110 * ((MaterialFloat3)Local116));
	MaterialFloat3 Local118 = (Local117 * Material.PreshaderBuffer[13].xyz);
	MaterialFloat3 Local119 = (Local118 + Material.PreshaderBuffer[14].xyz);
	MaterialFloat3 Local120 = (Local119 * ((MaterialFloat3)Material.PreshaderBuffer[14].w));
	MaterialFloat3 Local121 = lerp(Local120,Material.PreshaderBuffer[15].yzw,Material.PreshaderBuffer[15].x);
	MaterialFloat Local122 = (Local117.r * Material.PreshaderBuffer[16].z);
	MaterialFloat Local123 = (Local122 + Material.PreshaderBuffer[16].w);

	PixelMaterialInputs.EmissiveColor = Local121;
	PixelMaterialInputs.Opacity = Local123;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local119;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[16].x;
	PixelMaterialInputs.Roughness = Material.PreshaderBuffer[16].y;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local65;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat3(MaterialFloat2(Material.PreshaderBuffer[17].x,0.0f),Material.PreshaderBuffer[17].y);
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 10;
	PixelMaterialInputs.FrontMaterial = GetInitialisedSubstrateData();
	PixelMaterialInputs.SurfaceThickness = 0.01000000;
	PixelMaterialInputs.Displacement = 0.50000000;


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