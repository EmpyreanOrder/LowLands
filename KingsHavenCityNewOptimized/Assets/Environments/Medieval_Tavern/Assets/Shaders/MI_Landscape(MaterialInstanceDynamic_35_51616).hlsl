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
TEXTURE2D(       Material_Texture2D_12 );
SAMPLER(  samplerMaterial_Texture2D_12 );
float4 Material_Texture2D_12_TexelSize;
float4 Material_Texture2D_12_ST;
TEXTURE2D(       Material_Texture2D_13 );
SAMPLER(  samplerMaterial_Texture2D_13 );
float4 Material_Texture2D_13_TexelSize;
float4 Material_Texture2D_13_ST;
TEXTURE2D(       Material_Texture2D_14 );
SAMPLER(  samplerMaterial_Texture2D_14 );
float4 Material_Texture2D_14_TexelSize;
float4 Material_Texture2D_14_ST;
TEXTURE2D(       Material_Texture2D_15 );
SAMPLER(  samplerMaterial_Texture2D_15 );
float4 Material_Texture2D_15_TexelSize;
float4 Material_Texture2D_15_ST;
TEXTURE2D(       Material_Texture2D_16 );
SAMPLER(  samplerMaterial_Texture2D_16 );
float4 Material_Texture2D_16_TexelSize;
float4 Material_Texture2D_16_ST;
TEXTURE2D(       Material_Texture2D_17 );
SAMPLER(  samplerMaterial_Texture2D_17 );
float4 Material_Texture2D_17_TexelSize;
float4 Material_Texture2D_17_ST;
TEXTURE2D(       Material_Texture2D_18 );
SAMPLER(  samplerMaterial_Texture2D_18 );
float4 Material_Texture2D_18_TexelSize;
float4 Material_Texture2D_18_ST;
TEXTURE2D(       Material_Texture2D_19 );
SAMPLER(  samplerMaterial_Texture2D_19 );
float4 Material_Texture2D_19_TexelSize;
float4 Material_Texture2D_19_ST;
TEXTURE2D(       Material_Texture2D_20 );
SAMPLER(  samplerMaterial_Texture2D_20 );
float4 Material_Texture2D_20_TexelSize;
float4 Material_Texture2D_20_ST;
TEXTURE2D(       Material_Texture2D_21 );
SAMPLER(  samplerMaterial_Texture2D_21 );
float4 Material_Texture2D_21_TexelSize;
float4 Material_Texture2D_21_ST;
TEXTURE2D(       Material_Texture2D_22 );
SAMPLER(  samplerMaterial_Texture2D_22 );
float4 Material_Texture2D_22_TexelSize;
float4 Material_Texture2D_22_ST;
TEXTURE2D(       Material_Texture2D_23 );
SAMPLER(  samplerMaterial_Texture2D_23 );
float4 Material_Texture2D_23_TexelSize;
float4 Material_Texture2D_23_ST;

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
	Material.PreshaderBuffer[1] = float4(2017.000000,2017.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(2017.000000,2017.000000,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.500000,0.010000,2000.000000,2000.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000500,-2.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.000000,0.000000,0.000000,1.557060);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat3 CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat CliffWeight,MaterialFloat GrassWeight,MaterialFloat DirtWeight,MaterialFloat SnowWeight,MaterialFloat RockCliifWeight,MaterialFloat Cliff,MaterialFloat Grass,MaterialFloat Dirt,MaterialFloat Snow,MaterialFloat RockCliif)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = CliffWeight.r + GrassWeight.r + DirtWeight.r + SnowWeight.r + RockCliifWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(CliffWeight,CliffWeight,CliffWeight) * Cliff;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(DirtWeight,DirtWeight,DirtWeight) * Dirt;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(SnowWeight,SnowWeight,SnowWeight) * Snow;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(RockCliifWeight,RockCliifWeight,RockCliifWeight) * RockCliif;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat CliffWeight,MaterialFloat GrassWeight,MaterialFloat DirtWeight,MaterialFloat SnowWeight,MaterialFloat RockCliifWeight,MaterialFloat3 Cliff,MaterialFloat3 Grass,MaterialFloat3 Dirt,MaterialFloat3 Snow,MaterialFloat3 RockCliif)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = CliffWeight.r + GrassWeight.r + DirtWeight.r + SnowWeight.r + RockCliifWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(CliffWeight,CliffWeight,CliffWeight) * Cliff;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(DirtWeight,DirtWeight,DirtWeight) * Dirt;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(SnowWeight,SnowWeight,SnowWeight) * Snow;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(RockCliifWeight,RockCliifWeight,RockCliifWeight) * RockCliif;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat CliffWeight,MaterialFloat GrassWeight,MaterialFloat DirtWeight,MaterialFloat SnowWeight,MaterialFloat RockCliifWeight,MaterialFloat3 Cliff,MaterialFloat3 Grass,MaterialFloat3 Dirt,MaterialFloat3 Snow,MaterialFloat3 RockCliif)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = CliffWeight.r + GrassWeight.r + DirtWeight.r + SnowWeight.r + RockCliifWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(CliffWeight,CliffWeight,CliffWeight) * Cliff;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(DirtWeight,DirtWeight,DirtWeight) * Dirt;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(SnowWeight,SnowWeight,SnowWeight) * Snow;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(RockCliifWeight,RockCliifWeight,RockCliifWeight) * RockCliif;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
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
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) + MaterialFloat4(0.00099157,0.00099157,0.00099157,0.00099157).rg);
	MaterialFloat2 Local2 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[2].xy);
	MaterialFloat Local3 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local2), 3);
	MaterialFloat4 Local4 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local2),View.MaterialTextureMipBias));
	MaterialFloat Local5 = MaterialStoreTexSample(Parameters, Local4, 3);
	MaterialFloat3 Local6 = lerp(Local4.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[2].z);
	MaterialFloat Local7 = (Local6.b + 1.00000000);
	MaterialFloat2 Local8 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[2].w));
	MaterialFloat Local9 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local8), 20);
	MaterialFloat4 Local10 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local8)));
	MaterialFloat Local11 = MaterialStoreTexSample(Parameters, Local10, 20);
	MaterialFloat4 Local12 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local8)));
	MaterialFloat Local13 = MaterialStoreTexSample(Parameters, Local12, 20);
	MaterialFloat4 Local14 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local8)));
	MaterialFloat Local15 = MaterialStoreTexSample(Parameters, Local14, 20);
	MaterialFloat4 Local16 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local8)));
	MaterialFloat Local17 = MaterialStoreTexSample(Parameters, Local16, 20);
	MaterialFloat4 Local18 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local8)));
	MaterialFloat Local19 = MaterialStoreTexSample(Parameters, Local18, 20);
	MaterialFloat2 Local20 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)Material.PreshaderBuffer[3].x));
	MaterialFloat Local21 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 18);
	MaterialFloat4 Local22 = UnpackNormalMap(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local23 = MaterialStoreTexSample(Parameters, Local22, 18);
	MaterialFloat2 Local24 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)Material.PreshaderBuffer[3].y));
	MaterialFloat Local25 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 18);
	MaterialFloat4 Local26 = UnpackNormalMap(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local27 = MaterialStoreTexSample(Parameters, Local26, 18);
	MaterialFloat Local28 = GetPixelDepth(Parameters);
	MaterialFloat Local29 = DERIV_BASE_VALUE(Local28).r;
	MaterialFloat Local30 = (DERIV_BASE_VALUE(Local29) - Material.PreshaderBuffer[3].z);
	MaterialFloat Local31 = (DERIV_BASE_VALUE(Local30) * Material.PreshaderBuffer[4].x);
	MaterialFloat Local32 = saturate(DERIV_BASE_VALUE(Local31));
	MaterialFloat3 Local33 = lerp(Local22.rgb,Local26.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local34 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 8);
	MaterialFloat4 Local35 = UnpackNormalMap(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local36 = MaterialStoreTexSample(Parameters, Local35, 8);
	MaterialFloat Local37 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 8);
	MaterialFloat4 Local38 = UnpackNormalMap(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local39 = MaterialStoreTexSample(Parameters, Local38, 8);
	MaterialFloat3 Local40 = lerp(Local35.rgb,Local38.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local41 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 12);
	MaterialFloat4 Local42 = UnpackNormalMap(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local43 = MaterialStoreTexSample(Parameters, Local42, 12);
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 12);
	MaterialFloat4 Local45 = UnpackNormalMap(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 12);
	MaterialFloat3 Local47 = lerp(Local42.rgb,Local45.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local48 = lerp(Local47,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[4].y);
	MaterialFloat Local49 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 15);
	MaterialFloat4 Local50 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local20),View.MaterialTextureMipBias));
	MaterialFloat Local51 = MaterialStoreTexSample(Parameters, Local50, 15);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 15);
	MaterialFloat4 Local53 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local24),View.MaterialTextureMipBias));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 15);
	MaterialFloat3 Local55 = lerp(Local50.rgb,Local53.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local56 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 5);
	MaterialFloat4 Local57 = UnpackNormalMap(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local58 = MaterialStoreTexSample(Parameters, Local57, 5);
	MaterialFloat Local59 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 5);
	MaterialFloat4 Local60 = UnpackNormalMap(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local61 = MaterialStoreTexSample(Parameters, Local60, 5);
	MaterialFloat3 Local62 = lerp(Local57.rgb,Local60.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local63 = CustomExpression0(Parameters,Local10.r,Local12.r,Local14.r,Local16.r,Local18.r,Local33,Local40,Local48,Local55,Local62);
	MaterialFloat2 Local64 = (Local63.rgb.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat Local65 = dot(MaterialFloat3(Local6.rg,Local7),MaterialFloat3(Local64,Local63.rgb.b));
	MaterialFloat3 Local66 = (MaterialFloat3(Local6.rg,Local7) * ((MaterialFloat3)Local65));
	MaterialFloat3 Local67 = (((MaterialFloat3)Local7) * MaterialFloat3(Local64,Local63.rgb.b));
	MaterialFloat3 Local68 = (Local66 - Local67);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local68;


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
	MaterialFloat3 Local69 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[5].xyz,Material.PreshaderBuffer[4].z);
	MaterialFloat Local70 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local2), 2);
	MaterialFloat4 Local71 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_11,samplerMaterial_Texture2D_11,DERIV_BASE_VALUE(Local2),View.MaterialTextureMipBias));
	MaterialFloat Local72 = MaterialStoreTexSample(Parameters, Local71, 2);
	MaterialFloat3 Local73 = (Local71.rgb * ((MaterialFloat3)Material.PreshaderBuffer[5].w));
	MaterialFloat2 Local74 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)0.21340001));
	MaterialFloat Local75 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local74), 1);
	MaterialFloat4 Local76 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_12,samplerMaterial_Texture2D_12,DERIV_BASE_VALUE(Local74),View.MaterialTextureMipBias));
	MaterialFloat Local77 = MaterialStoreTexSample(Parameters, Local76, 1);
	MaterialFloat Local78 = (Local76.r + 0.50000000);
	MaterialFloat2 Local79 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)0.05341000));
	MaterialFloat Local80 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local79), 1);
	MaterialFloat4 Local81 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_12,samplerMaterial_Texture2D_12,DERIV_BASE_VALUE(Local79),View.MaterialTextureMipBias));
	MaterialFloat Local82 = MaterialStoreTexSample(Parameters, Local81, 1);
	MaterialFloat Local83 = (Local81.r + 0.50000000);
	MaterialFloat2 Local84 = (DERIV_BASE_VALUE(Local2) * ((MaterialFloat2)0.00200000));
	MaterialFloat Local85 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local84), 1);
	MaterialFloat4 Local86 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_12,samplerMaterial_Texture2D_12,DERIV_BASE_VALUE(Local84),View.MaterialTextureMipBias));
	MaterialFloat Local87 = MaterialStoreTexSample(Parameters, Local86, 1);
	MaterialFloat Local88 = (Local86.r + 0.50000000);
	MaterialFloat Local89 = (Local83 * Local88);
	MaterialFloat Local90 = (Local78 * Local89);
	MaterialFloat3 Local91 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)1.00000000),Local90);
	MaterialFloat3 Local92 = (Local73 * Local91);
	MaterialFloat Local93 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local2), 0);
	MaterialFloat4 Local94 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_13,samplerMaterial_Texture2D_13,DERIV_BASE_VALUE(Local2),View.MaterialTextureMipBias));
	MaterialFloat Local95 = MaterialStoreTexSample(Parameters, Local94, 0);
	MaterialFloat3 Local96 = lerp(((MaterialFloat3)1.00000000),Local94.rgb,Material.PreshaderBuffer[6].x);
	MaterialFloat3 Local97 = (Local92 * Local96);
	MaterialFloat Local98 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 17);
	MaterialFloat4 Local99 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local100 = MaterialStoreTexSample(Parameters, Local99, 17);
	MaterialFloat Local101 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 17);
	MaterialFloat4 Local102 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local103 = MaterialStoreTexSample(Parameters, Local102, 17);
	MaterialFloat3 Local104 = lerp(Local99.rgb,Local102.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local105 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 7);
	MaterialFloat4 Local106 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local107 = MaterialStoreTexSample(Parameters, Local106, 7);
	MaterialFloat Local108 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 7);
	MaterialFloat4 Local109 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local110 = MaterialStoreTexSample(Parameters, Local109, 7);
	MaterialFloat3 Local111 = lerp(Local106.rgb,Local109.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local112 = (Local111 * MaterialFloat3(0.31770799,0.31770799,0.31770799));
	MaterialFloat Local113 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 11);
	MaterialFloat4 Local114 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local115 = MaterialStoreTexSample(Parameters, Local114, 11);
	MaterialFloat Local116 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 11);
	MaterialFloat4 Local117 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local118 = MaterialStoreTexSample(Parameters, Local117, 11);
	MaterialFloat3 Local119 = lerp(Local114.rgb,Local117.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local120 = (Local119 * MaterialFloat3(0.27604201,0.27604201,0.27604201));
	MaterialFloat Local121 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 14);
	MaterialFloat4 Local122 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_17,samplerMaterial_Texture2D_17,DERIV_BASE_VALUE(Local20),View.MaterialTextureMipBias));
	MaterialFloat Local123 = MaterialStoreTexSample(Parameters, Local122, 14);
	MaterialFloat Local124 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 14);
	MaterialFloat4 Local125 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_17,samplerMaterial_Texture2D_17,DERIV_BASE_VALUE(Local24),View.MaterialTextureMipBias));
	MaterialFloat Local126 = MaterialStoreTexSample(Parameters, Local125, 14);
	MaterialFloat3 Local127 = lerp(Local122.rgb,Local125.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local128 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 4);
	MaterialFloat4 Local129 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local130 = MaterialStoreTexSample(Parameters, Local129, 4);
	MaterialFloat Local131 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 4);
	MaterialFloat4 Local132 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local133 = MaterialStoreTexSample(Parameters, Local132, 4);
	MaterialFloat3 Local134 = lerp(Local129.rgb,Local132.rgb,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local135 = CustomExpression1(Parameters,Local10.r,Local12.r,Local14.r,Local16.r,Local18.r,Local104,Local112,Local120,Local127,Local134);
	MaterialFloat3 Local136 = (Local97 * Local135.rgb);
	MaterialFloat3 Local137 = (Local136 * Local91);
	MaterialFloat3 Local138 = (Local97 * ((MaterialFloat3)Material.PreshaderBuffer[5].w));
	MaterialFloat Local139 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 19);
	MaterialFloat4 Local140 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local141 = MaterialStoreTexSample(Parameters, Local140, 19);
	MaterialFloat Local142 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 19);
	MaterialFloat4 Local143 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local144 = MaterialStoreTexSample(Parameters, Local143, 19);
	MaterialFloat Local145 = lerp(Local140.g,Local143.g,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local146 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 9);
	MaterialFloat4 Local147 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_20,GetMaterialSharedSampler(samplerMaterial_Texture2D_20,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local148 = MaterialStoreTexSample(Parameters, Local147, 9);
	MaterialFloat Local149 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 9);
	MaterialFloat4 Local150 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_20,GetMaterialSharedSampler(samplerMaterial_Texture2D_20,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local151 = MaterialStoreTexSample(Parameters, Local150, 9);
	MaterialFloat Local152 = lerp(Local147.g,Local150.g,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local153 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 13);
	MaterialFloat4 Local154 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_21,GetMaterialSharedSampler(samplerMaterial_Texture2D_21,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local155 = MaterialStoreTexSample(Parameters, Local154, 13);
	MaterialFloat Local156 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 13);
	MaterialFloat4 Local157 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_21,GetMaterialSharedSampler(samplerMaterial_Texture2D_21,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local158 = MaterialStoreTexSample(Parameters, Local157, 13);
	MaterialFloat Local159 = lerp(Local154.g,Local157.g,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local160 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 16);
	MaterialFloat4 Local161 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_22,samplerMaterial_Texture2D_22,DERIV_BASE_VALUE(Local20),View.MaterialTextureMipBias));
	MaterialFloat Local162 = MaterialStoreTexSample(Parameters, Local161, 16);
	MaterialFloat Local163 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 16);
	MaterialFloat4 Local164 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_22,samplerMaterial_Texture2D_22,DERIV_BASE_VALUE(Local24),View.MaterialTextureMipBias));
	MaterialFloat Local165 = MaterialStoreTexSample(Parameters, Local164, 16);
	MaterialFloat Local166 = lerp(Local161.g,Local164.g,DERIV_BASE_VALUE(Local32));
	MaterialFloat Local167 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local20), 6);
	MaterialFloat4 Local168 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_23,GetMaterialSharedSampler(samplerMaterial_Texture2D_23,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local20)));
	MaterialFloat Local169 = MaterialStoreTexSample(Parameters, Local168, 6);
	MaterialFloat Local170 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local24), 6);
	MaterialFloat4 Local171 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_23,GetMaterialSharedSampler(samplerMaterial_Texture2D_23,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local24)));
	MaterialFloat Local172 = MaterialStoreTexSample(Parameters, Local171, 6);
	MaterialFloat Local173 = lerp(Local168.g,Local171.g,DERIV_BASE_VALUE(Local32));
	MaterialFloat3 Local174 = CustomExpression2(Parameters,Local10.r,Local12.r,Local14.r,Local16.r,Local18.r,Local145,Local152,Local159,Local166,Local173);
	MaterialFloat3 Local175 = (((MaterialFloat3)Local174.r) * Local91);
	MaterialFloat3 Local176 = (Local175 * ((MaterialFloat3)10.00000000));

	PixelMaterialInputs.EmissiveColor = Local69;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local137;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local138;
	PixelMaterialInputs.Roughness = Local176;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local68;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
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