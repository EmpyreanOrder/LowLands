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
TEXTURE2D(       Material_Texture2D_24 );
SAMPLER(  samplerMaterial_Texture2D_24 );
float4 Material_Texture2D_24_TexelSize;
float4 Material_Texture2D_24_ST;

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
	float4 PreshaderBuffer[5];
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
	Material.PreshaderBuffer[2] = float4(70.111115,70.111115,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(70.111115,70.111115,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat3 CustomExpression3(FMaterialPixelParameters Parameters,MaterialFloat mud_1Weight,MaterialFloat mud_2Weight,MaterialFloat mud_3Weight,MaterialFloat mud_4Weight,MaterialFloat mud_5Weight,MaterialFloat3 mud_1,MaterialFloat3 mud_2,MaterialFloat3 mud_3,MaterialFloat3 mud_4,MaterialFloat3 mud_5)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = mud_1Weight.r + mud_2Weight.r + mud_3Weight.r + mud_4Weight.r + mud_5Weight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(mud_1Weight,mud_1Weight,mud_1Weight) * mud_1;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(mud_2Weight,mud_2Weight,mud_2Weight) * mud_2;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(mud_3Weight,mud_3Weight,mud_3Weight) * mud_3;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(mud_4Weight,mud_4Weight,mud_4Weight) * mud_4;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(mud_5Weight,mud_5Weight,mud_5Weight) * mud_5;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat mud_1Weight,MaterialFloat mud_2Weight,MaterialFloat mud_3Weight,MaterialFloat mud_4Weight,MaterialFloat mud_5Weight,MaterialFloat3 mud_1,MaterialFloat3 mud_2,MaterialFloat3 mud_3,MaterialFloat3 mud_4,MaterialFloat3 mud_5)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = mud_1Weight.r + mud_2Weight.r + mud_3Weight.r + mud_4Weight.r + mud_5Weight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(mud_1Weight,mud_1Weight,mud_1Weight) * mud_1;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(mud_2Weight,mud_2Weight,mud_2Weight) * mud_2;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(mud_3Weight,mud_3Weight,mud_3Weight) * mud_3;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(mud_4Weight,mud_4Weight,mud_4Weight) * mud_4;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(mud_5Weight,mud_5Weight,mud_5Weight) * mud_5;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat mud_1Weight,MaterialFloat mud_2Weight,MaterialFloat mud_3Weight,MaterialFloat mud_4Weight,MaterialFloat mud_5Weight,MaterialFloat3 mud_1,MaterialFloat3 mud_2,MaterialFloat3 mud_3,MaterialFloat3 mud_4,MaterialFloat3 mud_5)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = mud_1Weight.r + mud_2Weight.r + mud_3Weight.r + mud_4Weight.r + mud_5Weight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(mud_1Weight,mud_1Weight,mud_1Weight) * mud_1;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(mud_2Weight,mud_2Weight,mud_2Weight) * mud_2;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(mud_3Weight,mud_3Weight,mud_3Weight) * mud_3;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(mud_4Weight,mud_4Weight,mud_4Weight) * mud_4;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(mud_5Weight,mud_5Weight,mud_5Weight) * mud_5;
