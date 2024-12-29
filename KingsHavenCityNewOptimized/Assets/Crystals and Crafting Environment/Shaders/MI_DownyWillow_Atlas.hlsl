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
	float4 PreshaderBuffer[19];
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
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.000000,10.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.300000,0.900000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.000000,1.240000,1.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(10000.000000,0.000100,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.620000,0.610000,1.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.610000,0.620000,0.380000,1.500000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.953974,1.000000,0.460000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.953974,1.000000,0.460000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.046026,0.000000,0.540000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(-0.848000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(-0.848000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.848000,0.000000,0.000000,0.200000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
}struct MaterialCollection0Type
{
	float4 Vectors[5];
};
//MPC_GlobalFoliageActor
MaterialCollection0Type MaterialCollection0;
void Initialize_MaterialCollection0()
{
	MaterialCollection0.Vectors[0] = float4(0.000000,5.000000,2.000000,0.300000);//Wind Direction,Wind Noise,Wind Strength,Wind Speed
	MaterialCollection0.Vectors[1] = float4(0.500000,10.000000,0.000000,1.000000);//Wind Tiling,Health,Season Strength,Season Saturation
	MaterialCollection0.Vectors[2] = float4(0.500000,1.000000,1.000000,0.750000);//Season Brightness,Variation Tiling,Macro Variation Tiling,Random Color Variation
	MaterialCollection0.Vectors[3] = float4(1.200000,0.000000,0.000000,0.000000);//Overall Color Variation,,,
	MaterialCollection0.Vectors[4] = float4(0.000000,0.000000,0.000000,0.000000);//Directional Light
}

MaterialFloat3 CustomExpression9(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression8(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat3 CustomExpression7(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression6(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression5(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression4(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression3(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression2(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression1(FMaterialVertexParameters Parameters,MaterialFloat InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat2 p)
{
return Mod( ((uint)(p.x) + 2 * (uint)(p.y)) , 5 );
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	MaterialFloat4 Local53 = MaterialCollection0.Vectors[0];
	MaterialFloat Local54 = CustomExpression1(Parameters,Local53.b);
	MaterialFloat Local55 = (Local54 * 0.10000000);
	MaterialFloat Local56 = (Local55 * 0.50000000);
	MaterialFloat Local57 = (View.GameTime * Local56);
	MaterialFloat Local58 = (Local57 * -0.50000000);
	MaterialFloat3 Local59 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb) * ((MaterialFloat3)Local58));
	FLWCVector3 Local60 = GetWorldPosition(Parameters);
	FLWCVector3 Local61 = LWCDivide(DERIV_BASE_VALUE(Local60), ((MaterialFloat3)1024.00000000));
	FLWCVector3 Local62 = LWCAdd(LWCPromote(Local59), DERIV_BASE_VALUE(Local61));
	FLWCVector3 Local63 = LWCAdd(Local62, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local64 = LWCFrac(Local63);
	MaterialFloat3 Local65 = (Local64 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local66 = (Local65 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local67 = abs(Local66);
	MaterialFloat3 Local68 = (Local67 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local69 = (((MaterialFloat3)3.00000000) - Local68);
	MaterialFloat3 Local70 = (Local69 * Local67);
	MaterialFloat3 Local71 = (Local70 * Local67);
	MaterialFloat Local72 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),Local71);
	FLWCVector3 Local73 = LWCDivide(DERIV_BASE_VALUE(Local60), ((MaterialFloat3)200.00000000));
	FLWCVector3 Local74 = LWCAdd(LWCPromote(((MaterialFloat3)Local58)), DERIV_BASE_VALUE(Local73));
	FLWCVector3 Local75 = LWCAdd(Local74, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local76 = LWCFrac(Local75);
	MaterialFloat3 Local77 = (Local76 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local78 = (Local77 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local79 = abs(Local78);
	MaterialFloat3 Local80 = (Local79 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local81 = (((MaterialFloat3)3.00000000) - Local80);
	MaterialFloat3 Local82 = (Local81 * Local79);
	MaterialFloat3 Local83 = (Local82 * Local79);
	MaterialFloat3 Local84 = (Local83 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local85 = length(Local84);
	MaterialFloat Local86 = (Local72 + Local85);
	MaterialFloat Local87 = (Local86 * 6.28318548);
	MaterialFloat4 Local88 = Parameters.VertexColor;
	MaterialFloat Local89 = DERIV_BASE_VALUE(Local88).r;
	MaterialFloat Local90 = (View.GameTime * 0.20000000);
	MaterialFloat Local91 = (Local90 * 6.28318548);
	MaterialFloat Local92 = sin(Local91);
	MaterialFloat Local93 = (DERIV_BASE_VALUE(Local92) + 2.00000000);
	FLWCVector2 Local94 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local60)), LWCGetY(DERIV_BASE_VALUE(Local60)));
	FLWCVector2 Local95 = LWCMultiply(DERIV_BASE_VALUE(Local94), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local96 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local95), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local97 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local96,-1.00000000));
	FLWCVector3 Local98 = LWCMultiply(DERIV_BASE_VALUE(Local60), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local99 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local98), 0),LWCGetComponent(DERIV_BASE_VALUE(Local98), 1));
	FLWCVector2 Local100 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local99));
	MaterialFloat Local101 = CustomExpression2(Parameters,Local53.r);
	MaterialFloat Local102 = (Local101 * 6.28318548);
	MaterialFloat Local103 = cos(Local102);
	MaterialFloat Local104 = sin(Local102);
	MaterialFloat Local105 = (Local104 * -1.00000000);
	FLWCScalar Local106 = LWCDot(DERIV_BASE_VALUE(Local100), LWCPromote(MaterialFloat2(Local103,Local105)));
	FLWCScalar Local107 = LWCDot(DERIV_BASE_VALUE(Local100), LWCPromote(MaterialFloat2(Local104,Local103)));
	FLWCVector2 Local108 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local106),LWCPromote(Local107)));
	MaterialFloat4 Local109 = MaterialCollection0.Vectors[1];
	MaterialFloat Local110 = CustomExpression3(Parameters,Local109.r);
	FLWCVector2 Local111 = LWCMultiply(Local108, LWCPromote(((MaterialFloat2)Local110)));
	MaterialFloat Local112 = CustomExpression4(Parameters,Local53.a);
	MaterialFloat Local113 = (Local112 * 0.10000000);
	MaterialFloat Local114 = (View.RealTime * Local113);
	FLWCVector2 Local115 = LWCAdd(Local111, LWCPromote(((MaterialFloat2)Local114)));
	FLWCVector2 Local116 = LWCAdd(LWCPromote(MaterialFloat2(Local97.r,Local97.g)), Local115);
	FLWCVector2 Local117 = LWCLerp(Local116,Local115,0.89999998);
	FLWCVector2 Local118 = LWCMultiply(Local117, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local119 = LWCApplyAddressMode(Local118, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local120 = Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local119,-1.00000000);
	MaterialFloat2 Local121 = LWCApplyAddressMode(Local117, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local122 = Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local121,-1.00000000);
	MaterialFloat3 Local123 = lerp(Local120.rgb,Local122.rgb,0.50000000);
	MaterialFloat Local124 = (View.RealTime * 0.20000000);
	MaterialFloat Local125 = (Local124 * 6.28318548);
	MaterialFloat Local126 = cos(Local125);
	MaterialFloat Local127 = (DERIV_BASE_VALUE(Local126) + 1.00000000);
	MaterialFloat Local128 = (DERIV_BASE_VALUE(Local127) * 0.05000000);
	MaterialFloat3 Local129 = (Local123 + ((MaterialFloat3)DERIV_BASE_VALUE(Local128)));
	MaterialFloat3 Local130 = saturate(Local129);
	MaterialFloat Local131 = (Local55 * 0.01000000);
	MaterialFloat3 Local132 = (Local130 * ((MaterialFloat3)Local131));
	MaterialFloat3 Local133 = (((MaterialFloat3)DERIV_BASE_VALUE(Local93)) * Local132);
	MaterialFloat3 Local134 = (((MaterialFloat3)DERIV_BASE_VALUE(Local89)) * Local133);
	MaterialFloat3 Local135 = saturate(Local134);
	MaterialFloat3 Local136 = (Local135 * ((MaterialFloat3)6.28318548));
	MaterialFloat Local137 = CustomExpression5(Parameters,Local53.r);
	MaterialFloat Local138 = (1.00000000 - Local137);
	MaterialFloat Local139 = (Local138 + 0.85000002);
	MaterialFloat Local140 = (Local139 * 6.28318548);
	MaterialFloat Local141 = cos(Local140);
	MaterialFloat Local142 = sin(Local140);
	FLWCVector3 Local143 = TransformLocalPositionToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local144 = RotateAboutAxis(MaterialFloat4(MaterialFloat3(MaterialFloat2(Local141,Local142),0.0f),Local136.x),Local143,DERIV_BASE_VALUE(Local60));
	MaterialFloat3 Local145 = (Local144 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local146 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local87),Local145,Local144);
	MaterialFloat Local147 = DERIV_BASE_VALUE(Local88).g;
	MaterialFloat3 Local148 = (Local146 * ((MaterialFloat3)DERIV_BASE_VALUE(Local147)));
	MaterialFloat Local149 = (Local53.g * 0.03000000);
	MaterialFloat Local150 = (Local130.r * 0.00500000);
	MaterialFloat Local151 = (Local149 + Local150);
	MaterialFloat Local152 = (Local151 * Material.PreshaderBuffer[9].z);
	MaterialFloat Local153 = CustomExpression6(Parameters,Local152);
	MaterialFloat3 Local154 = (Local148 * ((MaterialFloat3)Local153));
	MaterialFloat3 Local155 = (Local154 + Local144);
	MaterialFloat3 Local156 = (Local155 * ((MaterialFloat3)Material.PreshaderBuffer[9].w));
	MaterialFloat3 Local157 = CustomExpression7(Parameters,Local156);
	return Local157;;
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
	MaterialFloat Local1 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 5);
	MaterialFloat4 Local2 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local3 = MaterialStoreTexSample(Parameters, Local2, 5);
	MaterialFloat3 Local4 = lerp(Local2.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[1].y);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local4;


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
	MaterialFloat3 Local5 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[2].xyz,Material.PreshaderBuffer[1].z);
	MaterialFloat Local6 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 7);
	MaterialFloat4 Local7 = ProcessMaterialVirtualColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local8 = MaterialStoreTexSample(Parameters, Local7, 7);
	MaterialFloat3 Local9 = (Local7.rgb * Material.PreshaderBuffer[5].xyz);
	MaterialFloat3 Local10 = (Local9 * ((MaterialFloat3)Material.PreshaderBuffer[5].w));
	MaterialFloat Local11 = dot(Local10,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local12 = lerp(Local10,((MaterialFloat3)Local11),Material.PreshaderBuffer[6].y);
	MaterialFloat Local13 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local14 = Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias);
	MaterialFloat Local15 = MaterialStoreTexSample(Parameters, Local14, 8);
	MaterialFloat Local16 = (1.00000000 - Local14.g);
	MaterialFloat Local17 = dot(Local16,Material.PreshaderBuffer[6].z);
	MaterialFloat Local18 = saturate(Local17);
	MaterialFloat Local19 = (Local18 * 0.50000000);
	MaterialFloat Local20 = lerp(0.00000000,Local19,Material.PreshaderBuffer[6].w);
	MaterialFloat Local21 = lerp(0.00000000,Local19,Material.PreshaderBuffer[7].x);
	MaterialFloat Local22 = PositiveClampedPow(Local14.b,5.00000000);
	MaterialFloat Local23 = (Local22 * 25000.00000000);
	MaterialFloat Local24 = saturate(Local23);
	MaterialFloat Local25 = lerp(Local20,Local21,Local24);
	MaterialFloat Local26 = (Local14.g * Material.PreshaderBuffer[7].y);
	MaterialFloat Local27 = PositiveClampedPow(Local26,Material.PreshaderBuffer[7].z);
	MaterialFloat Local28 = lerp(Material.PreshaderBuffer[8].x,Material.PreshaderBuffer[7].w,Local27);
	MaterialFloat Local29 = (Local14.g * Material.PreshaderBuffer[8].y);
	MaterialFloat Local30 = PositiveClampedPow(Local29,Material.PreshaderBuffer[8].z);
	MaterialFloat Local31 = lerp(Material.PreshaderBuffer[8].x,Material.PreshaderBuffer[7].w,Local30);
	MaterialFloat Local32 = lerp(Local28,Local31,Local24);
	MaterialFloat Local33 = (Local14.r * Material.PreshaderBuffer[8].w);
	FLWCVector3 Local34 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local35 = LWCSubtract(GetObjectWorldPosition(Parameters), Local34);
	MaterialFloat Local36 = length(LWCToFloat(Local35));
	MaterialFloat Local37 = (DERIV_BASE_VALUE(Local36) * Material.PreshaderBuffer[9].y);
	MaterialFloat Local38 = (DERIV_BASE_VALUE(Local37) - 0.10000000);
	MaterialFloat Local39 = saturate(DERIV_BASE_VALUE(Local38));
	MaterialFloat Local40 = lerp(Local14.r,Local33,DERIV_BASE_VALUE(Local39));
	MaterialFloat2 Local41 = GetPixelPosition(Parameters);
	MaterialFloat Local42 = View.TemporalAAParams.x;
	MaterialFloat2 Local43 = (Local41 + MaterialFloat2(Local42,Local42));
	MaterialFloat Local44 = CustomExpression0(Parameters,Local43);
	MaterialFloat2 Local45 = (Local41 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local46 = MaterialStoreTexCoordScale(Parameters, Local45, 6);
	MaterialFloat4 Local47 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,Local45,View.MaterialTextureMipBias));
	MaterialFloat Local48 = MaterialStoreTexSample(Parameters, Local47, 6);
	MaterialFloat Local49 = (Local44 + Local47.r);
	MaterialFloat Local50 = (Local49 * 0.16665000);
	MaterialFloat Local51 = (Local40 + Local50);
	MaterialFloat Local52 = (Local51 + -0.50000000);
	MaterialFloat Local158 = (Local14.b * Material.PreshaderBuffer[11].x);
	MaterialFloat3 Local159 = (Local12 * ((MaterialFloat3)Local158));
	MaterialFloat Local160 = dot(Local159,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local161 = lerp(Local159,((MaterialFloat3)Local160),Material.PreshaderBuffer[11].z);
	MaterialFloat3 Local162 = PositiveClampedPow(Local161,((MaterialFloat3)Material.PreshaderBuffer[11].w));
	MaterialFloat3 Local163 = (((MaterialFloat3)1.00000000) - Local162);
	MaterialFloat3 Local164 = (Local163 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local165 = (Local164 * Material.PreshaderBuffer[14].xyz);
	MaterialFloat3 Local166 = (((MaterialFloat3)1.00000000) - Local165);
	MaterialFloat3 Local167 = (Local162 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local168 = (Local167 * Material.PreshaderBuffer[13].xyz);
	MaterialFloat Local169 = select((Local162.r >= 0.50000000), Local166.r, Local168.r);
	MaterialFloat Local170 = select((Local162.g >= 0.50000000), Local166.g, Local168.g);
	MaterialFloat Local171 = select((Local162.b >= 0.50000000), Local166.b, Local168.b);
	MaterialFloat3 Local172 = lerp(Local162,MaterialFloat3(MaterialFloat2(Local169,Local170),Local171),Material.PreshaderBuffer[14].w);
	MaterialFloat3 Local173 = (((MaterialFloat3)1.00000000) - Local172);
	MaterialFloat3 Local174 = (Local173 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local175 = (Local174 * Material.PreshaderBuffer[17].xyz);
	MaterialFloat3 Local176 = (((MaterialFloat3)1.00000000) - Local175);
	MaterialFloat3 Local177 = (Local172 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local178 = (Local177 * Material.PreshaderBuffer[16].xyz);
	MaterialFloat Local179 = select((Local172.r >= 0.50000000), Local176.r, Local178.r);
	MaterialFloat Local180 = select((Local172.g >= 0.50000000), Local176.g, Local178.g);
	MaterialFloat Local181 = select((Local172.b >= 0.50000000), Local176.b, Local178.b);
	MaterialFloat4 Local182 = Parameters.VertexColor;
	MaterialFloat Local183 = DERIV_BASE_VALUE(Local182).a;
	MaterialFloat3 Local184 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)DERIV_BASE_VALUE(Local183)),Local24);
	MaterialFloat3 Local185 = lerp(Local172,MaterialFloat3(MaterialFloat2(Local179,Local180),Local181),Local184);
	MaterialFloat3 Local186 = lerp(Local172,Local185,Material.PreshaderBuffer[17].w);

	PixelMaterialInputs.EmissiveColor = Local5;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local52;
	PixelMaterialInputs.BaseColor = Local12;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local25;
	PixelMaterialInputs.Roughness = Local32;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local4;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local186,Material.PreshaderBuffer[18].x);
	PixelMaterialInputs.AmbientOcclusion = Local14.a;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 6;
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
	Initialize_MaterialCollection0();

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
	Initialize_MaterialCollection0();


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
	if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}