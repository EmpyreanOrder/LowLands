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
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.920000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.100000,-0.100000,10.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.300000,0.920000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.000000,1.000000,1.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.500000,10000.000000,0.000100,0.200000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(10.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,0.720000,1.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.720000,1.000000,0.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.500000,1.000000,0.200000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.500000,1.000000,0.200000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.500000,0.000000,0.800000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat4 Local57 = MaterialCollection0.Vectors[0];
	MaterialFloat Local58 = CustomExpression1(Parameters,Local57.b);
	MaterialFloat Local59 = (Local58 * 0.10000000);
	MaterialFloat Local60 = (Local59 * 0.50000000);
	MaterialFloat Local61 = (View.GameTime * Local60);
	MaterialFloat Local62 = (Local61 * -0.50000000);
	MaterialFloat3 Local63 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb) * ((MaterialFloat3)Local62));
	FLWCVector3 Local64 = GetWorldPosition(Parameters);
	FLWCVector3 Local65 = LWCDivide(DERIV_BASE_VALUE(Local64), ((MaterialFloat3)1024.00000000));
	FLWCVector3 Local66 = LWCAdd(LWCPromote(Local63), DERIV_BASE_VALUE(Local65));
	FLWCVector3 Local67 = LWCAdd(Local66, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local68 = LWCFrac(Local67);
	MaterialFloat3 Local69 = (Local68 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local70 = (Local69 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local71 = abs(Local70);
	MaterialFloat3 Local72 = (Local71 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local73 = (((MaterialFloat3)3.00000000) - Local72);
	MaterialFloat3 Local74 = (Local73 * Local71);
	MaterialFloat3 Local75 = (Local74 * Local71);
	MaterialFloat Local76 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),Local75);
	FLWCVector3 Local77 = LWCDivide(DERIV_BASE_VALUE(Local64), ((MaterialFloat3)200.00000000));
	FLWCVector3 Local78 = LWCAdd(LWCPromote(((MaterialFloat3)Local62)), DERIV_BASE_VALUE(Local77));
	FLWCVector3 Local79 = LWCAdd(Local78, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local80 = LWCFrac(Local79);
	MaterialFloat3 Local81 = (Local80 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local82 = (Local81 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local83 = abs(Local82);
	MaterialFloat3 Local84 = (Local83 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local85 = (((MaterialFloat3)3.00000000) - Local84);
	MaterialFloat3 Local86 = (Local85 * Local83);
	MaterialFloat3 Local87 = (Local86 * Local83);
	MaterialFloat3 Local88 = (Local87 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local89 = length(Local88);
	MaterialFloat Local90 = (Local76 + Local89);
	MaterialFloat Local91 = (Local90 * 6.28318548);
	MaterialFloat4 Local92 = Parameters.VertexColor;
	MaterialFloat Local93 = DERIV_BASE_VALUE(Local92).r;
	MaterialFloat Local94 = (View.GameTime * 0.20000000);
	MaterialFloat Local95 = (Local94 * 6.28318548);
	MaterialFloat Local96 = sin(Local95);
	MaterialFloat Local97 = (DERIV_BASE_VALUE(Local96) + 2.00000000);
	FLWCVector2 Local98 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local64)), LWCGetY(DERIV_BASE_VALUE(Local64)));
	FLWCVector2 Local99 = LWCMultiply(DERIV_BASE_VALUE(Local98), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local100 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local99), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local101 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local100,-1.00000000));
	FLWCVector3 Local102 = LWCMultiply(DERIV_BASE_VALUE(Local64), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local103 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local102), 0),LWCGetComponent(DERIV_BASE_VALUE(Local102), 1));
	FLWCVector2 Local104 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local103));
	MaterialFloat Local105 = CustomExpression2(Parameters,Local57.r);
	MaterialFloat Local106 = (Local105 * 6.28318548);
	MaterialFloat Local107 = cos(Local106);
	MaterialFloat Local108 = sin(Local106);
	MaterialFloat Local109 = (Local108 * -1.00000000);
	FLWCScalar Local110 = LWCDot(DERIV_BASE_VALUE(Local104), LWCPromote(MaterialFloat2(Local107,Local109)));
	FLWCScalar Local111 = LWCDot(DERIV_BASE_VALUE(Local104), LWCPromote(MaterialFloat2(Local108,Local107)));
	FLWCVector2 Local112 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local110),LWCPromote(Local111)));
	MaterialFloat4 Local113 = MaterialCollection0.Vectors[1];
	MaterialFloat Local114 = CustomExpression3(Parameters,Local113.r);
	FLWCVector2 Local115 = LWCMultiply(Local112, LWCPromote(((MaterialFloat2)Local114)));
	MaterialFloat Local116 = CustomExpression4(Parameters,Local57.a);
	MaterialFloat Local117 = (Local116 * 0.10000000);
	MaterialFloat Local118 = (View.RealTime * Local117);
	FLWCVector2 Local119 = LWCAdd(Local115, LWCPromote(((MaterialFloat2)Local118)));
	FLWCVector2 Local120 = LWCAdd(LWCPromote(MaterialFloat2(Local101.r,Local101.g)), Local119);
	FLWCVector2 Local121 = LWCLerp(Local120,Local119,0.89999998);
	FLWCVector2 Local122 = LWCMultiply(Local121, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local123 = LWCApplyAddressMode(Local122, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local124 = Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local123,-1.00000000);
	MaterialFloat2 Local125 = LWCApplyAddressMode(Local121, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local126 = Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local125,-1.00000000);
	MaterialFloat3 Local127 = lerp(Local124.rgb,Local126.rgb,0.50000000);
	MaterialFloat Local128 = (View.RealTime * 0.20000000);
	MaterialFloat Local129 = (Local128 * 6.28318548);
	MaterialFloat Local130 = cos(Local129);
	MaterialFloat Local131 = (DERIV_BASE_VALUE(Local130) + 1.00000000);
	MaterialFloat Local132 = (DERIV_BASE_VALUE(Local131) * 0.05000000);
	MaterialFloat3 Local133 = (Local127 + ((MaterialFloat3)DERIV_BASE_VALUE(Local132)));
	MaterialFloat3 Local134 = saturate(Local133);
	MaterialFloat Local135 = (Local59 * 0.01000000);
	MaterialFloat3 Local136 = (Local134 * ((MaterialFloat3)Local135));
	MaterialFloat3 Local137 = (((MaterialFloat3)DERIV_BASE_VALUE(Local97)) * Local136);
	MaterialFloat3 Local138 = (((MaterialFloat3)DERIV_BASE_VALUE(Local93)) * Local137);
	MaterialFloat3 Local139 = saturate(Local138);
	MaterialFloat3 Local140 = (Local139 * ((MaterialFloat3)6.28318548));
	MaterialFloat Local141 = CustomExpression5(Parameters,Local57.r);
	MaterialFloat Local142 = (1.00000000 - Local141);
	MaterialFloat Local143 = (Local142 + 0.85000002);
	MaterialFloat Local144 = (Local143 * 6.28318548);
	MaterialFloat Local145 = cos(Local144);
	MaterialFloat Local146 = sin(Local144);
	FLWCVector3 Local147 = TransformLocalPositionToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local148 = RotateAboutAxis(MaterialFloat4(MaterialFloat3(MaterialFloat2(Local145,Local146),0.0f),Local140.x),Local147,DERIV_BASE_VALUE(Local64));
	MaterialFloat3 Local149 = (Local148 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local150 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local91),Local149,Local148);
	MaterialFloat Local151 = DERIV_BASE_VALUE(Local92).g;
	MaterialFloat3 Local152 = (Local150 * ((MaterialFloat3)DERIV_BASE_VALUE(Local151)));
	MaterialFloat Local153 = (Local57.g * 0.03000000);
	MaterialFloat Local154 = (Local134.r * 0.00500000);
	MaterialFloat Local155 = (Local153 + Local154);
	MaterialFloat Local156 = (Local155 * Material.PreshaderBuffer[9].w);
	MaterialFloat Local157 = CustomExpression6(Parameters,Local156);
	MaterialFloat3 Local158 = (Local152 * ((MaterialFloat3)Local157));
	MaterialFloat3 Local159 = (Local158 + Local148);
	MaterialFloat3 Local160 = (Local159 * ((MaterialFloat3)Material.PreshaderBuffer[10].x));
	MaterialFloat3 Local161 = CustomExpression7(Parameters,Local160);
	return Local161;;
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
	MaterialFloat Local33 = (Material.PreshaderBuffer[8].w * Local32);
	MaterialFloat Local34 = saturate(Local33);
	MaterialFloat Local35 = saturate(Parameters.TwoSidedSign);
	MaterialFloat Local36 = lerp(Local34,Local32,DERIV_BASE_VALUE(Local35));
	MaterialFloat Local37 = (Local14.r * Material.PreshaderBuffer[9].x);
	FLWCVector3 Local38 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local39 = LWCSubtract(GetObjectWorldPosition(Parameters), Local38);
	MaterialFloat Local40 = length(LWCToFloat(Local39));
	MaterialFloat Local41 = (DERIV_BASE_VALUE(Local40) * Material.PreshaderBuffer[9].z);
	MaterialFloat Local42 = (DERIV_BASE_VALUE(Local41) - 0.10000000);
	MaterialFloat Local43 = saturate(DERIV_BASE_VALUE(Local42));
	MaterialFloat Local44 = lerp(Local14.r,Local37,DERIV_BASE_VALUE(Local43));
	MaterialFloat2 Local45 = GetPixelPosition(Parameters);
	MaterialFloat Local46 = View.TemporalAAParams.x;
	MaterialFloat2 Local47 = (Local45 + MaterialFloat2(Local46,Local46));
	MaterialFloat Local48 = CustomExpression0(Parameters,Local47);
	MaterialFloat2 Local49 = (Local45 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local50 = MaterialStoreTexCoordScale(Parameters, Local49, 6);
	MaterialFloat4 Local51 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,Local49,View.MaterialTextureMipBias));
	MaterialFloat Local52 = MaterialStoreTexSample(Parameters, Local51, 6);
	MaterialFloat Local53 = (Local48 + Local51.r);
	MaterialFloat Local54 = (Local53 * 0.16665000);
	MaterialFloat Local55 = (Local44 + Local54);
	MaterialFloat Local56 = (Local55 + -0.50000000);
	MaterialFloat Local162 = (Local14.b * Material.PreshaderBuffer[12].x);
	MaterialFloat3 Local163 = (Local12 * ((MaterialFloat3)Local162));
	MaterialFloat Local164 = dot(Local163,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local165 = lerp(Local163,((MaterialFloat3)Local164),Material.PreshaderBuffer[12].z);
	MaterialFloat3 Local166 = PositiveClampedPow(Local165,((MaterialFloat3)Material.PreshaderBuffer[12].w));
	MaterialFloat3 Local167 = (((MaterialFloat3)1.00000000) - Local166);
	MaterialFloat3 Local168 = (Local167 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local169 = (Local168 * Material.PreshaderBuffer[15].xyz);
	MaterialFloat3 Local170 = (((MaterialFloat3)1.00000000) - Local169);
	MaterialFloat3 Local171 = (Local166 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local172 = (Local171 * Material.PreshaderBuffer[14].xyz);
	MaterialFloat Local173 = select((Local166.r >= 0.50000000), Local170.r, Local172.r);
	MaterialFloat Local174 = select((Local166.g >= 0.50000000), Local170.g, Local172.g);
	MaterialFloat Local175 = select((Local166.b >= 0.50000000), Local170.b, Local172.b);
	MaterialFloat3 Local176 = lerp(Local166,MaterialFloat3(MaterialFloat2(Local173,Local174),Local175),Material.PreshaderBuffer[15].w);
	MaterialFloat3 Local177 = (((MaterialFloat3)1.00000000) - Local176);
	MaterialFloat3 Local178 = (Local177 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local179 = (Local178 * Material.PreshaderBuffer[18].xyz);
	MaterialFloat3 Local180 = (((MaterialFloat3)1.00000000) - Local179);
	MaterialFloat3 Local181 = (Local176 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local182 = (Local181 * Material.PreshaderBuffer[17].xyz);
	MaterialFloat Local183 = select((Local176.r >= 0.50000000), Local180.r, Local182.r);
	MaterialFloat Local184 = select((Local176.g >= 0.50000000), Local180.g, Local182.g);
	MaterialFloat Local185 = select((Local176.b >= 0.50000000), Local180.b, Local182.b);
	MaterialFloat4 Local186 = Parameters.VertexColor;
	MaterialFloat Local187 = DERIV_BASE_VALUE(Local186).a;
	MaterialFloat3 Local188 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)DERIV_BASE_VALUE(Local187)),Local24);
	MaterialFloat3 Local189 = lerp(Local176,MaterialFloat3(MaterialFloat2(Local183,Local184),Local185),Local188);
	MaterialFloat3 Local190 = lerp(Local176,Local189,Material.PreshaderBuffer[18].w);

	PixelMaterialInputs.EmissiveColor = Local5;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local56;
	PixelMaterialInputs.BaseColor = Local12;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local25;
	PixelMaterialInputs.Roughness = Local36;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local4;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local190,Material.PreshaderBuffer[19].x);
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