float3  Result = Layer0Contribution + Layer1Contribution + Layer2Contribution + Layer3Contribution + Layer4Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat mud_1Weight,MaterialFloat mud_2Weight,MaterialFloat mud_3Weight,MaterialFloat mud_4Weight,MaterialFloat mud_5Weight,MaterialFloat3 mud_1,MaterialFloat3 mud_2,MaterialFloat3 mud_3,MaterialFloat3 mud_4,MaterialFloat3 mud_5)
{
float  lerpres;
float  Local0;





float  AllWeightsAndHeights = mud_1Weight.r + mud_2Weight.r + mud_3Weight.r + mud_4Weight.r + mud_5Weight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(mud_1Weight,mud_1Weight,mud_1Weight) * mud_1;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(mud_2Weight,mud_2Weight,mud_2Weight) * mud_2;
float3  Layer2Contribution = float3(Divider,Divider,Divider) * float3(mud_3Weight,mud_3Weight,mud_3Weight) * mud_3;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(mud_4Weight,mud_4Weight,mud_4Weight) * mud_4;
float3  Layer4Contribution = float3(Divider,Divider,Divider) * float3(mud_5Weight,mud_5Weight,mud_5Weight) * mud_5;
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
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[1].x));
	MaterialFloat Local2 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 26);
	MaterialFloat4 Local3 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local4 = MaterialStoreTexSample(Parameters, Local3, 26);
	MaterialFloat4 Local5 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 26);
	MaterialFloat4 Local7 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local8 = MaterialStoreTexSample(Parameters, Local7, 26);
	MaterialFloat4 Local9 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 26);
	MaterialFloat4 Local11 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(samplerMaterial_Texture2D_4,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local12 = MaterialStoreTexSample(Parameters, Local11, 26);
	MaterialFloat2 Local13 = (DERIV_BASE_VALUE(Local0) + MaterialFloat4(0.00316957,0.00316957,0.00316957,0.00316957).rg);
	MaterialFloat2 Local14 = (DERIV_BASE_VALUE(Local13) * Material.PreshaderBuffer[3].xy);
	MaterialFloat Local15 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 7);
	MaterialFloat4 Local16 = UnpackNormalMap(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(samplerMaterial_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local17 = MaterialStoreTexSample(Parameters, Local16, 7);
	MaterialFloat Local18 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 8);
	MaterialFloat4 Local19 = UnpackNormalMap(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(samplerMaterial_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local20 = MaterialStoreTexSample(Parameters, Local19, 8);
	MaterialFloat Local21 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 9);
	MaterialFloat4 Local22 = UnpackNormalMap(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(samplerMaterial_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local23 = MaterialStoreTexSample(Parameters, Local22, 9);
	MaterialFloat Local24 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 20);
	MaterialFloat4 Local25 = UnpackNormalMap(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local26 = MaterialStoreTexSample(Parameters, Local25, 20);
	MaterialFloat Local27 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 21);
	MaterialFloat4 Local28 = UnpackNormalMap(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(samplerMaterial_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local29 = MaterialStoreTexSample(Parameters, Local28, 21);
	MaterialFloat3 Local30 = CustomExpression0(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local16.rgb,Local19.rgb,Local22.rgb,Local25.rgb,Local28.rgb);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local30;


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
	MaterialFloat3 Local31 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[4].xyz,Material.PreshaderBuffer[3].z);
	MaterialFloat Local32 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 1);
	MaterialFloat4 Local33 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(samplerMaterial_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local34 = MaterialStoreTexSample(Parameters, Local33, 1);
	MaterialFloat Local35 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 2);
	MaterialFloat4 Local36 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local37 = MaterialStoreTexSample(Parameters, Local36, 2);
	MaterialFloat Local38 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 3);
	MaterialFloat4 Local39 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_12,GetMaterialSharedSampler(samplerMaterial_Texture2D_12,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local40 = MaterialStoreTexSample(Parameters, Local39, 3);
	MaterialFloat Local41 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 16);
	MaterialFloat4 Local42 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_13,GetMaterialSharedSampler(samplerMaterial_Texture2D_13,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local43 = MaterialStoreTexSample(Parameters, Local42, 16);
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 17);
	MaterialFloat4 Local45 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_14,GetMaterialSharedSampler(samplerMaterial_Texture2D_14,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 17);
	MaterialFloat3 Local47 = CustomExpression1(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local33.rgb,Local36.rgb,Local39.rgb,Local42.rgb,Local45.rgb);
	MaterialFloat Local48 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 4);
	MaterialFloat4 Local49 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_15,GetMaterialSharedSampler(samplerMaterial_Texture2D_15,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local50 = MaterialStoreTexSample(Parameters, Local49, 4);
	MaterialFloat Local51 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 5);
	MaterialFloat4 Local52 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_16,GetMaterialSharedSampler(samplerMaterial_Texture2D_16,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local53 = MaterialStoreTexSample(Parameters, Local52, 5);
	MaterialFloat Local54 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 6);
	MaterialFloat4 Local55 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_17,GetMaterialSharedSampler(samplerMaterial_Texture2D_17,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local56 = MaterialStoreTexSample(Parameters, Local55, 6);
	MaterialFloat Local57 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 18);
	MaterialFloat4 Local58 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_18,GetMaterialSharedSampler(samplerMaterial_Texture2D_18,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local59 = MaterialStoreTexSample(Parameters, Local58, 18);
	MaterialFloat Local60 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 19);
	MaterialFloat4 Local61 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_19,GetMaterialSharedSampler(samplerMaterial_Texture2D_19,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local62 = MaterialStoreTexSample(Parameters, Local61, 19);
	MaterialFloat3 Local63 = CustomExpression2(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local49.rgb,Local52.rgb,Local55.rgb,Local58.rgb,Local61.rgb);
	MaterialFloat Local64 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 10);
	MaterialFloat4 Local65 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_20,GetMaterialSharedSampler(samplerMaterial_Texture2D_20,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local66 = MaterialStoreTexSample(Parameters, Local65, 10);
	MaterialFloat Local67 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 11);
	MaterialFloat4 Local68 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_21,GetMaterialSharedSampler(samplerMaterial_Texture2D_21,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local69 = MaterialStoreTexSample(Parameters, Local68, 11);
	MaterialFloat Local70 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 12);
	MaterialFloat4 Local71 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_22,GetMaterialSharedSampler(samplerMaterial_Texture2D_22,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local72 = MaterialStoreTexSample(Parameters, Local71, 12);
	MaterialFloat Local73 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 22);
	MaterialFloat4 Local74 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_23,GetMaterialSharedSampler(samplerMaterial_Texture2D_23,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local75 = MaterialStoreTexSample(Parameters, Local74, 22);
	MaterialFloat Local76 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local14), 23);
	MaterialFloat4 Local77 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_24,GetMaterialSharedSampler(samplerMaterial_Texture2D_24,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local14)));
	MaterialFloat Local78 = MaterialStoreTexSample(Parameters, Local77, 23);
	MaterialFloat3 Local79 = CustomExpression3(Parameters,Local3.r,Local5.r,Local7.r,Local9.r,Local11.r,Local65.rgb,Local68.rgb,Local71.rgb,Local74.rgb,Local77.rgb);

	PixelMaterialInputs.EmissiveColor = Local31;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local47;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local63;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local30;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local79;
	PixelMaterialInputs.Refraction = 0;
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