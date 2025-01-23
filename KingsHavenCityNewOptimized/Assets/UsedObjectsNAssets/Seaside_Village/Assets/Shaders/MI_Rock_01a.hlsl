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
	float4 PreshaderBuffer[23];
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
	Material.PreshaderBuffer[1] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,5.000000,0.005000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,0.000000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.763021,0.635417,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.763021,0.635417,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1024.000000,1024.000000,512.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1024.000000,1024.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1024.000000,1024.000000,512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(-1024.000000,-1024.000000,-512.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(-0.000977,-0.000977,-0.001953,0.750000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.197917,0.189109,0.147407,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(-0.728000,5.330000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.197917,0.189109,0.147407,0.800000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(800.000000,0.001250,1.200000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.750000,0.250000,-0.400000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.500000,0.344805,0.177546,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.500000,0.500000,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.500000,0.344805,0.177546,10.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-10.000000,37.716953,0.026513,0.500000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.400000,0.000000,0.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[1].x));
	MaterialFloat2 Local2 = (DERIV_BASE_VALUE(Local1) + Material.PreshaderBuffer[2].xy);
	MaterialFloat Local3 = (GetPrimitiveData(Parameters).ObjectRadius * Material.PreshaderBuffer[2].w);
	MaterialFloat2 Local4 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)Local3));
	MaterialFloat Local5 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local4), 3);
	MaterialFloat4 Local6 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local4),View.MaterialTextureMipBias));
	MaterialFloat Local7 = MaterialStoreTexSample(Parameters, Local6, 3);
	MaterialFloat2 Local8 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local6.r,Local6.g));
	MaterialFloat2 Local9 = (Local8 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local10 = dot(Local9,Local9);
	MaterialFloat Local11 = (1.00000000 - Local10);
	MaterialFloat Local12 = saturate(Local11);
	MaterialFloat Local13 = sqrt(Local12);
	MaterialFloat3 Local14 = lerp(MaterialFloat3(Local9,Local13),MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[3].y);
	MaterialFloat Local15 = (Local14.b + 1.00000000);
	MaterialFloat Local16 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 3);
	MaterialFloat4 Local17 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local18 = MaterialStoreTexSample(Parameters, Local17, 3);
	MaterialFloat2 Local19 = (((MaterialFloat2)-0.50000000) + MaterialFloat2(Local17.r,Local17.g));
	MaterialFloat2 Local20 = (Local19 * ((MaterialFloat2)2.00000000));
	MaterialFloat Local21 = dot(Local20,Local20);
	MaterialFloat Local22 = (1.00000000 - Local21);
	MaterialFloat Local23 = saturate(Local22);
	MaterialFloat Local24 = sqrt(Local23);
	MaterialFloat3 Local25 = lerp(MaterialFloat3(Local20,Local24),MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[3].w);
	MaterialFloat2 Local26 = (Local25.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local27 = dot(MaterialFloat3(Local14.rg,Local15),MaterialFloat3(Local26,Local25.b));
	MaterialFloat3 Local28 = (MaterialFloat3(Local14.rg,Local15) * ((MaterialFloat3)Local27));
	MaterialFloat3 Local29 = (((MaterialFloat3)Local15) * MaterialFloat3(Local26,Local25.b));
	MaterialFloat3 Local30 = (Local28 - Local29);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local30;


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
	MaterialFloat3 Local31 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[4].yzw,Material.PreshaderBuffer[4].x);
	MaterialFloat Local32 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local4), 2);
	MaterialFloat4 Local33 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local4),View.MaterialTextureMipBias));
	MaterialFloat Local34 = MaterialStoreTexSample(Parameters, Local33, 2);
	MaterialFloat Local35 = dot(Local33.rgb,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local36 = lerp(Local33.rgb,((MaterialFloat3)Local35),Material.PreshaderBuffer[5].z);
	MaterialFloat3 Local37 = (Local36 * Material.PreshaderBuffer[7].xyz);
	MaterialFloat3 Local38 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[5].y),((MaterialFloat3)0.00000000),Local37);
	MaterialFloat3 Local39 = (Local38 + Local37);
	MaterialFloat3 Local40 = (((MaterialFloat3)Material.PreshaderBuffer[7].w) * Local39);
	MaterialFloat3 Local41 = (((MaterialFloat3)1.00000000) - Local40);
	MaterialFloat3 Local42 = (Local41 * ((MaterialFloat3)2.00000000));
	FLWCVector3 Local43 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local44 = LWCMultiply(DERIV_BASE_VALUE(Local43), LWCPromote(Material.PreshaderBuffer[12].xyz));
	FLWCVector2 Local45 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local44)), LWCGetZ(DERIV_BASE_VALUE(Local44)));
	MaterialFloat2 Local46 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local45), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local47 = MaterialStoreTexCoordScale(Parameters, Local46, 9);
	MaterialFloat4 Local48 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local46));
	MaterialFloat Local49 = MaterialStoreTexSample(Parameters, Local48, 9);
	FLWCVector2 Local50 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local44)), LWCGetZ(DERIV_BASE_VALUE(Local44)));
	MaterialFloat2 Local51 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local50), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, Local51, 9);
	MaterialFloat4 Local53 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local51));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 9);
	MaterialFloat Local55 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local56 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local55);
	MaterialFloat Local57 = saturate(Local56);
	MaterialFloat3 Local58 = lerp(Local48.rgb,Local53.rgb,Local57.r.r);
	MaterialFloat3 Local59 = (((MaterialFloat3)1.00000000) - Local58);
	MaterialFloat3 Local60 = (Local42 * Local59);
	MaterialFloat3 Local61 = (((MaterialFloat3)1.00000000) - Local60);
	MaterialFloat3 Local62 = (Local40 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local63 = (Local62 * Local58);
	MaterialFloat Local64 = select((Local40.r >= 0.50000000), Local61.r, Local63.r);
	MaterialFloat Local65 = select((Local40.g >= 0.50000000), Local61.g, Local63.g);
	MaterialFloat Local66 = select((Local40.b >= 0.50000000), Local61.b, Local63.b);
	MaterialFloat Local67 = (Parameters.TangentToWorld[2].b * -1.00000000);
	MaterialFloat Local68 = max(Parameters.TangentToWorld[2].b,Local67);
	MaterialFloat Local69 = (1.00000000 - Local68);
	MaterialFloat3 Local70 = (MaterialFloat3(MaterialFloat2(Local64,Local65),Local66) * ((MaterialFloat3)Local69));
	MaterialFloat Local71 = (Local69 * Material.PreshaderBuffer[12].w);
	MaterialFloat3 Local72 = lerp(Local40,Local70,Local71);
	MaterialFloat3 Local73 = mul(Local30, Parameters.TangentToWorld);
	MaterialFloat Local74 = (Local73.b + Material.PreshaderBuffer[14].x);
	MaterialFloat Local75 = PositiveClampedPow(Local74,Material.PreshaderBuffer[14].y);
	MaterialFloat Local76 = saturate(Local75);
	MaterialFloat Local77 = (Local76 * Material.PreshaderBuffer[14].z);
	MaterialFloat3 Local78 = lerp(Local72,Material.PreshaderBuffer[15].xyz,Local77);
	FLWCVector3 Local79 = LWCAdd(LWCPromote(((MaterialFloat3)GetPerInstanceRandom(Parameters))), GetObjectWorldPosition(Parameters));
	FLWCScalar Local80 = LWCMultiply(LWCGetX(Local79), LWCPromote(Material.PreshaderBuffer[16].y));
	MaterialFloat Local81 = LWCFrac(Local80);
	FLWCScalar Local82 = LWCMultiply(LWCGetY(Local79), LWCPromote(Material.PreshaderBuffer[16].y));
	FLWCScalar Local83 = LWCMultiply(Local82, LWCPromote(6.28318548));
	MaterialFloat Local84 = LWCSin(Local83);
	MaterialFloat Local85 = (DERIV_BASE_VALUE(Local81) + DERIV_BASE_VALUE(Local84));
	MaterialFloat Local86 = MaterialStoreTexCoordScale(Parameters, ((MaterialFloat2)DERIV_BASE_VALUE(Local85)), 4);
	MaterialFloat4 Local87 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,((MaterialFloat2)DERIV_BASE_VALUE(Local85)),View.MaterialTextureMipBias));
	MaterialFloat Local88 = MaterialStoreTexSample(Parameters, Local87, 4);
	MaterialFloat3 Local89 = (Local87.rgb * Local78);
	MaterialFloat3 Local90 = lerp(Local78,Local89,Material.PreshaderBuffer[16].z);
	MaterialFloat3 Local91 = (((MaterialFloat3)1.00000000) - Local90);
	MaterialFloat3 Local92 = (Local91 * ((MaterialFloat3)2.00000000));
	MaterialFloat Local93 = PositiveClampedPow(Local17.a,Material.PreshaderBuffer[16].w);
	MaterialFloat Local94 = lerp(Material.PreshaderBuffer[17].y,Material.PreshaderBuffer[17].x,Local93);
	MaterialFloat Local95 = saturate(Local94);
	MaterialFloat Local96 = (1.00000000 - Local95);
	MaterialFloat3 Local97 = (Local92 * ((MaterialFloat3)Local96));
	MaterialFloat3 Local98 = (((MaterialFloat3)1.00000000) - Local97);
	MaterialFloat3 Local99 = (Local90 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local100 = (Local99 * ((MaterialFloat3)Local95));
	MaterialFloat Local101 = select((Local90.r >= 0.50000000), Local98.r, Local100.r);
	MaterialFloat Local102 = select((Local90.g >= 0.50000000), Local98.g, Local100.g);
	MaterialFloat Local103 = select((Local90.b >= 0.50000000), Local98.b, Local100.b);
	MaterialFloat Local104 = dot(MaterialFloat3(MaterialFloat2(Local101,Local102),Local103),MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local105 = lerp(MaterialFloat3(MaterialFloat2(Local101,Local102),Local103),((MaterialFloat3)Local104),Material.PreshaderBuffer[17].z);
	MaterialFloat3 Local106 = (Local105 * Material.PreshaderBuffer[20].xyz);
	FLWCVector3 Local107 = GetWorldPosition(Parameters);
	FLWCScalar Local108 = LWCGetZ(DERIV_BASE_VALUE(Local107));
	FLWCScalar Local109 = LWCAdd(DERIV_BASE_VALUE(Local108), LWCPromote(Material.PreshaderBuffer[21].x));
	FLWCScalar Local110 = LWCMultiply(DERIV_BASE_VALUE(Local109), LWCPromote(-1.00000000));
	MaterialFloat Local111 = LWCSaturate(DERIV_BASE_VALUE(Local110));
	FLWCScalar Local112 = LWCSubtract(DERIV_BASE_VALUE(Local109), LWCPromote(0.00000000));
	FLWCScalar Local113 = LWCLength(DERIV_BASE_VALUE(Local112));
	FLWCScalar Local114 = LWCMultiply(DERIV_BASE_VALUE(Local113), LWCPromote(Material.PreshaderBuffer[21].z));
	MaterialFloat Local115 = LWCSaturate(DERIV_BASE_VALUE(Local114));
	MaterialFloat Local116 = (1.00000000 - DERIV_BASE_VALUE(Local115));
	MaterialFloat Local117 = max(DERIV_BASE_VALUE(Local111),DERIV_BASE_VALUE(Local116));
	MaterialFloat3 Local118 = lerp(MaterialFloat3(MaterialFloat2(Local101,Local102),Local103),Local106,DERIV_BASE_VALUE(Local117));
	MaterialFloat Local119 = (Local33.a * Material.PreshaderBuffer[22].x);
	FLWCScalar Local120 = LWCAdd(DERIV_BASE_VALUE(Local108), LWCPromote(0.50000000));
	MaterialFloat Local121 = LWCSaturate(DERIV_BASE_VALUE(Local120));
	MaterialFloat Local122 = (DERIV_BASE_VALUE(Local117) * DERIV_BASE_VALUE(Local121));
	MaterialFloat Local123 = lerp(Local33.a,Local119,DERIV_BASE_VALUE(Local122));
	MaterialFloat Local124 = (1.00000000 - Local17.b);
	MaterialFloat Local125 = (Local124 * 2.00000000);
	MaterialFloat Local126 = (1.00000000 - Local6.b);
	MaterialFloat Local127 = (Local125 * Local126);
	MaterialFloat Local128 = (1.00000000 - Local127);
	MaterialFloat Local129 = (Local17.b * 2.00000000);
	MaterialFloat Local130 = (Local129 * Local6.b);
	MaterialFloat Local131 = select((Local17.b.r >= 0.50000000), Local128.r, Local130.r);

	PixelMaterialInputs.EmissiveColor = Local31;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local118;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[21].w;
	PixelMaterialInputs.Roughness = Local123;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local30;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = MaterialFloat3(MaterialFloat2(Local131,Local131),Local131);
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