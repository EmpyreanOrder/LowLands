#define NUM_TEX_COORD_INTERPOLATORS 3
#define NUM_MATERIAL_TEXCOORDS_VERTEX 3
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
	float4 PreshaderBuffer[12];
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
	Material.PreshaderBuffer[1] = float4(400.000000,400.000000,400.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(400.000000,400.000000,400.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(400.000000,400.000000,400.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(-400.000000,-400.000000,-400.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-0.002500,-0.002500,-0.002500,-1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.967708,0.967708,0.967708,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.967708,0.032292,0.967708,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.371875,0.333767,0.315609,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.371875,0.333767,0.315609,0.967708);//(Unknown)
	Material.PreshaderBuffer[11] = float4(-0.456000,1.000000,0.000000,0.000000);//(Unknown)
}
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat3 Local0 = normalize(Parameters.TangentToWorld[2]);
	MaterialFloat3 Local1 = cross(Local0,normalize(MaterialFloat3(0.00000000,0.00000000,1.00000000)));
	MaterialFloat Local2 = dot(Local1,Local1);
	MaterialFloat3 Local3 = normalize(Local1);
	MaterialFloat4 Local4 = select((abs(Local2 - 0.00000100) > 0.00001000), select((Local2 >= 0.00000100), MaterialFloat4(Local3,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	FLWCVector3 Local5 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local6 = LWCMultiply(DERIV_BASE_VALUE(Local5), LWCPromote(Material.PreshaderBuffer[5].xyz));
	FLWCVector2 Local7 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local6)), LWCGetZ(DERIV_BASE_VALUE(Local6)));
	MaterialFloat2 Local8 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local7), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local9 = MaterialStoreTexCoordScale(Parameters, Local8, 1);
	MaterialFloat4 Local10 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local11 = MaterialStoreTexSample(Parameters, Local10, 1);
	MaterialFloat Local12 = dot(Parameters.TangentToWorld[2],MaterialFloat3(0.00000000,1.00000000,0.00000000));
	MaterialFloat Local13 = select((Local12 >= 0.00000000), -1.00000000, 1.00000000);
	MaterialFloat3 Local14 = (Local10.rgb * MaterialFloat3(MaterialFloat2(Local13,-1.00000000),1.00000000));
	FLWCVector2 Local15 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local6)), LWCGetZ(DERIV_BASE_VALUE(Local6)));
	MaterialFloat2 Local16 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local15), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local17 = MaterialStoreTexCoordScale(Parameters, Local16, 1);
	MaterialFloat4 Local18 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local16));
	MaterialFloat Local19 = MaterialStoreTexSample(Parameters, Local18, 1);
	MaterialFloat Local20 = dot(Parameters.TangentToWorld[2],MaterialFloat3(1.00000000,0.00000000,0.00000000));
	MaterialFloat Local21 = select((Local20 >= 0.00000000), 1.00000000, -1.00000000);
	MaterialFloat3 Local22 = (Local18.rgb * MaterialFloat3(MaterialFloat2(Local21,-1.00000000),1.00000000));
	MaterialFloat3 Local23 = mul(MaterialFloat3(0.00000000,0.00000000,1.00000000), Parameters.TangentToWorld);
	MaterialFloat Local24 = abs(Local23.r);
	MaterialFloat Local25 = lerp((0.00000000 - 0.00000000),(0.00000000 + 1.00000000),DERIV_BASE_VALUE(Local24));
	MaterialFloat Local26 = saturate(DERIV_BASE_VALUE(Local25));
	MaterialFloat Local27 = DERIV_BASE_VALUE(Local26).r;
	MaterialFloat3 Local28 = lerp(Local14,Local22,DERIV_BASE_VALUE(Local27));
	MaterialFloat3 Local29 = (Local4.rgb * ((MaterialFloat3)Local28.r));
	MaterialFloat3 Local30 = cross(Local1,Local0);
	MaterialFloat Local31 = dot(Local30,Local30);
	MaterialFloat3 Local32 = normalize(Local30);
	MaterialFloat4 Local33 = select((abs(Local31 - 0.00000100) > 0.00001000), select((Local31 >= 0.00000100), MaterialFloat4(Local32,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	MaterialFloat3 Local34 = (Local33.rgb * ((MaterialFloat3)Local28.g));
	MaterialFloat3 Local35 = (Local29 + Local34);
	MaterialFloat3 Local36 = (Local0 * ((MaterialFloat3)Local28.b));
	MaterialFloat3 Local37 = (Local36 + MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local38 = (Local35 + Local37);
	MaterialFloat3 Local39 = cross(Local0,normalize(MaterialFloat3(0.00000000,1.00000000,0.00000000)));
	MaterialFloat Local40 = dot(Local39,Local39);
	MaterialFloat3 Local41 = normalize(Local39);
	MaterialFloat4 Local42 = select((abs(Local40 - 0.00000100) > 0.00001000), select((Local40 >= 0.00000100), MaterialFloat4(Local41,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	FLWCVector2 Local43 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local6)), LWCGetY(DERIV_BASE_VALUE(Local6)));
	MaterialFloat2 Local44 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local43), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local45 = MaterialStoreTexCoordScale(Parameters, Local44, 1);
	MaterialFloat4 Local46 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),Local44));
	MaterialFloat Local47 = MaterialStoreTexSample(Parameters, Local46, 1);
	MaterialFloat Local48 = dot(Parameters.TangentToWorld[2],MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat Local49 = select((Local48 >= 0.00000000), 1.00000000, -1.00000000);
	MaterialFloat3 Local50 = (Local46.rgb * MaterialFloat3(MaterialFloat2(Local49,-1.00000000),1.00000000));
	MaterialFloat3 Local51 = (Local42.rgb * ((MaterialFloat3)Local50.r));
	MaterialFloat3 Local52 = cross(Local39,Local0);
	MaterialFloat Local53 = dot(Local52,Local52);
	MaterialFloat3 Local54 = normalize(Local52);
	MaterialFloat4 Local55 = select((abs(Local53 - 0.00000100) > 0.00001000), select((Local53 >= 0.00000100), MaterialFloat4(Local54,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	MaterialFloat3 Local56 = (Local55.rgb * ((MaterialFloat3)Local50.g));
	MaterialFloat3 Local57 = (Local51 + Local56);
	MaterialFloat3 Local58 = (Local0 * ((MaterialFloat3)Local50.b));
	MaterialFloat3 Local59 = (Local58 + MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local60 = (Local57 + Local59);
	MaterialFloat Local61 = abs(Local23.b);
	MaterialFloat Local62 = lerp((0.00000000 - 0.00000000),(0.00000000 + 1.00000000),DERIV_BASE_VALUE(Local61));
	MaterialFloat Local63 = saturate(DERIV_BASE_VALUE(Local62));
	MaterialFloat Local64 = DERIV_BASE_VALUE(Local63).r;
	MaterialFloat3 Local65 = lerp(Local38,Local60,DERIV_BASE_VALUE(Local64));
	MaterialFloat3 Local66 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Local65);
	MaterialFloat3 Local67 = lerp(Local66,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[5].w);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local67;


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
	MaterialFloat3 Local68 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[6].yzw,Material.PreshaderBuffer[6].x);
	MaterialFloat Local69 = MaterialStoreTexCoordScale(Parameters, Local8, 3);
	MaterialFloat4 Local70 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local71 = MaterialStoreTexSample(Parameters, Local70, 3);
	MaterialFloat Local72 = MaterialStoreTexCoordScale(Parameters, Local16, 3);
	MaterialFloat4 Local73 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local16));
	MaterialFloat Local74 = MaterialStoreTexSample(Parameters, Local73, 3);
	MaterialFloat Local75 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local76 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local75);
	MaterialFloat Local77 = saturate(Local76);
	MaterialFloat3 Local78 = lerp(Local70.rgb,Local73.rgb,Local77.r.r);
	MaterialFloat Local79 = MaterialStoreTexCoordScale(Parameters, Local44, 3);
	MaterialFloat4 Local80 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local44));
	MaterialFloat Local81 = MaterialStoreTexSample(Parameters, Local80, 3);
	MaterialFloat Local82 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local83 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local82);
	MaterialFloat Local84 = saturate(Local83);
	MaterialFloat3 Local85 = lerp(Local78,Local80.rgb,Local84.r.r);
	MaterialFloat Local86 = dot(Local85,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local87 = lerp(Local85,((MaterialFloat3)Local86),Material.PreshaderBuffer[8].y);
	MaterialFloat3 Local88 = (Local87 * ((MaterialFloat3)Material.PreshaderBuffer[8].z));
	MaterialFloat3 Local89 = (Local88 * Material.PreshaderBuffer[10].xyz);
	MaterialFloat3 Local90 = PositiveClampedPow(Local89,((MaterialFloat3)Material.PreshaderBuffer[10].w));
	MaterialFloat2 Local91 = Parameters.TexCoords[0].xy;
	MaterialFloat Local92 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local91), 5);
	MaterialFloat4 Local93 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local91),View.MaterialTextureMipBias));
	MaterialFloat Local94 = MaterialStoreTexSample(Parameters, Local93, 5);
	MaterialFloat3 Local95 = (Local93.rgb * ((MaterialFloat3)Material.PreshaderBuffer[11].x));
	MaterialFloat Local96 = (Local95.x - 1.00000000);
	MaterialFloat2 Local97 = Parameters.TexCoords[1].xy;
	MaterialFloat Local98 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local97), 4);
	MaterialFloat4 Local99 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local97),View.MaterialTextureMipBias));
	MaterialFloat Local100 = MaterialStoreTexSample(Parameters, Local99, 4);
	MaterialFloat2 Local101 = Parameters.TexCoords[2].xy;
	MaterialFloat Local102 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local101), 4);
	MaterialFloat4 Local103 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local101),View.MaterialTextureMipBias));
	MaterialFloat Local104 = MaterialStoreTexSample(Parameters, Local103, 4);
	MaterialFloat3 Local105 = (Local103.rgb * ((MaterialFloat3)Material.PreshaderBuffer[11].y));
	MaterialFloat3 Local106 = (Local99.rgb + Local105);
	MaterialFloat Local107 = (Local106.x * 2.00000000);
	MaterialFloat Local108 = (Local96 + Local107);
	MaterialFloat Local109 = saturate(Local108);
	MaterialFloat Local110 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local109);
	MaterialFloat Local111 = saturate(Local110);
	MaterialFloat3 Local112 = lerp(Local85,Local90,Local111.r);
	MaterialFloat Local113 = MaterialStoreTexCoordScale(Parameters, Local8, 4);
	MaterialFloat4 Local114 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local115 = MaterialStoreTexSample(Parameters, Local114, 4);
	MaterialFloat Local116 = MaterialStoreTexCoordScale(Parameters, Local16, 4);
	MaterialFloat4 Local117 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local16));
	MaterialFloat Local118 = MaterialStoreTexSample(Parameters, Local117, 4);
	MaterialFloat3 Local119 = lerp(Local114.rgb,Local117.rgb,Local77.r.r);
	MaterialFloat Local120 = MaterialStoreTexCoordScale(Parameters, Local44, 4);
	MaterialFloat4 Local121 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local44));
	MaterialFloat Local122 = MaterialStoreTexSample(Parameters, Local121, 4);
	MaterialFloat3 Local123 = lerp(Local119,Local121.rgb,Local84.r.r);
	MaterialFloat4 Local124 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local125 = MaterialStoreTexSample(Parameters, Local124, 4);
	MaterialFloat4 Local126 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local16));
	MaterialFloat Local127 = MaterialStoreTexSample(Parameters, Local126, 4);
	MaterialFloat3 Local128 = lerp(Local124.rgb,Local126.rgb,Local77.r.r);
	MaterialFloat4 Local129 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local44));
	MaterialFloat Local130 = MaterialStoreTexSample(Parameters, Local129, 4);
	MaterialFloat3 Local131 = lerp(Local128,Local129.rgb,Local84.r.r);
	MaterialFloat4 Local132 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local8));
	MaterialFloat Local133 = MaterialStoreTexSample(Parameters, Local132, 3);
	MaterialFloat4 Local134 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local16));
	MaterialFloat Local135 = MaterialStoreTexSample(Parameters, Local134, 3);
	MaterialFloat3 Local136 = lerp(Local132.rgb,Local134.rgb,Local77.r.r);
	MaterialFloat4 Local137 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local44));
	MaterialFloat Local138 = MaterialStoreTexSample(Parameters, Local137, 3);
	MaterialFloat3 Local139 = lerp(Local136,Local137.rgb,Local84.r.r);

	PixelMaterialInputs.EmissiveColor = Local68;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local112;
	PixelMaterialInputs.Metallic = Local123;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local131;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local67;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local139;
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