#define NUM_TEX_COORD_INTERPOLATORS 0
#define NUM_MATERIAL_TEXCOORDS_VERTEX 0
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
	float4 PreshaderBuffer[32];
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
	Material.PreshaderBuffer[1] = float4(6.633894,0.001000,0.000010,84832.515625);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000012,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.009732,0.032351,0.067708,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.033333,0.033333,30.000299,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.009732,0.032351,0.067708,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.000000,0.000000,0.000000,0.010000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,7500.000000,0.000133);//(Unknown)
	Material.PreshaderBuffer[10] = float4(3.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.042941,0.078293,0.119792,1.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.042941,0.078293,0.119792,-0.154762);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.050000,0.138095,0.138095,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.906461,3.000000,29.510790,0.737770);//(Unknown)
	Material.PreshaderBuffer[15] = float4(4.635544,-0.997049,0.997049,-0.076769);//(Unknown)
	Material.PreshaderBuffer[16] = float4(-0.076769,0.997049,-0.997049,-0.076769);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.019048,0.500000,0.740295,-0.071429);//(Unknown)
	Material.PreshaderBuffer[18] = float4(3.000000,6.000000,0.150000,0.942478);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.809017,-0.809017,0.587785,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.587785,-0.809017,0.809017,0.587785);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-0.019047,0.500000,1.175629,-0.052382);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.000000,2.404027,0.060101,0.377624);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.368713,-0.368713,0.929543,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.929543,-0.368713,0.368713,0.929543);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.825887,0.825887,3.174017,4.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.033333,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.015625,0.015625,0.015625,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(280648.062500,0.000004,0.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.015625,0.015625,0.015625,0.200000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.100000,132.226746,132.226746,0.007563);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
}void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat Local0 = (View.GameTime * Material.PreshaderBuffer[1].x);
	MaterialFloat Local1 = (Local0 * MaterialFloat2(17.50000000,8.50000000).r);
	MaterialFloat Local2 = (Local0 * MaterialFloat2(17.50000000,8.50000000).g);
	FLWCVector3 Local3 = GetWorldPosition(Parameters);
	FLWCVector2 Local4 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local3)), LWCGetY(DERIV_BASE_VALUE(Local3)));
	FLWCVector2 Local5 = LWCAdd(LWCPromote(MaterialFloat2(Local1,Local2)), DERIV_BASE_VALUE(Local4));
	FLWCVector2 Local6 = LWCMultiply(DERIV_BASE_VALUE(Local5), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[1].y)));
	MaterialFloat2 Local7 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local6), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local8 = MaterialStoreTexCoordScale(Parameters, Local7, 3);
	MaterialFloat4 Local9 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local7,View.MaterialTextureMipBias));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 3);
	MaterialFloat Local11 = (Local0 * MaterialFloat2(0.25000000,-1.50000000).r);
	MaterialFloat Local12 = (Local0 * MaterialFloat2(0.25000000,-1.50000000).g);
	FLWCVector2 Local13 = LWCAdd(LWCPromote(MaterialFloat2(Local11,Local12)), DERIV_BASE_VALUE(Local4));
	FLWCVector2 Local14 = LWCMultiply(DERIV_BASE_VALUE(Local13), LWCPromote(MaterialFloat2(0.00030000,0.00020000)));
	MaterialFloat2 Local15 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local14), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local16 = MaterialStoreTexCoordScale(Parameters, Local15, 3);
	MaterialFloat4 Local17 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local15,View.MaterialTextureMipBias));
	MaterialFloat Local18 = MaterialStoreTexSample(Parameters, Local17, 3);
	MaterialFloat2 Local19 = (MaterialFloat2(Local9.r,Local9.g) + MaterialFloat2(Local17.r,Local17.g));
	MaterialFloat2 Local20 = (Local19 * ((MaterialFloat2)0.15000001));
	MaterialFloat Local21 = (Local0 * MaterialFloat2(2.15000010,2.79999995).r);
	MaterialFloat Local22 = (Local0 * MaterialFloat2(2.15000010,2.79999995).g);
	FLWCVector2 Local23 = LWCAdd(LWCPromote(MaterialFloat2(Local21,Local22)), DERIV_BASE_VALUE(Local4));
	FLWCVector2 Local24 = LWCMultiply(DERIV_BASE_VALUE(Local23), LWCPromote(MaterialFloat2(0.00020000,0.00010000)));
	MaterialFloat2 Local25 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local24), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local26 = MaterialStoreTexCoordScale(Parameters, Local25, 3);
	MaterialFloat4 Local27 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local25,View.MaterialTextureMipBias));
	MaterialFloat Local28 = MaterialStoreTexSample(Parameters, Local27, 3);
	MaterialFloat2 Local29 = (MaterialFloat2(Local27.r,Local27.g) * ((MaterialFloat2)0.25000000));
	MaterialFloat2 Local30 = (Local20 + Local29);
	MaterialFloat Local31 = (Local0 * MaterialFloat2(0.00000000,-2.50000000).g);
	FLWCVector2 Local32 = LWCAdd(LWCPromote(MaterialFloat2(0.00000000,Local31)), DERIV_BASE_VALUE(Local4));
	FLWCVector2 Local33 = LWCMultiply(DERIV_BASE_VALUE(Local32), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[1].z)));
	MaterialFloat2 Local34 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local33), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local35 = MaterialStoreTexCoordScale(Parameters, Local34, 3);
	MaterialFloat4 Local36 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local34,View.MaterialTextureMipBias));
	MaterialFloat Local37 = MaterialStoreTexSample(Parameters, Local36, 3);
	MaterialFloat2 Local38 = (MaterialFloat2(Local36.r,Local36.g) * ((MaterialFloat2)0.05000000));
	MaterialFloat Local39 = CalcSceneDepth(ScreenAlignedPosition(GetScreenPosition(Parameters)));
	MaterialFloat Local40 = (Local39.r * Material.PreshaderBuffer[2].x);
	MaterialFloat Local41 = PositiveClampedPow(Local40,Material.PreshaderBuffer[2].y);
	MaterialFloat Local42 = saturate(Local41);
	MaterialFloat2 Local43 = lerp(Local30,Local38,Local42);
	MaterialFloat Local44 = dot(Local43,Local43);
	MaterialFloat Local45 = (1.00000000 - Local44);
	MaterialFloat Local46 = saturate(Local45);
	MaterialFloat Local47 = sqrt(Local46);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = MaterialFloat3(Local43,Local47);


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
	MaterialFloat3 Local48 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[3].xyz,Material.PreshaderBuffer[2].z);
	MaterialFloat Local49 = GetPixelDepth(Parameters);
	MaterialFloat Local50 = (Local39 - DERIV_BASE_VALUE(Local49));
	MaterialFloat Local51 = (Local50 * Material.PreshaderBuffer[6].z);
	MaterialFloat Local52 = saturate(Local51);
	MaterialFloat3 Local53 = lerp(Material.PreshaderBuffer[8].xyz,Material.PreshaderBuffer[7].xyz,Local52);
	MaterialFloat Local54 = (Material.PreshaderBuffer[8].w * View.GameTime);
	MaterialFloat Local55 = (Local54 * Material.PreshaderBuffer[9].y);
	FLWCVector2 Local56 = LWCMultiply(DERIV_BASE_VALUE(Local4), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[9].w)));
	FLWCVector2 Local57 = LWCMultiply(DERIV_BASE_VALUE(Local56), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[10].x)));
	FLWCVector2 Local58 = LWCAdd(LWCPromote(MaterialFloat2(Local55,Local55)), DERIV_BASE_VALUE(Local57));
	MaterialFloat2 Local59 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local58), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local60 = MaterialStoreTexCoordScale(Parameters, Local59, 2);
	MaterialFloat4 Local61 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,Local59,View.MaterialTextureMipBias));
	MaterialFloat Local62 = MaterialStoreTexSample(Parameters, Local61, 2);
	MaterialFloat3 Local63 = (((MaterialFloat3)Local61.r) + Material.PreshaderBuffer[12].xyz);
	MaterialFloat Local64 = (View.GameTime * Material.PreshaderBuffer[12].w);
	MaterialFloat Local65 = (Local64 * 0.50000000);
	MaterialFloat Local66 = (Material.PreshaderBuffer[13].x * View.GameTime);
	MaterialFloat Local67 = (Local66 * Material.PreshaderBuffer[13].z);
	FLWCVector2 Local68 = LWCMultiply(DERIV_BASE_VALUE(Local56), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[13].w)));
	FLWCVector2 Local69 = LWCAdd(LWCPromote(MaterialFloat2(Local67,Local67)), DERIV_BASE_VALUE(Local68));
	MaterialFloat2 Local70 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local69), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local71 = MaterialStoreTexCoordScale(Parameters, Local70, 1);
	MaterialFloat4 Local72 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,Local70,View.MaterialTextureMipBias));
	MaterialFloat Local73 = MaterialStoreTexSample(Parameters, Local72, 1);
	MaterialFloat2 Local74 = (((MaterialFloat2)1.00000000) + Local72.rgb.rg);
	MaterialFloat2 Local75 = (Local74 * ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local76 = (Local75 * ((MaterialFloat2)Material.PreshaderBuffer[14].x));
	FLWCVector2 Local77 = LWCAdd(LWCPromote(Local76), DERIV_BASE_VALUE(Local56));
	FLWCVector2 Local78 = LWCMultiply(LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[14].y)), Local77);
	FLWCVector2 Local79 = LWCAdd(LWCPromote(MaterialFloat2(Local65,Local65)), Local78);
	FLWCVector2 Local80 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,0.50000000)), Local79);
	FLWCScalar Local81 = LWCDot(Local80, LWCPromote(Material.PreshaderBuffer[16].xy));
	FLWCScalar Local82 = LWCDot(Local80, LWCPromote(Material.PreshaderBuffer[16].zw));
	FLWCVector2 Local83 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,-0.50000000)), MakeLWCVector(LWCPromote(Local81),LWCPromote(Local82)));
	MaterialFloat2 Local84 = LWCApplyAddressMode(Local83, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local85 = MaterialStoreTexCoordScale(Parameters, Local84, 0);
	MaterialFloat4 Local86 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,Local84,View.MaterialTextureMipBias));
	MaterialFloat Local87 = MaterialStoreTexSample(Parameters, Local86, 0);
	MaterialFloat Local88 = PositiveClampedPow(Local86.r,Material.PreshaderBuffer[17].y);
	MaterialFloat Local89 = (Local88 * Material.PreshaderBuffer[17].z);
	MaterialFloat Local90 = (View.GameTime * Material.PreshaderBuffer[17].w);
	MaterialFloat Local91 = (Local90 * 0.50000000);
	FLWCVector2 Local92 = LWCMultiply(LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[18].x)), Local77);
	FLWCVector2 Local93 = LWCAdd(LWCPromote(MaterialFloat2(Local91,Local91)), Local92);
	FLWCVector2 Local94 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,0.50000000)), Local93);
	FLWCScalar Local95 = LWCDot(Local94, LWCPromote(Material.PreshaderBuffer[20].xy));
	FLWCScalar Local96 = LWCDot(Local94, LWCPromote(Material.PreshaderBuffer[20].zw));
	FLWCVector2 Local97 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,-0.50000000)), MakeLWCVector(LWCPromote(Local95),LWCPromote(Local96)));
	MaterialFloat2 Local98 = LWCApplyAddressMode(Local97, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local99 = MaterialStoreTexCoordScale(Parameters, Local98, 0);
	MaterialFloat4 Local100 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,Local98,View.MaterialTextureMipBias));
	MaterialFloat Local101 = MaterialStoreTexSample(Parameters, Local100, 0);
	MaterialFloat Local102 = PositiveClampedPow(Local100.r,Material.PreshaderBuffer[21].y);
	MaterialFloat Local103 = (Local102 * Material.PreshaderBuffer[21].z);
	MaterialFloat Local104 = (Local89 + Local103);
	MaterialFloat Local105 = (View.GameTime * Material.PreshaderBuffer[21].w);
	MaterialFloat Local106 = (Local105 * 0.50000000);
	FLWCVector2 Local107 = LWCMultiply(LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[22].x)), Local77);
	FLWCVector2 Local108 = LWCAdd(LWCPromote(MaterialFloat2(Local106,Local106)), Local107);
	FLWCVector2 Local109 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,0.50000000)), Local108);
	FLWCScalar Local110 = LWCDot(Local109, LWCPromote(Material.PreshaderBuffer[24].xy));
	FLWCScalar Local111 = LWCDot(Local109, LWCPromote(Material.PreshaderBuffer[24].zw));
	FLWCVector2 Local112 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,-0.50000000)), MakeLWCVector(LWCPromote(Local110),LWCPromote(Local111)));
	MaterialFloat2 Local113 = LWCApplyAddressMode(Local112, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local114 = MaterialStoreTexCoordScale(Parameters, Local113, 0);
	MaterialFloat4 Local115 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,Local113,View.MaterialTextureMipBias));
	MaterialFloat Local116 = MaterialStoreTexSample(Parameters, Local115, 0);
	MaterialFloat Local117 = PositiveClampedPow(Local115.r,Material.PreshaderBuffer[25].y);
	MaterialFloat Local118 = (Local117 * Material.PreshaderBuffer[25].z);
	MaterialFloat Local119 = (Local104 + Local118);
	MaterialFloat4 Local120 = Parameters.VertexColor;
	MaterialFloat Local121 = DERIV_BASE_VALUE(Local120).r;
	MaterialFloat Local122 = lerp(Local119,1.00000000,DERIV_BASE_VALUE(Local121));
	MaterialFloat Local123 = PositiveClampedPow(Local122,Material.PreshaderBuffer[25].w);
	MaterialFloat Local124 = (Local123 * Material.PreshaderBuffer[26].x);
	MaterialFloat3 Local125 = lerp(Local53,Local63,Local124);
	MaterialFloat Local126 = (Local39.r * Material.PreshaderBuffer[28].y);
	MaterialFloat Local127 = PositiveClampedPow(Local126,Material.PreshaderBuffer[28].z);
	MaterialFloat Local128 = saturate(Local127);
	MaterialFloat3 Local129 = lerp(Local125,Material.PreshaderBuffer[29].xyz,Local128);
	MaterialFloat Local130 = (Local50 * Material.PreshaderBuffer[30].w);
	MaterialFloat Local131 = saturate(Local130);
	MaterialFloat Local132 = (Material.PreshaderBuffer[31].x * Local131);
	MaterialFloat Local133 = dot(WorldNormalCopy,Parameters.CameraVector);
	MaterialFloat Local134 = max(0.00000000,Local133);
	MaterialFloat Local135 = (1.00000000 - Local134);
	MaterialFloat Local136 = abs(Local135);
	MaterialFloat Local137 = max(Local136,0.00010000);
	MaterialFloat Local138 = PositiveClampedPow(Local137,Material.PreshaderBuffer[31].y);
	MaterialFloat Local139 = (Local138 * (1.00000000 - 0.04000000));
	MaterialFloat Local140 = (Local139 + 0.04000000);
	MaterialFloat Local141 = lerp(Material.PreshaderBuffer[31].z,1.00000000,Local140);

	PixelMaterialInputs.EmissiveColor = Local48;
	PixelMaterialInputs.Opacity = Local132;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local129;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[29].w;
	PixelMaterialInputs.Roughness = Material.PreshaderBuffer[30].x;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = MaterialFloat3(Local43,Local47);
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat3(MaterialFloat2(Local141,0.0f),Material.PreshaderBuffer[31].w);
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