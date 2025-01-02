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
	float4 PreshaderBuffer[28];
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
	Material.PreshaderBuffer[3] = float4(0.411765,0.352941,0.121569,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.411765,0.352941,0.121569,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.588235,0.647059,0.878431,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.176470,1.294118,1.756862,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.823530,0.705882,0.243138,0.411765);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.352941,0.121569,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,0.933614,0.326000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,0.933614,0.326000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.066386,0.674000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.840000,0.160000,0.500000,4.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(4.000000,0.900000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.000000,1.000000,1.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(10000.000000,0.000100,0.100000,10.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.550000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,0.550000,0.450000,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.907315,1.000000,0.430000,0.639216);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.907315,1.000000,0.430000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.092685,0.000000,0.570000,0.639216);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,0.868398,0.590000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,0.868398,0.590000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.000000,0.131602,0.410000,0.600000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat4 Local97 = MaterialCollection0.Vectors[0];
	MaterialFloat Local98 = CustomExpression1(Parameters,Local97.b);
	MaterialFloat Local99 = (Local98 * 0.10000000);
	MaterialFloat Local100 = (Local99 * 0.50000000);
	MaterialFloat Local101 = (View.GameTime * Local100);
	MaterialFloat Local102 = (Local101 * -0.50000000);
	MaterialFloat3 Local103 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb) * ((MaterialFloat3)Local102));
	FLWCVector3 Local104 = GetWorldPosition(Parameters);
	FLWCVector3 Local105 = LWCDivide(DERIV_BASE_VALUE(Local104), ((MaterialFloat3)1024.00000000));
	FLWCVector3 Local106 = LWCAdd(LWCPromote(Local103), DERIV_BASE_VALUE(Local105));
	FLWCVector3 Local107 = LWCAdd(Local106, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local108 = LWCFrac(Local107);
	MaterialFloat3 Local109 = (Local108 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local110 = (Local109 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local111 = abs(Local110);
	MaterialFloat3 Local112 = (Local111 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local113 = (((MaterialFloat3)3.00000000) - Local112);
	MaterialFloat3 Local114 = (Local113 * Local111);
	MaterialFloat3 Local115 = (Local114 * Local111);
	MaterialFloat Local116 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),Local115);
	FLWCVector3 Local117 = LWCDivide(DERIV_BASE_VALUE(Local104), ((MaterialFloat3)200.00000000));
	FLWCVector3 Local118 = LWCAdd(LWCPromote(((MaterialFloat3)Local102)), DERIV_BASE_VALUE(Local117));
	FLWCVector3 Local119 = LWCAdd(Local118, LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local120 = LWCFrac(Local119);
	MaterialFloat3 Local121 = (Local120 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local122 = (Local121 + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local123 = abs(Local122);
	MaterialFloat3 Local124 = (Local123 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local125 = (((MaterialFloat3)3.00000000) - Local124);
	MaterialFloat3 Local126 = (Local125 * Local123);
	MaterialFloat3 Local127 = (Local126 * Local123);
	MaterialFloat3 Local128 = (Local127 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local129 = length(Local128);
	MaterialFloat Local130 = (Local116 + Local129);
	MaterialFloat Local131 = (Local130 * 6.28318548);
	MaterialFloat4 Local132 = Parameters.VertexColor;
	MaterialFloat Local133 = DERIV_BASE_VALUE(Local132).r;
	MaterialFloat Local134 = (View.GameTime * 0.20000000);
	MaterialFloat Local135 = (Local134 * 6.28318548);
	MaterialFloat Local136 = sin(Local135);
	MaterialFloat Local137 = (DERIV_BASE_VALUE(Local136) + 2.00000000);
	FLWCVector2 Local138 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local104)), LWCGetY(DERIV_BASE_VALUE(Local104)));
	FLWCVector2 Local139 = LWCMultiply(DERIV_BASE_VALUE(Local138), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local140 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local139), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local141 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local140,-1.00000000));
	FLWCVector3 Local142 = LWCMultiply(DERIV_BASE_VALUE(Local104), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local143 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local142), 0),LWCGetComponent(DERIV_BASE_VALUE(Local142), 1));
	FLWCVector2 Local144 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local143));
	MaterialFloat Local145 = CustomExpression2(Parameters,Local97.r);
	MaterialFloat Local146 = (Local145 * 6.28318548);
	MaterialFloat Local147 = cos(Local146);
	MaterialFloat Local148 = sin(Local146);
	MaterialFloat Local149 = (Local148 * -1.00000000);
	FLWCScalar Local150 = LWCDot(DERIV_BASE_VALUE(Local144), LWCPromote(MaterialFloat2(Local147,Local149)));
	FLWCScalar Local151 = LWCDot(DERIV_BASE_VALUE(Local144), LWCPromote(MaterialFloat2(Local148,Local147)));
	FLWCVector2 Local152 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local150),LWCPromote(Local151)));
	MaterialFloat4 Local153 = MaterialCollection0.Vectors[1];
	MaterialFloat Local154 = CustomExpression3(Parameters,Local153.r);
	FLWCVector2 Local155 = LWCMultiply(Local152, LWCPromote(((MaterialFloat2)Local154)));
	MaterialFloat Local156 = CustomExpression4(Parameters,Local97.a);
	MaterialFloat Local157 = (Local156 * 0.10000000);
	MaterialFloat Local158 = (View.RealTime * Local157);
	FLWCVector2 Local159 = LWCAdd(Local155, LWCPromote(((MaterialFloat2)Local158)));
	FLWCVector2 Local160 = LWCAdd(LWCPromote(MaterialFloat2(Local141.r,Local141.g)), Local159);
	FLWCVector2 Local161 = LWCLerp(Local160,Local159,0.89999998);
	FLWCVector2 Local162 = LWCMultiply(Local161, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local163 = LWCApplyAddressMode(Local162, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local164 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local163,-1.00000000);
	MaterialFloat2 Local165 = LWCApplyAddressMode(Local161, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local166 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local165,-1.00000000);
	MaterialFloat3 Local167 = lerp(Local164.rgb,Local166.rgb,0.50000000);
	MaterialFloat Local168 = (View.RealTime * 0.20000000);
	MaterialFloat Local169 = (Local168 * 6.28318548);
	MaterialFloat Local170 = cos(Local169);
	MaterialFloat Local171 = (DERIV_BASE_VALUE(Local170) + 1.00000000);
	MaterialFloat Local172 = (DERIV_BASE_VALUE(Local171) * 0.05000000);
	MaterialFloat3 Local173 = (Local167 + ((MaterialFloat3)DERIV_BASE_VALUE(Local172)));
	MaterialFloat3 Local174 = saturate(Local173);
	MaterialFloat Local175 = (Local99 * 0.01000000);
	MaterialFloat3 Local176 = (Local174 * ((MaterialFloat3)Local175));
	MaterialFloat3 Local177 = (((MaterialFloat3)DERIV_BASE_VALUE(Local137)) * Local176);
	MaterialFloat3 Local178 = (((MaterialFloat3)DERIV_BASE_VALUE(Local133)) * Local177);
	MaterialFloat3 Local179 = saturate(Local178);
	MaterialFloat3 Local180 = (Local179 * ((MaterialFloat3)6.28318548));
	MaterialFloat Local181 = CustomExpression5(Parameters,Local97.r);
	MaterialFloat Local182 = (1.00000000 - Local181);
	MaterialFloat Local183 = (Local182 + 0.85000002);
	MaterialFloat Local184 = (Local183 * 6.28318548);
	MaterialFloat Local185 = cos(Local184);
	MaterialFloat Local186 = sin(Local184);
	FLWCVector3 Local187 = TransformLocalPositionToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local188 = RotateAboutAxis(MaterialFloat4(MaterialFloat3(MaterialFloat2(Local185,Local186),0.0f),Local180.x),Local187,DERIV_BASE_VALUE(Local104));
	MaterialFloat3 Local189 = (Local188 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local190 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local131),Local189,Local188);
	MaterialFloat Local191 = DERIV_BASE_VALUE(Local132).g;
	MaterialFloat3 Local192 = (Local190 * ((MaterialFloat3)DERIV_BASE_VALUE(Local191)));
	MaterialFloat Local193 = (Local97.g * 0.03000000);
	MaterialFloat Local194 = (Local174.r * 0.00500000);
	MaterialFloat Local195 = (Local193 + Local194);
	MaterialFloat Local196 = (Local195 * Material.PreshaderBuffer[18].z);
	MaterialFloat Local197 = CustomExpression6(Parameters,Local196);
	MaterialFloat3 Local198 = (Local192 * ((MaterialFloat3)Local197));
	MaterialFloat3 Local199 = (Local198 + Local188);
	MaterialFloat3 Local200 = (Local199 * ((MaterialFloat3)Material.PreshaderBuffer[18].w));
	MaterialFloat3 Local201 = CustomExpression7(Parameters,Local200);
	return Local201;;
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
	MaterialFloat3 Local9 = (((MaterialFloat3)1.00000000) - Local7.rgb);
	MaterialFloat3 Local10 = (Material.PreshaderBuffer[6].xyz * Local9);
	MaterialFloat3 Local11 = (((MaterialFloat3)1.00000000) - Local10);
	MaterialFloat3 Local12 = (Material.PreshaderBuffer[7].xyz * Local7.rgb);
	MaterialFloat Local13 = select((Material.PreshaderBuffer[7].w >= 0.50000000), Local11.r, Local12.r);
	MaterialFloat Local14 = select((Material.PreshaderBuffer[8].x >= 0.50000000), Local11.g, Local12.g);
	MaterialFloat Local15 = select((Material.PreshaderBuffer[8].y >= 0.50000000), Local11.b, Local12.b);
	FLWCVector3 Local16 = GetWorldPosition(Parameters);
	FLWCVector2 Local17 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local16)), LWCGetY(DERIV_BASE_VALUE(Local16)));
	FLWCVector2 Local18 = LWCMultiply(DERIV_BASE_VALUE(Local17), LWCPromote(((MaterialFloat2)0.00100000)));
	MaterialFloat4 Local19 = MaterialCollection0.Vectors[2];
	FLWCVector2 Local20 = LWCMultiply(DERIV_BASE_VALUE(Local18), LWCPromote(((MaterialFloat2)Local19.g)));
	MaterialFloat2 Local21 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local20), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local22 = MaterialStoreTexCoordScale(Parameters, Local21, 2);
	MaterialFloat4 Local23 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,Local21,View.MaterialTextureMipBias));
	MaterialFloat Local24 = MaterialStoreTexSample(Parameters, Local23, 2);
	MaterialFloat3 Local25 = saturate(Local23.rgb);
	FLWCVector2 Local26 = LWCMultiply(DERIV_BASE_VALUE(Local17), LWCPromote(((MaterialFloat2)0.00010000)));
	FLWCVector2 Local27 = LWCMultiply(DERIV_BASE_VALUE(Local26), LWCPromote(((MaterialFloat2)Local19.b)));
	MaterialFloat2 Local28 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local27), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local29 = MaterialStoreTexCoordScale(Parameters, Local28, 2);
	MaterialFloat4 Local30 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,Local28,View.MaterialTextureMipBias));
	MaterialFloat Local31 = MaterialStoreTexSample(Parameters, Local30, 2);
	MaterialFloat3 Local32 = saturate(Local30.rgb);
	MaterialFloat3 Local33 = (Local25 * Local32);
	MaterialFloat3 Local34 = saturate(Local33);
	MaterialFloat3 Local35 = lerp(Local7.rgb,MaterialFloat3(MaterialFloat2(Local13,Local14),Local15),Local34);
	MaterialFloat3 Local36 = (((MaterialFloat3)1.00000000) - Local35);
	MaterialFloat3 Local37 = (Local36 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local38 = (Local37 * Material.PreshaderBuffer[11].xyz);
	MaterialFloat3 Local39 = (((MaterialFloat3)1.00000000) - Local38);
	MaterialFloat3 Local40 = (Local35 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local41 = (Local40 * Material.PreshaderBuffer[10].xyz);
	MaterialFloat Local42 = select((Local35.r >= 0.50000000), Local39.r, Local41.r);
	MaterialFloat Local43 = select((Local35.g >= 0.50000000), Local39.g, Local41.g);
	MaterialFloat Local44 = select((Local35.b >= 0.50000000), Local39.b, Local41.b);
	MaterialFloat Local45 = (GetPerInstanceRandom(Parameters) * Local19.a);
	MaterialFloat Local46 = saturate(Local45);
	MaterialFloat3 Local47 = lerp(Local35,MaterialFloat3(MaterialFloat2(Local42,Local43),Local44),DERIV_BASE_VALUE(Local46));
	MaterialFloat4 Local48 = MaterialCollection0.Vectors[3];
	MaterialFloat Local49 = max(Local48.r,0.00000000);
	MaterialFloat Local50 = min(Local49,10.00000000);
	MaterialFloat3 Local51 = lerp(Local7.rgb,Local47,Local50);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 8);
	MaterialFloat4 Local53 = Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias);
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 8);
	MaterialFloat Local55 = PositiveClampedPow(Local53.b,5.00000000);
	MaterialFloat Local56 = (Local55 * 25000.00000000);
	MaterialFloat Local57 = saturate(Local56);
	MaterialFloat3 Local58 = lerp(Local7.rgb,Local51,Local57);
	MaterialFloat3 Local59 = (Local58 * Material.PreshaderBuffer[14].xyz);
	MaterialFloat3 Local60 = (Local59 * ((MaterialFloat3)Material.PreshaderBuffer[14].w));
	MaterialFloat Local61 = dot(Local60,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local62 = lerp(Local60,((MaterialFloat3)Local61),Material.PreshaderBuffer[15].y);
	MaterialFloat Local63 = (1.00000000 - Local53.g);
	MaterialFloat Local64 = dot(Local63,Material.PreshaderBuffer[15].z);
	MaterialFloat Local65 = saturate(Local64);
	MaterialFloat Local66 = (Local65 * 0.50000000);
	MaterialFloat Local67 = lerp(0.00000000,Local66,Material.PreshaderBuffer[15].w);
	MaterialFloat Local68 = lerp(0.00000000,Local66,Material.PreshaderBuffer[16].x);
	MaterialFloat Local69 = lerp(Local67,Local68,Local57);
	MaterialFloat Local70 = (Local53.g * Material.PreshaderBuffer[16].y);
	MaterialFloat Local71 = PositiveClampedPow(Local70,Material.PreshaderBuffer[16].z);
	MaterialFloat Local72 = lerp(Material.PreshaderBuffer[17].x,Material.PreshaderBuffer[16].w,Local71);
	MaterialFloat Local73 = (Local53.g * Material.PreshaderBuffer[17].y);
	MaterialFloat Local74 = PositiveClampedPow(Local73,Material.PreshaderBuffer[17].z);
	MaterialFloat Local75 = lerp(Material.PreshaderBuffer[17].x,Material.PreshaderBuffer[16].w,Local74);
	MaterialFloat Local76 = lerp(Local72,Local75,Local57);
	MaterialFloat Local77 = (Local53.r * Material.PreshaderBuffer[17].w);
	FLWCVector3 Local78 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local79 = LWCSubtract(GetObjectWorldPosition(Parameters), Local78);
	MaterialFloat Local80 = length(LWCToFloat(Local79));
	MaterialFloat Local81 = (DERIV_BASE_VALUE(Local80) * Material.PreshaderBuffer[18].y);
	MaterialFloat Local82 = (DERIV_BASE_VALUE(Local81) - 0.10000000);
	MaterialFloat Local83 = saturate(DERIV_BASE_VALUE(Local82));
	MaterialFloat Local84 = lerp(Local53.r,Local77,DERIV_BASE_VALUE(Local83));
	MaterialFloat2 Local85 = GetPixelPosition(Parameters);
	MaterialFloat Local86 = View.TemporalAAParams.x;
	MaterialFloat2 Local87 = (Local85 + MaterialFloat2(Local86,Local86));
	MaterialFloat Local88 = CustomExpression0(Parameters,Local87);
	MaterialFloat2 Local89 = (Local85 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local90 = MaterialStoreTexCoordScale(Parameters, Local89, 6);
	MaterialFloat4 Local91 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local89,View.MaterialTextureMipBias));
	MaterialFloat Local92 = MaterialStoreTexSample(Parameters, Local91, 6);
	MaterialFloat Local93 = (Local88 + Local91.r);
	MaterialFloat Local94 = (Local93 * 0.16665000);
	MaterialFloat Local95 = (Local84 + Local94);
	MaterialFloat Local96 = (Local95 + -0.50000000);
	MaterialFloat Local202 = (Local53.b * Material.PreshaderBuffer[20].x);
	MaterialFloat3 Local203 = (Local62 * ((MaterialFloat3)Local202));
	MaterialFloat Local204 = dot(Local203,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local205 = lerp(Local203,((MaterialFloat3)Local204),Material.PreshaderBuffer[20].z);
	MaterialFloat3 Local206 = PositiveClampedPow(Local205,((MaterialFloat3)Material.PreshaderBuffer[20].w));
	MaterialFloat3 Local207 = (((MaterialFloat3)1.00000000) - Local206);
	MaterialFloat3 Local208 = (Local207 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local209 = (Local208 * Material.PreshaderBuffer[23].xyz);
	MaterialFloat3 Local210 = (((MaterialFloat3)1.00000000) - Local209);
	MaterialFloat3 Local211 = (Local206 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local212 = (Local211 * Material.PreshaderBuffer[22].xyz);
	MaterialFloat Local213 = select((Local206.r >= 0.50000000), Local210.r, Local212.r);
	MaterialFloat Local214 = select((Local206.g >= 0.50000000), Local210.g, Local212.g);
	MaterialFloat Local215 = select((Local206.b >= 0.50000000), Local210.b, Local212.b);
	MaterialFloat3 Local216 = lerp(Local206,MaterialFloat3(MaterialFloat2(Local213,Local214),Local215),Material.PreshaderBuffer[23].w);
	MaterialFloat3 Local217 = (((MaterialFloat3)1.00000000) - Local216);
	MaterialFloat3 Local218 = (Local217 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local219 = (Local218 * Material.PreshaderBuffer[26].xyz);
	MaterialFloat3 Local220 = (((MaterialFloat3)1.00000000) - Local219);
	MaterialFloat3 Local221 = (Local216 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local222 = (Local221 * Material.PreshaderBuffer[25].xyz);
	MaterialFloat Local223 = select((Local216.r >= 0.50000000), Local220.r, Local222.r);
	MaterialFloat Local224 = select((Local216.g >= 0.50000000), Local220.g, Local222.g);
	MaterialFloat Local225 = select((Local216.b >= 0.50000000), Local220.b, Local222.b);
	MaterialFloat4 Local226 = Parameters.VertexColor;
	MaterialFloat Local227 = DERIV_BASE_VALUE(Local226).a;
	MaterialFloat3 Local228 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)DERIV_BASE_VALUE(Local227)),Local57);
	MaterialFloat3 Local229 = lerp(Local216,MaterialFloat3(MaterialFloat2(Local223,Local224),Local225),Local228);
	MaterialFloat3 Local230 = lerp(Local216,Local229,Material.PreshaderBuffer[26].w);

	PixelMaterialInputs.EmissiveColor = Local5;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local96;
	PixelMaterialInputs.BaseColor = Local62;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local69;
	PixelMaterialInputs.Roughness = Local76;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local4;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local230,Material.PreshaderBuffer[27].x);
	PixelMaterialInputs.AmbientOcclusion = Local53.a;
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