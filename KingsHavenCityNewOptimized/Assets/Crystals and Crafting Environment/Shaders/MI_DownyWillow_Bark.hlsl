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
	float4 PreshaderBuffer[10];
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
	Material.PreshaderBuffer[1] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,2.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,2.000000,-1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.620000,0.911000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.620000,0.380000,0.911000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.500000,10.000000,0.500000,0.500000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,2.000000,0.000000,0.000000);//(Unknown)
}
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
	MaterialFloat4 Local65 = MaterialCollection0.Vectors[0];
	MaterialFloat Local66 = CustomExpression1(Parameters,Local65.b);
	MaterialFloat Local67 = (Local66 * 0.10000000);
	MaterialFloat Local68 = (Local67 * 0.50000000);
	MaterialFloat Local69 = (View.GameTime * Local68);
	MaterialFloat Local70 = (Local69 * -0.50000000);
	MaterialFloat3 Local71 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb) * ((MaterialFloat3)Local70));
	FLWCVector3 Local72 = GetWorldPosition(Parameters);
	FLWCVector3 Local73 = LWCDivide(DERIV_BASE_VALUE(Local72), ((MaterialFloat3)1024.00000000));
	FLWCVector3 Local74 = LWCAdd(LWCPromote(Local71), DERIV_BASE_VALUE(Local73));
	FLWCVector3 Local75 = LWCAdd(Local74, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local76 = LWCFrac(Local75);
	MaterialFloat3 Local77 = (Local76 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local78 = (Local77 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local79 = abs(Local78);
	MaterialFloat3 Local80 = (Local79 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local81 = (((MaterialFloat3)3.00000000) - Local80);
	MaterialFloat3 Local82 = (Local81 * Local79);
	MaterialFloat3 Local83 = (Local82 * Local79);
	MaterialFloat Local84 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),Local83);
	FLWCVector3 Local85 = LWCDivide(DERIV_BASE_VALUE(Local72), ((MaterialFloat3)200.00000000));
	FLWCVector3 Local86 = LWCAdd(LWCPromote(((MaterialFloat3)Local70)), DERIV_BASE_VALUE(Local85));
	FLWCVector3 Local87 = LWCAdd(Local86, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local88 = LWCFrac(Local87);
	MaterialFloat3 Local89 = (Local88 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local90 = (Local89 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local91 = abs(Local90);
	MaterialFloat3 Local92 = (Local91 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local93 = (((MaterialFloat3)3.00000000) - Local92);
	MaterialFloat3 Local94 = (Local93 * Local91);
	MaterialFloat3 Local95 = (Local94 * Local91);
	MaterialFloat3 Local96 = (Local95 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local97 = length(Local96);
	MaterialFloat Local98 = (Local84 + Local97);
	MaterialFloat Local99 = (Local98 * 6.28318548);
	MaterialFloat4 Local100 = Parameters.VertexColor;
	MaterialFloat Local101 = DERIV_BASE_VALUE(Local100).r;
	MaterialFloat Local102 = (View.GameTime * 0.20000000);
	MaterialFloat Local103 = (Local102 * 6.28318548);
	MaterialFloat Local104 = sin(Local103);
	MaterialFloat Local105 = (DERIV_BASE_VALUE(Local104) + 2.00000000);
	FLWCVector2 Local106 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local72)), LWCGetY(DERIV_BASE_VALUE(Local72)));
	FLWCVector2 Local107 = LWCMultiply(DERIV_BASE_VALUE(Local106), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local108 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local107), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local109 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local108,-1.00000000));
	FLWCVector3 Local110 = LWCMultiply(DERIV_BASE_VALUE(Local72), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local111 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local110), 0),LWCGetComponent(DERIV_BASE_VALUE(Local110), 1));
	FLWCVector2 Local112 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local111));
	MaterialFloat Local113 = CustomExpression2(Parameters,Local65.r);
	MaterialFloat Local114 = (Local113 * 6.28318548);
	MaterialFloat Local115 = cos(Local114);
	MaterialFloat Local116 = sin(Local114);
	MaterialFloat Local117 = (Local116 * -1.00000000);
	FLWCScalar Local118 = LWCDot(DERIV_BASE_VALUE(Local112), LWCPromote(MaterialFloat2(Local115,Local117)));
	FLWCScalar Local119 = LWCDot(DERIV_BASE_VALUE(Local112), LWCPromote(MaterialFloat2(Local116,Local115)));
	FLWCVector2 Local120 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local118),LWCPromote(Local119)));
	MaterialFloat4 Local121 = MaterialCollection0.Vectors[1];
	MaterialFloat Local122 = CustomExpression3(Parameters,Local121.r);
	FLWCVector2 Local123 = LWCMultiply(Local120, LWCPromote(((MaterialFloat2)Local122)));
	MaterialFloat Local124 = CustomExpression4(Parameters,Local65.a);
	MaterialFloat Local125 = (Local124 * 0.10000000);
	MaterialFloat Local126 = (View.RealTime * Local125);
	FLWCVector2 Local127 = LWCAdd(Local123, LWCPromote(((MaterialFloat2)Local126)));
	FLWCVector2 Local128 = LWCAdd(LWCPromote(MaterialFloat2(Local109.r,Local109.g)), Local127);
	FLWCVector2 Local129 = LWCLerp(Local128,Local127,0.89999998);
	FLWCVector2 Local130 = LWCMultiply(Local129, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local131 = LWCApplyAddressMode(Local130, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local132 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local131,-1.00000000);
	MaterialFloat2 Local133 = LWCApplyAddressMode(Local129, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local134 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local133,-1.00000000);
	MaterialFloat3 Local135 = lerp(Local132.rgb,Local134.rgb,0.50000000);
	MaterialFloat Local136 = (View.RealTime * 0.20000000);
	MaterialFloat Local137 = (Local136 * 6.28318548);
	MaterialFloat Local138 = cos(Local137);
	MaterialFloat Local139 = (DERIV_BASE_VALUE(Local138) + 1.00000000);
	MaterialFloat Local140 = (DERIV_BASE_VALUE(Local139) * 0.05000000);
	MaterialFloat3 Local141 = (Local135 + ((MaterialFloat3)DERIV_BASE_VALUE(Local140)));
	MaterialFloat3 Local142 = saturate(Local141);
	MaterialFloat Local143 = (Local67 * 0.01000000);
	MaterialFloat3 Local144 = (Local142 * ((MaterialFloat3)Local143));
	MaterialFloat3 Local145 = (((MaterialFloat3)DERIV_BASE_VALUE(Local105)) * Local144);
	MaterialFloat3 Local146 = (((MaterialFloat3)DERIV_BASE_VALUE(Local101)) * Local145);
	MaterialFloat3 Local147 = saturate(Local146);
	MaterialFloat3 Local148 = (Local147 * ((MaterialFloat3)6.28318548));
	MaterialFloat Local149 = CustomExpression5(Parameters,Local65.r);
	MaterialFloat Local150 = (1.00000000 - Local149);
	MaterialFloat Local151 = (Local150 + 0.85000002);
	MaterialFloat Local152 = (Local151 * 6.28318548);
	MaterialFloat Local153 = cos(Local152);
	MaterialFloat Local154 = sin(Local152);
	FLWCVector3 Local155 = TransformLocalPositionToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local156 = RotateAboutAxis(MaterialFloat4(MaterialFloat3(MaterialFloat2(Local153,Local154),0.0f),Local148.x),Local155,DERIV_BASE_VALUE(Local72));
	MaterialFloat3 Local157 = (Local156 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local158 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local99),Local157,Local156);
	MaterialFloat Local159 = DERIV_BASE_VALUE(Local100).g;
	MaterialFloat3 Local160 = (Local158 * ((MaterialFloat3)DERIV_BASE_VALUE(Local159)));
	MaterialFloat Local161 = (Local65.g * 0.03000000);
	MaterialFloat Local162 = (Local142.r * 0.00500000);
	MaterialFloat Local163 = (Local161 + Local162);
	MaterialFloat Local164 = (Local163 * Material.PreshaderBuffer[9].x);
	MaterialFloat Local165 = CustomExpression6(Parameters,Local164);
	MaterialFloat3 Local166 = (Local160 * ((MaterialFloat3)Local165));
	MaterialFloat3 Local167 = (Local166 + Local156);
	MaterialFloat3 Local168 = (Local167 * ((MaterialFloat3)Material.PreshaderBuffer[9].y));
	MaterialFloat3 Local169 = CustomExpression7(Parameters,Local168);
	return Local169;;
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
	MaterialFloat Local1 = DERIV_BASE_VALUE(Local0).r;
	MaterialFloat Local2 = (DERIV_BASE_VALUE(Local1) * Material.PreshaderBuffer[2].x);
	MaterialFloat Local3 = DERIV_BASE_VALUE(Local0).g;
	MaterialFloat Local4 = (DERIV_BASE_VALUE(Local3) * Material.PreshaderBuffer[2].y);
	MaterialFloat2 Local5 = MaterialFloat2(DERIV_BASE_VALUE(Local2),DERIV_BASE_VALUE(Local4));
	MaterialFloat2 Local6 = (((MaterialFloat2)Material.PreshaderBuffer[2].z) * DERIV_BASE_VALUE(Local5));
	MaterialFloat Local7 = DERIV_BASE_VALUE(Local6).r;
	MaterialFloat Local8 = (DERIV_BASE_VALUE(Local7) + Material.PreshaderBuffer[2].w);
	MaterialFloat Local9 = DERIV_BASE_VALUE(Local6).g;
	MaterialFloat Local10 = (DERIV_BASE_VALUE(Local9) + Material.PreshaderBuffer[3].x);
	MaterialFloat2 Local11 = MaterialFloat2(DERIV_BASE_VALUE(Local8),DERIV_BASE_VALUE(Local10));
	MaterialFloat Local12 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 9);
	MaterialFloat4 Local13 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local11),View.MaterialTextureMipBias));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 9);
	MaterialFloat3 Local15 = lerp(Local13.rgb,MaterialFloat3(0.00000000,0.00000000,1.00000000),Material.PreshaderBuffer[3].z);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local15;


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
	MaterialFloat3 Local16 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[4].xyz,Material.PreshaderBuffer[3].w);
	MaterialFloat Local17 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 7);
	MaterialFloat4 Local18 = ProcessMaterialVirtualColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local11),View.MaterialTextureMipBias));
	MaterialFloat Local19 = MaterialStoreTexSample(Parameters, Local18, 7);
	MaterialFloat Local20 = dot(Local18.rgb,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local21 = lerp(Local18.rgb,((MaterialFloat3)Local20),Material.PreshaderBuffer[6].y);
	MaterialFloat3 Local22 = (Local21 * ((MaterialFloat3)Material.PreshaderBuffer[6].z));
	MaterialFloat3 Local23 = PositiveClampedPow(Local22,((MaterialFloat3)Material.PreshaderBuffer[6].w));
	MaterialFloat Local24 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 10);
	MaterialFloat4 Local25 = Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local11),View.MaterialTextureMipBias);
	MaterialFloat Local26 = MaterialStoreTexSample(Parameters, Local25, 10);
	MaterialFloat Local27 = (Local25.r * 2.50000000);
	MaterialFloat Local28 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 11);
	MaterialFloat4 Local29 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local11),View.MaterialTextureMipBias));
	MaterialFloat Local30 = MaterialStoreTexSample(Parameters, Local29, 11);
	MaterialFloat Local31 = (Local29.r * 0.20000000);
	MaterialFloat Local32 = lerp(Local27,Local31,0.50000000);
	MaterialFloat3 Local33 = (Local23 * ((MaterialFloat3)Local32));
	MaterialFloat3 Local34 = lerp(Local23,Local33,Material.PreshaderBuffer[7].x);
	MaterialFloat Local35 = (1.00000000 - Local25.g);
	MaterialFloat Local36 = lerp(Local35,Local25.r,0.50000000);
	MaterialFloat Local37 = dot(Local36,Material.PreshaderBuffer[7].y);
	MaterialFloat Local38 = saturate(Local37);
	MaterialFloat Local39 = (Local38 * 0.50000000);
	MaterialFloat Local40 = lerp(0.00000000,Local39,Material.PreshaderBuffer[7].z);
	MaterialFloat Local41 = (Local25.g * Material.PreshaderBuffer[7].w);
	MaterialFloat Local42 = PositiveClampedPow(Local41,Material.PreshaderBuffer[8].x);
	MaterialFloat Local43 = (Local42 * 2.00000000);
	MaterialFloat Local44 = saturate(Local43);
	MaterialFloat Local45 = lerp(Material.PreshaderBuffer[8].z,Material.PreshaderBuffer[8].y,Local44);
	MaterialFloat4 Local46 = Parameters.VertexColor;
	MaterialFloat Local47 = DERIV_BASE_VALUE(Local46).a;
	MaterialFloat Local48 = (DERIV_BASE_VALUE(Local47) * 1.20000005);
	MaterialFloat Local49 = lerp(Local25.r,Local29.r,0.20000000);
	MaterialFloat Local50 = (Local49 * 5.00000000);
	MaterialFloat Local51 = PositiveClampedPow(DERIV_BASE_VALUE(Local48),Local50);
	MaterialFloat Local52 = PositiveClampedPow(Local51,Material.PreshaderBuffer[8].w);
	MaterialFloat2 Local53 = GetPixelPosition(Parameters);
	MaterialFloat Local54 = View.TemporalAAParams.x;
	MaterialFloat2 Local55 = (Local53 + MaterialFloat2(Local54,Local54));
	MaterialFloat Local56 = CustomExpression0(Parameters,Local55);
	MaterialFloat2 Local57 = (Local53 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local58 = MaterialStoreTexCoordScale(Parameters, Local57, 6);
	MaterialFloat4 Local59 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local57,View.MaterialTextureMipBias));
	MaterialFloat Local60 = MaterialStoreTexSample(Parameters, Local59, 6);
	MaterialFloat Local61 = (Local56 + Local59.r);
	MaterialFloat Local62 = (Local61 * 0.16665000);
	MaterialFloat Local63 = (Local52 + Local62);
	MaterialFloat Local64 = (Local63 + -0.50000000);

	PixelMaterialInputs.EmissiveColor = Local16;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local64;
	PixelMaterialInputs.BaseColor = Local34;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local40;
	PixelMaterialInputs.Roughness = Local45;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local15;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local25.r;
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