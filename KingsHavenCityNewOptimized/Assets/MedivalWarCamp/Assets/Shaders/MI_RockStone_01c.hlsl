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
	float4 PreshaderBuffer[25];
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
	Material.PreshaderBuffer[2] = float4(200.000000,200.000000,-200.000000,-0.005000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,155.951324,155.951324,-155.951324);//(Unknown)
	Material.PreshaderBuffer[4] = float4(-0.006412,1.000000,500.000000,500.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(-500.000000,-0.002000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(2.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.229738,1.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.082942,0.264000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.833428,0.000000,1.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,0.500000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.000000,1.000000,0.928000,1.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.000000,0.000000,0.496000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat3 Local89 = (Local88.rgb * MaterialFloat3(1.00000000,1.00000000,0.50000000));
	MaterialFloat2 Local90 = (DERIV_BASE_VALUE(Local64) * ((MaterialFloat2)Material.PreshaderBuffer[5].w));
	MaterialFloat Local91 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local90), 0);
	MaterialFloat4 Local92 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local90),View.MaterialTextureMipBias));
	MaterialFloat Local93 = MaterialStoreTexSample(Parameters, Local92, 0);
	MaterialFloat2 Local94 = (Local92.rgb.rg * ((MaterialFloat2)Material.PreshaderBuffer[6].x));
	MaterialFloat3 Local95 = (Local89 + MaterialFloat3(Local94,Local92.rgb.b));
	MaterialFloat3 Local96 = (Local95 * MaterialFloat3(1.00000000,1.00000000,0.67500001));
	MaterialFloat3 Local97 = (((MaterialFloat3)1.00000000) - Local96.rgb);
	MaterialFloat3 Local98 = (Local25 * Local97);
	MaterialFloat3 Local99 = (((MaterialFloat3)1.00000000) - Local98);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local99;


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
	MaterialFloat3 Local100 = lerp(0.00000000.rrr.rgb,Material.PreshaderBuffer[7].xyz,Material.PreshaderBuffer[6].y);
	MaterialFloat Local101 = MaterialStoreTexCoordScale(Parameters, Local28, 2);
	MaterialFloat4 Local102 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local28));
	MaterialFloat Local103 = MaterialStoreTexSample(Parameters, Local102, 2);
	MaterialFloat Local104 = MaterialStoreTexCoordScale(Parameters, Local33, 2);
	MaterialFloat4 Local105 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local33));
	MaterialFloat Local106 = MaterialStoreTexSample(Parameters, Local105, 2);
	MaterialFloat3 Local107 = lerp(Local102.rgb,Local105.rgb,Local14.r.r);
	MaterialFloat Local108 = MaterialStoreTexCoordScale(Parameters, Local39, 2);
	MaterialFloat4 Local109 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),Local39));
	MaterialFloat Local110 = MaterialStoreTexSample(Parameters, Local109, 2);
	MaterialFloat3 Local111 = lerp(Local107,Local109.rgb,Local23.r.r);
	MaterialFloat3 Local112 = (Local111 * Material.PreshaderBuffer[10].xyz);
	MaterialFloat3 Local113 = lerp(Local111,Local112,Material.PreshaderBuffer[10].w);
	MaterialFloat3 Local114 = (Local113 * ((MaterialFloat3)Material.PreshaderBuffer[11].x));
	MaterialFloat3 Local115 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[8].x),((MaterialFloat3)0.00000000),Local114);
	MaterialFloat3 Local116 = (Local115 + Local114);
	MaterialFloat Local117 = dot(Local116,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local118 = lerp(Local116,((MaterialFloat3)Local117),Material.PreshaderBuffer[11].y);
	MaterialFloat Local119 = MaterialStoreTexCoordScale(Parameters, Local28, 4);
	MaterialFloat4 Local120 = Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local28);
	MaterialFloat Local121 = MaterialStoreTexSample(Parameters, Local120, 4);
	MaterialFloat Local122 = MaterialStoreTexCoordScale(Parameters, Local33, 4);
	MaterialFloat4 Local123 = Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local33);
	MaterialFloat Local124 = MaterialStoreTexSample(Parameters, Local123, 4);
	MaterialFloat3 Local125 = lerp(Local120.rgb,Local123.rgb,Local14.r.r);
	MaterialFloat Local126 = MaterialStoreTexCoordScale(Parameters, Local39, 4);
	MaterialFloat4 Local127 = Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local39);
	MaterialFloat Local128 = MaterialStoreTexSample(Parameters, Local127, 4);
	MaterialFloat3 Local129 = lerp(Local125,Local127.rgb,Local23.r.r);
	MaterialFloat Local130 = (Local129.r * Material.PreshaderBuffer[11].z);
	MaterialFloat Local131 = PositiveClampedPow(Local130,Material.PreshaderBuffer[11].w);
	MaterialFloat Local132 = (Local131 * Material.PreshaderBuffer[12].x);
	MaterialFloat3 Local133 = (Local118 * ((MaterialFloat3)Local132));
	MaterialFloat Local134 = MaterialStoreTexCoordScale(Parameters, Local47, 2);
	MaterialFloat4 Local135 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local47));
	MaterialFloat Local136 = MaterialStoreTexSample(Parameters, Local135, 2);
	MaterialFloat Local137 = MaterialStoreTexCoordScale(Parameters, Local52, 2);
	MaterialFloat4 Local138 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local52));
	MaterialFloat Local139 = MaterialStoreTexSample(Parameters, Local138, 2);
	MaterialFloat3 Local140 = lerp(Local135.rgb,Local138.rgb,Local14.r.r);
	MaterialFloat Local141 = MaterialStoreTexCoordScale(Parameters, Local58, 2);
	MaterialFloat4 Local142 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local58));
	MaterialFloat Local143 = MaterialStoreTexSample(Parameters, Local142, 2);
	MaterialFloat3 Local144 = lerp(Local140,Local142.rgb,Local23.r.r);
	MaterialFloat3 Local145 = (Local144 * Material.PreshaderBuffer[14].xyz);
	MaterialFloat3 Local146 = lerp(Local144,Local145,Material.PreshaderBuffer[14].w);
	MaterialFloat3 Local147 = (Local146 * ((MaterialFloat3)Material.PreshaderBuffer[15].x));
	MaterialFloat3 Local148 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[12].z),((MaterialFloat3)0.00000000),Local147);
	MaterialFloat3 Local149 = (Local148 + Local147);
	MaterialFloat Local150 = dot(Local149,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local151 = lerp(Local149,((MaterialFloat3)Local150),Material.PreshaderBuffer[15].y);
	MaterialFloat Local152 = MaterialStoreTexCoordScale(Parameters, Local47, 4);
	MaterialFloat4 Local153 = Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local47);
	MaterialFloat Local154 = MaterialStoreTexSample(Parameters, Local153, 4);
	MaterialFloat Local155 = MaterialStoreTexCoordScale(Parameters, Local52, 4);
	MaterialFloat4 Local156 = Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local52);
	MaterialFloat Local157 = MaterialStoreTexSample(Parameters, Local156, 4);
	MaterialFloat3 Local158 = lerp(Local153.rgb,Local156.rgb,Local14.r.r);
	MaterialFloat Local159 = MaterialStoreTexCoordScale(Parameters, Local58, 4);
	MaterialFloat4 Local160 = Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),Local58);
	MaterialFloat Local161 = MaterialStoreTexSample(Parameters, Local160, 4);
	MaterialFloat3 Local162 = lerp(Local158,Local160.rgb,Local23.r.r);
	MaterialFloat Local163 = (Local162.r * Material.PreshaderBuffer[15].z);
	MaterialFloat Local164 = PositiveClampedPow(Local163,Material.PreshaderBuffer[15].w);
	MaterialFloat Local165 = (Local164 * Material.PreshaderBuffer[16].x);
	MaterialFloat3 Local166 = (Local151 * ((MaterialFloat3)Local165));
	MaterialFloat3 Local167 = saturate(Local166);
	MaterialFloat3 Local168 = lerp(Local133,Local167,Local66.rgb.g);
	MaterialFloat Local169 = MaterialStoreTexCoordScale(Parameters, Local71, 2);
	MaterialFloat4 Local170 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local71));
	MaterialFloat Local171 = MaterialStoreTexSample(Parameters, Local170, 2);
	MaterialFloat Local172 = MaterialStoreTexCoordScale(Parameters, Local76, 2);
	MaterialFloat4 Local173 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local76));
	MaterialFloat Local174 = MaterialStoreTexSample(Parameters, Local173, 2);
	MaterialFloat3 Local175 = lerp(Local170.rgb,Local173.rgb,Local14.r.r);
	MaterialFloat Local176 = MaterialStoreTexCoordScale(Parameters, Local82, 2);
	MaterialFloat4 Local177 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),Local82));
	MaterialFloat Local178 = MaterialStoreTexSample(Parameters, Local177, 2);
	MaterialFloat3 Local179 = lerp(Local175,Local177.rgb,Local23.r.r);
	MaterialFloat3 Local180 = (Local179 * Material.PreshaderBuffer[18].xyz);
	MaterialFloat3 Local181 = lerp(Local179,Local180,Material.PreshaderBuffer[18].w);
	MaterialFloat3 Local182 = (Local181 * ((MaterialFloat3)Material.PreshaderBuffer[19].x));
	MaterialFloat3 Local183 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[16].z),((MaterialFloat3)0.00000000),Local182);
	MaterialFloat3 Local184 = (Local183 + Local182);
	MaterialFloat Local185 = dot(Local184,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local186 = lerp(Local184,((MaterialFloat3)Local185),Material.PreshaderBuffer[19].y);
	MaterialFloat Local187 = MaterialStoreTexCoordScale(Parameters, Local71, 4);
	MaterialFloat4 Local188 = Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local71);
	MaterialFloat Local189 = MaterialStoreTexSample(Parameters, Local188, 4);
	MaterialFloat Local190 = MaterialStoreTexCoordScale(Parameters, Local76, 4);
	MaterialFloat4 Local191 = Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local76);
	MaterialFloat Local192 = MaterialStoreTexSample(Parameters, Local191, 4);
	MaterialFloat3 Local193 = lerp(Local188.rgb,Local191.rgb,Local14.r.r);
	MaterialFloat Local194 = MaterialStoreTexCoordScale(Parameters, Local82, 4);
	MaterialFloat4 Local195 = Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),Local82);
	MaterialFloat Local196 = MaterialStoreTexSample(Parameters, Local195, 4);
	MaterialFloat3 Local197 = lerp(Local193,Local195.rgb,Local23.r.r);
	MaterialFloat Local198 = (Local197.r * Material.PreshaderBuffer[19].z);
	MaterialFloat Local199 = PositiveClampedPow(Local198,Material.PreshaderBuffer[19].w);
	MaterialFloat Local200 = (Local199 * Material.PreshaderBuffer[20].x);
	MaterialFloat3 Local201 = (Local186 * ((MaterialFloat3)Local200));
	MaterialFloat3 Local202 = saturate(Local201);
	MaterialFloat3 Local203 = lerp(Local168,Local202,Local66.rgb.r);
	MaterialFloat Local204 = (Local111.r * Material.PreshaderBuffer[20].y);
	MaterialFloat Local205 = (Local144.r * Material.PreshaderBuffer[20].z);
	MaterialFloat Local206 = lerp(Local204,Local205,Local66.rgb.g);
	MaterialFloat Local207 = (Local179.r * Material.PreshaderBuffer[20].w);
	MaterialFloat Local208 = lerp(Local206,Local207,Local66.rgb.r);
	MaterialFloat Local209 = lerp(Material.PreshaderBuffer[21].z,Material.PreshaderBuffer[21].y,Local129.g);
	MaterialFloat Local210 = lerp(Material.PreshaderBuffer[22].x,Material.PreshaderBuffer[21].w,Local209);
	MaterialFloat Local211 = saturate(Local210);
	MaterialFloat Local212 = lerp(Material.PreshaderBuffer[22].w,Material.PreshaderBuffer[22].z,Local162.g);
	MaterialFloat Local213 = lerp(Material.PreshaderBuffer[23].y,Material.PreshaderBuffer[23].x,Local212);
	MaterialFloat Local214 = saturate(Local213);
	MaterialFloat Local215 = lerp(Local211.r,Local214.r,Local66.rgb.g);
	MaterialFloat Local216 = lerp(Material.PreshaderBuffer[24].x,Material.PreshaderBuffer[23].w,Local197.g);
	MaterialFloat Local217 = lerp(Material.PreshaderBuffer[24].z,Material.PreshaderBuffer[24].y,Local216);
	MaterialFloat Local218 = saturate(Local217);
	MaterialFloat Local219 = lerp(Local215,Local218.r,Local66.rgb.r);
	MaterialFloat Local220 = lerp(Local131,Local164,Local66.rgb.g);
	MaterialFloat Local221 = lerp(Local220,Local199,Local66.rgb.r);

	PixelMaterialInputs.EmissiveColor = Local100;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local203.rgb.rgb;
	PixelMaterialInputs.Metallic = 0.00000000.r.r;
	PixelMaterialInputs.Specular = Local208.r.r;
	PixelMaterialInputs.Roughness = Local219.r.r;
	PixelMaterialInputs.Anisotropy = 0.00000000.r;
	PixelMaterialInputs.Normal = Local99;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000).rgb;
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local221.r.r;
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