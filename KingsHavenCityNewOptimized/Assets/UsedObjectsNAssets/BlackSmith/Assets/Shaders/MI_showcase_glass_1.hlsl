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
	float4 PreshaderBuffer[47];
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
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,0.018516,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.018516,0.018516,0.096000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.570440,0.765239,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.556649,0.565972,0.344472,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.000000,0.556649,0.565972,0.344472);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.317581,1.317581,-0.317581,0.223936);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.570440,0.765239,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.699289,0.822917,0.753500,1.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,1.000000,1.000000,0.624000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.000000,0.699289,0.822917,0.753500);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.248000,1.248000,-0.248000,0.154836);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.822917,0.822917,0.822917,1.000000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[34] = float4(0.000000,-0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[35] = float4(1.000000,-0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[36] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[37] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[38] = float4(1.000000,1.000000,1.000000,0.752000);//(Unknown)
	Material.PreshaderBuffer[39] = float4(0.000000,0.822917,0.822917,0.822917);//(Unknown)
	Material.PreshaderBuffer[40] = float4(-0.080000,0.920000,0.080000,0.448000);//(Unknown)
	Material.PreshaderBuffer[41] = float4(5.000000,0.040000,0.960000,1.000000);//(Unknown)
	Material.PreshaderBuffer[42] = float4(0.800000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[43] = float4(0.250000,0.100000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[44] = float4(1.000000,1.000000,-0.853266,0.024000);//(Unknown)
	Material.PreshaderBuffer[45] = float4(0.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[46] = float4(0.470018,0.470018,0.982030,0.000000);//(Unknown)
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

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b);


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
	MaterialFloat Local17 = dot(Material.PreshaderBuffer[10].xyz,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local18 = lerp(Material.PreshaderBuffer[10].xyz,((MaterialFloat3)Local17),Material.PreshaderBuffer[10].w);
	MaterialFloat3 Local19 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[7].x),((MaterialFloat3)0.00000000),Local18);
	MaterialFloat3 Local20 = (Local19 + Local18);
	MaterialFloat3 Local21 = lerp(Local20,Material.PreshaderBuffer[11].yzw,Material.PreshaderBuffer[11].x);
	MaterialFloat Local22 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[16].xy);
	MaterialFloat Local23 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[16].zw);
	MaterialFloat2 Local24 = MaterialFloat2(DERIV_BASE_VALUE(Local22),DERIV_BASE_VALUE(Local23));
	MaterialFloat2 Local25 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local24));
	MaterialFloat2 Local26 = (DERIV_BASE_VALUE(Local25) + Material.PreshaderBuffer[17].zw);
	MaterialFloat2 Local27 = (DERIV_BASE_VALUE(Local26) * Material.PreshaderBuffer[19].yz);
	MaterialFloat Local28 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local27), 1);
	MaterialFloat4 Local29 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local27),View.MaterialTextureMipBias));
	MaterialFloat Local30 = MaterialStoreTexSample(Parameters, Local29, 1);
	MaterialFloat3 Local31 = (Local29.rgb * ((MaterialFloat3)Material.PreshaderBuffer[19].w));
	MaterialFloat Local32 = dot(Local31,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local33 = lerp(Local31,((MaterialFloat3)Local32),Material.PreshaderBuffer[20].x);
	MaterialFloat3 Local34 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[14].y),((MaterialFloat3)0.00000000),Local33);
	MaterialFloat3 Local35 = (Local34 + Local33);
	MaterialFloat3 Local36 = (Material.PreshaderBuffer[20].yzw * Local35);
	MaterialFloat Local37 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local38 = Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local0));
	MaterialFloat Local39 = MaterialStoreTexSample(Parameters, Local38, 0);
	MaterialFloat Local40 = lerp(Material.PreshaderBuffer[21].z,Material.PreshaderBuffer[21].y,Local38.r);
	MaterialFloat Local41 = saturate(Local40);
	MaterialFloat Local42 = (Local41.r * Material.PreshaderBuffer[21].w);
	MaterialFloat Local43 = saturate(Local42);
	MaterialFloat3 Local44 = lerp(Material.PreshaderBuffer[22].xyz,Local36,Local43);
	MaterialFloat Local45 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[26].xy);
	MaterialFloat Local46 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[26].zw);
	MaterialFloat2 Local47 = MaterialFloat2(DERIV_BASE_VALUE(Local45),DERIV_BASE_VALUE(Local46));
	MaterialFloat2 Local48 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local47));
	MaterialFloat2 Local49 = (DERIV_BASE_VALUE(Local48) + Material.PreshaderBuffer[27].zw);
	MaterialFloat2 Local50 = (DERIV_BASE_VALUE(Local49) * Material.PreshaderBuffer[29].yz);
	MaterialFloat Local51 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local50), 1);
	MaterialFloat4 Local52 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local50),View.MaterialTextureMipBias));
	MaterialFloat Local53 = MaterialStoreTexSample(Parameters, Local52, 1);
	MaterialFloat3 Local54 = (Local52.rgb * ((MaterialFloat3)Material.PreshaderBuffer[29].w));
	MaterialFloat Local55 = dot(Local54,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local56 = lerp(Local54,((MaterialFloat3)Local55),Material.PreshaderBuffer[30].x);
	MaterialFloat3 Local57 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[24].y),((MaterialFloat3)0.00000000),Local56);
	MaterialFloat3 Local58 = (Local57 + Local56);
	MaterialFloat3 Local59 = (Material.PreshaderBuffer[30].yzw * Local58);
	MaterialFloat Local60 = lerp(Material.PreshaderBuffer[31].z,Material.PreshaderBuffer[31].y,Local38.g);
	MaterialFloat Local61 = saturate(Local60);
	MaterialFloat Local62 = (Local61.r * Material.PreshaderBuffer[31].w);
	MaterialFloat Local63 = saturate(Local62);
	MaterialFloat3 Local64 = lerp(Local44,Local59,Local63);
	MaterialFloat Local65 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[35].xy);
	MaterialFloat Local66 = dot(DERIV_BASE_VALUE(Local1),Material.PreshaderBuffer[35].zw);
	MaterialFloat2 Local67 = MaterialFloat2(DERIV_BASE_VALUE(Local65),DERIV_BASE_VALUE(Local66));
	MaterialFloat2 Local68 = (MaterialFloat2(0.50000000,0.50000000) + DERIV_BASE_VALUE(Local67));
	MaterialFloat2 Local69 = (DERIV_BASE_VALUE(Local68) + Material.PreshaderBuffer[36].zw);
	MaterialFloat2 Local70 = (DERIV_BASE_VALUE(Local69) * Material.PreshaderBuffer[38].yz);
	MaterialFloat Local71 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local70), 1);
	MaterialFloat4 Local72 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local70),View.MaterialTextureMipBias));
	MaterialFloat Local73 = MaterialStoreTexSample(Parameters, Local72, 1);
	MaterialFloat3 Local74 = (Local72.rgb * ((MaterialFloat3)Material.PreshaderBuffer[38].w));
	MaterialFloat Local75 = dot(Local74,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local76 = lerp(Local74,((MaterialFloat3)Local75),Material.PreshaderBuffer[39].x);
	MaterialFloat3 Local77 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[33].y),((MaterialFloat3)0.00000000),Local76);
	MaterialFloat3 Local78 = (Local77 + Local76);
	MaterialFloat3 Local79 = (Material.PreshaderBuffer[39].yzw * Local78);
	MaterialFloat Local80 = lerp(Material.PreshaderBuffer[40].z,Material.PreshaderBuffer[40].y,Local38.b);
	MaterialFloat Local81 = saturate(Local80);
	MaterialFloat Local82 = (Local81.r * Material.PreshaderBuffer[40].w);
	MaterialFloat Local83 = saturate(Local82);
	MaterialFloat3 Local84 = lerp(Local64,Local79,Local83);
	MaterialFloat Local85 = dot(WorldNormalCopy,Parameters.CameraVector);
	MaterialFloat Local86 = max(0.00000000,Local85);
	MaterialFloat Local87 = (1.00000000 - Local86);
	MaterialFloat Local88 = abs(Local87);
	MaterialFloat Local89 = max(Local88,0.00010000);
	MaterialFloat Local90 = PositiveClampedPow(Local89,Material.PreshaderBuffer[41].x);
	MaterialFloat Local91 = (Local90 * Material.PreshaderBuffer[41].z);
	MaterialFloat Local92 = (Local91 + Material.PreshaderBuffer[41].y);
	MaterialFloat Local93 = lerp(Material.PreshaderBuffer[42].x,Material.PreshaderBuffer[41].w,Local92);
	MaterialFloat Local94 = lerp(Local93,Material.PreshaderBuffer[42].y,Local43);
	MaterialFloat Local95 = lerp(Local94,Material.PreshaderBuffer[42].z,Local63);
	MaterialFloat Local96 = lerp(Local95,Material.PreshaderBuffer[42].w,Local83);
	MaterialFloat Local97 = lerp(0.00000000,Material.PreshaderBuffer[43].x,Local43);
	MaterialFloat Local98 = lerp(Material.PreshaderBuffer[43].z,Material.PreshaderBuffer[43].y,Local92);
	MaterialFloat Local99 = lerp(Local98,Material.PreshaderBuffer[43].w,Local43);
	MaterialFloat Local100 = lerp(Local99,Material.PreshaderBuffer[44].x,Local63);
	MaterialFloat Local101 = lerp(Local100,Material.PreshaderBuffer[44].y,0.50000000);
	MaterialFloat Local102 = lerp(Material.PreshaderBuffer[44].w,Material.PreshaderBuffer[44].z,Local92);
	MaterialFloat Local103 = lerp(Local102,1.00000000,Material.PreshaderBuffer[45].x);
	MaterialFloat Local104 = lerp(Local103,Material.PreshaderBuffer[45].y,Local43);
	MaterialFloat Local105 = lerp(Local104,Material.PreshaderBuffer[45].z,Local63);
	MaterialFloat Local106 = lerp(Local105,Material.PreshaderBuffer[45].w,Local83);
	MaterialFloat Local107 = ((1.00000000 - 0.00000000) * Local106);
	MaterialFloat Local108 = dot(MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b),MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat Local109 = lerp(0.00000000,1.00000000,Material.PreshaderBuffer[46].y);
	MaterialFloat Local110 = (Local108 + Local109);
	MaterialFloat Local111 = lerp(1.00000000,Material.PreshaderBuffer[46].z,Local110);
	MaterialFloat Local112 = lerp(Local111,Material.PreshaderBuffer[46].z,Local92);

	PixelMaterialInputs.EmissiveColor = Local21;
	PixelMaterialInputs.Opacity = Local107;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local84;
	PixelMaterialInputs.Metallic = Local96;
	PixelMaterialInputs.Specular = Local97;
	PixelMaterialInputs.Roughness = Local101;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = MaterialFloat3(MaterialFloat2(Local15,Local16),Local13.b);
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat3(MaterialFloat2(Local112,0.0f),Material.PreshaderBuffer[46].w);
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
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
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}