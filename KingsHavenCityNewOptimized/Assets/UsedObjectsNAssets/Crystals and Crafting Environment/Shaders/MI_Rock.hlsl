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
	float4 PreshaderBuffer[7];
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
	Material.PreshaderBuffer[1] = float4(200.000000,200.000000,-200.000000,-0.005000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(5.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.052861,0.054480,0.049707,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.052861,0.054480,0.049707,0.200000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.660893,1.200000,-0.200000,0.000000);//(Unknown)
}
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
	MaterialFloat Local1 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local2 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local3 = MaterialStoreTexSample(Parameters, Local2, 0);
	MaterialFloat Local4 = (Local2.rgb.b + 1.00000000);
	MaterialFloat3 Local5 = normalize(Parameters.TangentToWorld[2]);
	MaterialFloat3 Local6 = cross(Local5,normalize(MaterialFloat3(0.00000000,0.00000000,1.00000000)));
	MaterialFloat Local7 = dot(Local6,Local6);
	MaterialFloat3 Local8 = normalize(Local6);
	MaterialFloat4 Local9 = select((abs(Local7 - 0.00000100) > 0.00001000), select((Local7 >= 0.00000100), MaterialFloat4(Local8,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	FLWCVector3 Local10 = GetWorldPosition_NoMaterialOffsets(Parameters);
	FLWCVector3 Local11 = LWCMultiply(DERIV_BASE_VALUE(Local10), LWCPromote(((MaterialFloat3)Material.PreshaderBuffer[1].w)));
	FLWCVector2 Local12 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local11)), LWCGetZ(DERIV_BASE_VALUE(Local11)));
	MaterialFloat2 Local13 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local12), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local14 = MaterialStoreTexCoordScale(Parameters, Local13, 7);
	MaterialFloat4 Local15 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local13));
	MaterialFloat Local16 = MaterialStoreTexSample(Parameters, Local15, 7);
	MaterialFloat Local17 = dot(Parameters.TangentToWorld[2],MaterialFloat3(0.00000000,1.00000000,0.00000000));
	MaterialFloat Local18 = select((Local17 >= 0.00000000), -1.00000000, 1.00000000);
	MaterialFloat3 Local19 = (Local15.rgb * MaterialFloat3(MaterialFloat2(Local18,-1.00000000),1.00000000));
	FLWCVector2 Local20 = MakeLWCVector(LWCGetY(DERIV_BASE_VALUE(Local11)), LWCGetZ(DERIV_BASE_VALUE(Local11)));
	MaterialFloat2 Local21 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local20), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local22 = MaterialStoreTexCoordScale(Parameters, Local21, 7);
	MaterialFloat4 Local23 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local21));
	MaterialFloat Local24 = MaterialStoreTexSample(Parameters, Local23, 7);
	MaterialFloat Local25 = dot(Parameters.TangentToWorld[2],MaterialFloat3(1.00000000,0.00000000,0.00000000));
	MaterialFloat Local26 = select((Local25 >= 0.00000000), 1.00000000, -1.00000000);
	MaterialFloat3 Local27 = (Local23.rgb * MaterialFloat3(MaterialFloat2(Local26,-1.00000000),1.00000000));
	MaterialFloat3 Local28 = mul(MaterialFloat3(0.00000000,0.00000000,1.00000000), Parameters.TangentToWorld);
	MaterialFloat Local29 = abs(Local28.r);
	MaterialFloat Local30 = lerp((0.00000000 - 0.00000000),(0.00000000 + 1.00000000),DERIV_BASE_VALUE(Local29));
	MaterialFloat Local31 = saturate(DERIV_BASE_VALUE(Local30));
	MaterialFloat Local32 = DERIV_BASE_VALUE(Local31).r;
	MaterialFloat3 Local33 = lerp(Local19,Local27,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local34 = (Local9.rgb * ((MaterialFloat3)Local33.r));
	MaterialFloat3 Local35 = cross(Local6,Local5);
	MaterialFloat Local36 = dot(Local35,Local35);
	MaterialFloat3 Local37 = normalize(Local35);
	MaterialFloat4 Local38 = select((abs(Local36 - 0.00000100) > 0.00001000), select((Local36 >= 0.00000100), MaterialFloat4(Local37,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	MaterialFloat3 Local39 = (Local38.rgb * ((MaterialFloat3)Local33.g));
	MaterialFloat3 Local40 = (Local34 + Local39);
	MaterialFloat3 Local41 = (Local5 * ((MaterialFloat3)Local33.b));
	MaterialFloat3 Local42 = (Local41 + MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local43 = (Local40 + Local42);
	MaterialFloat3 Local44 = cross(Local5,normalize(MaterialFloat3(0.00000000,1.00000000,0.00000000)));
	MaterialFloat Local45 = dot(Local44,Local44);
	MaterialFloat3 Local46 = normalize(Local44);
	MaterialFloat4 Local47 = select((abs(Local45 - 0.00000100) > 0.00001000), select((Local45 >= 0.00000100), MaterialFloat4(Local46,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	FLWCVector2 Local48 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local11)), LWCGetY(DERIV_BASE_VALUE(Local11)));
	MaterialFloat2 Local49 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local48), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local50 = MaterialStoreTexCoordScale(Parameters, Local49, 7);
	MaterialFloat4 Local51 = UnpackNormalMap(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),Local49));
	MaterialFloat Local52 = MaterialStoreTexSample(Parameters, Local51, 7);
	MaterialFloat Local53 = dot(Parameters.TangentToWorld[2],MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat Local54 = select((Local53 >= 0.00000000), 1.00000000, -1.00000000);
	MaterialFloat3 Local55 = (Local51.rgb * MaterialFloat3(MaterialFloat2(Local54,-1.00000000),1.00000000));
	MaterialFloat3 Local56 = (Local47.rgb * ((MaterialFloat3)Local55.r));
	MaterialFloat3 Local57 = cross(Local44,Local5);
	MaterialFloat Local58 = dot(Local57,Local57);
	MaterialFloat3 Local59 = normalize(Local57);
	MaterialFloat4 Local60 = select((abs(Local58 - 0.00000100) > 0.00001000), select((Local58 >= 0.00000100), MaterialFloat4(Local59,0.00000000), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000)), MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000),1.00000000));
	MaterialFloat3 Local61 = (Local60.rgb * ((MaterialFloat3)Local55.g));
	MaterialFloat3 Local62 = (Local56 + Local61);
	MaterialFloat3 Local63 = (Local5 * ((MaterialFloat3)Local55.b));
	MaterialFloat3 Local64 = (Local63 + MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local65 = (Local62 + Local64);
	MaterialFloat Local66 = abs(Local28.b);
	MaterialFloat Local67 = lerp((0.00000000 - 0.00000000),(0.00000000 + 1.00000000),DERIV_BASE_VALUE(Local66));
	MaterialFloat Local68 = saturate(DERIV_BASE_VALUE(Local67));
	MaterialFloat Local69 = DERIV_BASE_VALUE(Local68).r;
	MaterialFloat3 Local70 = lerp(Local43,Local65,DERIV_BASE_VALUE(Local69));
	MaterialFloat3 Local71 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Local70);
	MaterialFloat2 Local72 = (Local71.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local73 = dot(MaterialFloat3(Local2.rgb.rg,Local4),MaterialFloat3(Local72,Local71.b));
	MaterialFloat3 Local74 = (MaterialFloat3(Local2.rgb.rg,Local4) * ((MaterialFloat3)Local73));
	MaterialFloat3 Local75 = (((MaterialFloat3)Local4) * MaterialFloat3(Local72,Local71.b));
	MaterialFloat3 Local76 = (Local74 - Local75);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local76;


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
	MaterialFloat3 Local77 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[2].yzw,Material.PreshaderBuffer[2].x);
	MaterialFloat2 Local78 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[3].x));
	MaterialFloat Local79 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local78), 5);
	MaterialFloat4 Local80 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local78),View.MaterialTextureMipBias));
	MaterialFloat Local81 = MaterialStoreTexSample(Parameters, Local80, 5);
	MaterialFloat Local82 = MaterialStoreTexCoordScale(Parameters, Local13, 6);
	MaterialFloat4 Local83 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local13));
	MaterialFloat Local84 = MaterialStoreTexSample(Parameters, Local83, 6);
	MaterialFloat Local85 = MaterialStoreTexCoordScale(Parameters, Local21, 6);
	MaterialFloat4 Local86 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local21));
	MaterialFloat Local87 = MaterialStoreTexSample(Parameters, Local86, 6);
	MaterialFloat Local88 = abs(Parameters.TangentToWorld[2].r);
	MaterialFloat Local89 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local88);
	MaterialFloat Local90 = saturate(Local89);
	MaterialFloat3 Local91 = lerp(Local83.rgb,Local86.rgb,Local90.r.r);
	MaterialFloat Local92 = MaterialStoreTexCoordScale(Parameters, Local49, 6);
	MaterialFloat4 Local93 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),Local49));
	MaterialFloat Local94 = MaterialStoreTexSample(Parameters, Local93, 6);
	MaterialFloat Local95 = abs(Parameters.TangentToWorld[2].b);
	MaterialFloat Local96 = lerp((0.00000000 - 1.00000000),(1.00000000 + 1.00000000),Local95);
	MaterialFloat Local97 = saturate(Local96);
	MaterialFloat3 Local98 = lerp(Local91,Local93.rgb,Local97.r.r);
	MaterialFloat Local99 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 4);
	MaterialFloat4 Local100 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local101 = MaterialStoreTexSample(Parameters, Local100, 4);
	MaterialFloat3 Local102 = lerp(Local98,Material.PreshaderBuffer[5].xyz,Local100.rgb);
	MaterialFloat Local103 = (WorldNormalCopy.b * -1.00000000);
	MaterialFloat Local104 = (Local103 + Material.PreshaderBuffer[6].x);
	MaterialFloat Local105 = saturate(Local104);
	MaterialFloat Local106 = lerp(Material.PreshaderBuffer[6].z,Material.PreshaderBuffer[6].y,Local105);
	MaterialFloat Local107 = saturate(Local106);
	MaterialFloat3 Local108 = lerp(Local80.rgb,Local102,Local107.r);
	MaterialFloat Local109 = MaterialStoreTexCoordScale(Parameters, Local13, 8);
	MaterialFloat4 Local110 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local13));
	MaterialFloat Local111 = MaterialStoreTexSample(Parameters, Local110, 8);
	MaterialFloat Local112 = MaterialStoreTexCoordScale(Parameters, Local21, 8);
	MaterialFloat4 Local113 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local21));
	MaterialFloat Local114 = MaterialStoreTexSample(Parameters, Local113, 8);
	MaterialFloat3 Local115 = lerp(Local110.rgb,Local113.rgb,Local90.r.r);
	MaterialFloat Local116 = MaterialStoreTexCoordScale(Parameters, Local49, 8);
	MaterialFloat4 Local117 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local49));
	MaterialFloat Local118 = MaterialStoreTexSample(Parameters, Local117, 8);
	MaterialFloat3 Local119 = lerp(Local115,Local117.rgb,Local97.r.r);
	MaterialFloat Local120 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 9);
	MaterialFloat4 Local121 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local122 = MaterialStoreTexSample(Parameters, Local121, 9);
	MaterialFloat Local123 = lerp(Local119.b,Local121.b,Local107.r);
	MaterialFloat Local124 = lerp(Local119.g,Local121.g,Local107.r);
	MaterialFloat Local125 = lerp(Local119.r,Local121.r,Local107.r);

	PixelMaterialInputs.EmissiveColor = Local77;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local108;
	PixelMaterialInputs.Metallic = Local123;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local124;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local76;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local125;
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