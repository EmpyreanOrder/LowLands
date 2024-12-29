#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_MATERIAL_TEXCOORDS_VERTEX 2
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
	float4 PreshaderBuffer[17];
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
	Material.PreshaderBuffer[1] = float4(2.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(2.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.500000,1.000000,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.000000,17.000000,5.000000,17.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.058824,0.058824,0.200000,0.700000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(-0.875000,-0.875000,-0.444400,-0.875000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(-0.444400,2.000000,0.000000,100000.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.000000,0.500000,0.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(3.000000,0.333333,2.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.000000,3.000000,2.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(2.000000,0.500000,0.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.000000,1.000000,2.000000,0.000000);//(Unknown)
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

MaterialFloat3 CustomExpression10(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat3 CustomExpression9(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression8(FMaterialVertexParameters Parameters,MaterialFloat N)
{
uint uRes32 = asuint(float(N));

  uint sign2 = ((uRes32>>16)&0x8000);
  uint exp2  = ((((  int) ((uRes32>>23)&0xff))-127+15) << 10);
  uint mant2 = ((uRes32>>13)&0x3ff);
  uint bits = (sign2 | exp2 | mant2);
  uint result = bits - 1024;
return float(result);
}

MaterialFloat CustomExpression7(FMaterialVertexParameters Parameters,MaterialFloat N)
{
uint uRes32 = asuint(float(N));

  uint sign2 = ((uRes32>>16)&0x8000);
  uint exp2  = ((((  int) ((uRes32>>23)&0xff))-127+15) << 10);
  uint mant2 = ((uRes32>>13)&0x3ff);
  uint bits = (sign2 | exp2 | mant2);
  uint result = bits - 1024;
return float(result);
}

MaterialFloat CustomExpression6(FMaterialVertexParameters Parameters,MaterialFloat N)
{
uint uRes32 = asuint(float(N));

  uint sign2 = ((uRes32>>16)&0x8000);
  uint exp2  = ((((  int) ((uRes32>>23)&0xff))-127+15) << 10);
  uint mant2 = ((uRes32>>13)&0x3ff);
  uint bits = (sign2 | exp2 | mant2);
  uint result = bits - 1024;
return float(result);
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
	MaterialFloat4 Local62 = MaterialCollection0.Vectors[0];
	MaterialFloat Local63 = CustomExpression1(Parameters,Local62.b);
	MaterialFloat Local64 = (Local63 * 0.10000000);
	MaterialFloat Local65 = (Local64 * 0.05000000);
	MaterialFloat Local66 = (Local65 * Material.PreshaderBuffer[7].w);
	FLWCVector3 Local67 = GetWorldPosition(Parameters);
	FLWCVector2 Local68 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local67)), LWCGetY(DERIV_BASE_VALUE(Local67)));
	FLWCVector2 Local69 = LWCMultiply(DERIV_BASE_VALUE(Local68), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local70 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local69), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local71 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local70,-1.00000000));
	FLWCVector3 Local72 = LWCMultiply(DERIV_BASE_VALUE(Local67), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local73 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local72), 0),LWCGetComponent(DERIV_BASE_VALUE(Local72), 1));
	FLWCVector2 Local74 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local73));
	MaterialFloat Local75 = CustomExpression2(Parameters,Local62.r);
	MaterialFloat Local76 = (Local75 * 6.28318548);
	MaterialFloat Local77 = cos(Local76);
	MaterialFloat Local78 = sin(Local76);
	MaterialFloat Local79 = (Local78 * -1.00000000);
	FLWCScalar Local80 = LWCDot(DERIV_BASE_VALUE(Local74), LWCPromote(MaterialFloat2(Local77,Local79)));
	FLWCScalar Local81 = LWCDot(DERIV_BASE_VALUE(Local74), LWCPromote(MaterialFloat2(Local78,Local77)));
	FLWCVector2 Local82 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local80),LWCPromote(Local81)));
	MaterialFloat4 Local83 = MaterialCollection0.Vectors[1];
	MaterialFloat Local84 = CustomExpression3(Parameters,Local83.r);
	FLWCVector2 Local85 = LWCMultiply(Local82, LWCPromote(((MaterialFloat2)Local84)));
	MaterialFloat Local86 = CustomExpression4(Parameters,Local62.a);
	MaterialFloat Local87 = (Local86 * 0.10000000);
	MaterialFloat Local88 = (View.RealTime * Local87);
	FLWCVector2 Local89 = LWCAdd(Local85, LWCPromote(((MaterialFloat2)Local88)));
	FLWCVector2 Local90 = LWCAdd(LWCPromote(MaterialFloat2(Local71.r,Local71.g)), Local89);
	FLWCVector2 Local91 = LWCLerp(Local90,Local89,0.89999998);
	FLWCVector2 Local92 = LWCMultiply(Local91, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local93 = LWCApplyAddressMode(Local92, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local94 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local93,-1.00000000);
	MaterialFloat2 Local95 = LWCApplyAddressMode(Local91, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local96 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local95,-1.00000000);
	MaterialFloat3 Local97 = lerp(Local94.rgb,Local96.rgb,0.50000000);
	MaterialFloat Local98 = (View.RealTime * 0.20000000);
	MaterialFloat Local99 = (Local98 * 6.28318548);
	MaterialFloat Local100 = cos(Local99);
	MaterialFloat Local101 = (DERIV_BASE_VALUE(Local100) + 1.00000000);
	MaterialFloat Local102 = (DERIV_BASE_VALUE(Local101) * 0.05000000);
	MaterialFloat3 Local103 = (Local97 + ((MaterialFloat3)DERIV_BASE_VALUE(Local102)));
	MaterialFloat3 Local104 = saturate(Local103);
	MaterialFloat Local105 = (Local64 * 0.10000000);
	MaterialFloat3 Local106 = (Local104 * ((MaterialFloat3)Local105));
	MaterialFloat3 Local107 = (((MaterialFloat3)Local66) + Local106);
	MaterialFloat Local108 = (Local64 * 0.50000000);
	MaterialFloat Local109 = (Material.PreshaderBuffer[8].x * Local108);
	MaterialFloat2 Local110 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local109,Local109));
	MaterialFloat Local111 = CustomExpression5(Parameters,Local62.r);
	MaterialFloat Local112 = (1.00000000 - Local111);
	MaterialFloat Local113 = (Local112 + 0.64999998);
	MaterialFloat Local114 = (Local113 * 6.28318548);
	MaterialFloat Local115 = cos(Local114);
	MaterialFloat Local116 = sin(Local114);
	MaterialFloat2 Local117 = Parameters.TexCoords[1].xy;
	MaterialFloat4 Local118 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local117),-1.00000000));
	MaterialFloat Local119 = CustomExpression6(Parameters,Local118.a);
	MaterialFloat Local120 = fmod(Local119,Material.PreshaderBuffer[8].w);
	MaterialFloat Local121 = (Local119 * Material.PreshaderBuffer[9].x);
	MaterialFloat Local122 = floor(Local121);
	MaterialFloat2 Local123 = (MaterialFloat2(Local120,Local122) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local124 = (Local123 * Material.PreshaderBuffer[9].yz);
	MaterialFloat4 Local125 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,MaterialFloat2(Local124.r,Local124.g),-1.00000000));
	MaterialFloat Local126 = CustomExpression7(Parameters,Local125.a);
	MaterialFloat Local127 = select((abs(Local126 - Local119) > 0.00001000), select((Local126 >= Local119), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat2 Local128 = (DERIV_BASE_VALUE(Local117) * Material.PreshaderBuffer[8].yz);
	MaterialFloat2 Local129 = floor(DERIV_BASE_VALUE(Local128));
	MaterialFloat Local130 = (Local129.g * Material.PreshaderBuffer[8].w);
	MaterialFloat Local131 = (Local129.r + Local130);
	MaterialFloat Local132 = select((abs(Local119 - Local131) > 0.00001000), select((Local119 >= Local131), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local133 = (Local127.r + Local132.r);
	MaterialFloat Local134 = fmod(Local126,Material.PreshaderBuffer[8].w);
	MaterialFloat Local135 = (Local126 * Material.PreshaderBuffer[9].x);
	MaterialFloat Local136 = floor(Local135);
	MaterialFloat2 Local137 = (MaterialFloat2(Local134,Local136) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local138 = (Local137 * Material.PreshaderBuffer[9].yz);
	MaterialFloat4 Local139 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,MaterialFloat2(Local138.r,Local138.g),-1.00000000));
	MaterialFloat Local140 = CustomExpression8(Parameters,Local139.a);
	MaterialFloat Local141 = select((abs(Local140 - Local126) > 0.00001000), select((Local140 >= Local126), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local142 = (Local133 + Local141.r);
	MaterialFloat Local143 = ceil(Local142);
	MaterialFloat Local144 = (Local143 / 3.00000000);
	MaterialFloat Local145 = (Local144 * 3.00000000);
	MaterialFloat Local146 = saturate(Local145);
	MaterialFloat2 Local147 = lerp(DERIV_BASE_VALUE(Local117),MaterialFloat2(Local124.r,Local124.g),DERIV_BASE_VALUE(Local146));
	MaterialFloat Local148 = (Local145 - 1.00000000);
	MaterialFloat Local149 = saturate(Local148);
	MaterialFloat2 Local150 = lerp(Local147,MaterialFloat2(Local138.r,Local138.g),DERIV_BASE_VALUE(Local149));
	MaterialFloat Local151 = fmod(Local140,Material.PreshaderBuffer[8].w);
	MaterialFloat Local152 = (Local140 * Material.PreshaderBuffer[9].x);
	MaterialFloat Local153 = floor(Local152);
	MaterialFloat2 Local154 = (MaterialFloat2(Local151,Local153) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local155 = (Local154 * Material.PreshaderBuffer[9].yz);
	MaterialFloat Local156 = (Local148 - 1.00000000);
	MaterialFloat Local157 = saturate(Local156);
	MaterialFloat2 Local158 = lerp(Local150,MaterialFloat2(Local155.r,Local155.g),DERIV_BASE_VALUE(Local157));
	MaterialFloat4 Local159 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local158,-1.00000000));
	FLWCVector3 Local160 = LWCMultiply(Local159.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local161 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local158,-1.00000000));
	MaterialFloat3 Local162 = (((MaterialFloat3)-0.50000000) + Local161.rgb);
	MaterialFloat3 Local163 = (Local162 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local164 = LWCMultiplyVector(Local163, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local165 = normalize(Local164);
	MaterialFloat Local166 = (Local161.a * 2048.00000000);
	MaterialFloat Local167 = max(Local166,8.00000000);
	MaterialFloat3 Local168 = (Local165 * ((MaterialFloat3)Local167));
	FLWCVector3 Local169 = LWCAdd(Local160, LWCPromote(Local168));
	FLWCScalar Local170 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000)), Local169);
	FLWCScalar Local171 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local169);
	FLWCVector2 Local172 = LWCAdd(LWCPromote(Local110), MakeLWCVector(LWCPromote(Local170),LWCPromote(Local171)));
	MaterialFloat2 Local173 = LWCFrac(Local172);
	MaterialFloat4 Local174 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local173,-1.00000000));
	MaterialFloat Local175 = (Local107.x * Local174.a);
	MaterialFloat Local176 = dot(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000),Local165);
	MaterialFloat Local177 = (Local176 + Material.PreshaderBuffer[10].w);
	MaterialFloat Local178 = (Local177 * Material.PreshaderBuffer[11].x);
	MaterialFloat Local179 = (Local175 * Local178);
	FLWCVector3 Local180 = LWCSubtract(DERIV_BASE_VALUE(Local67), Local160);
	MaterialFloat3 Local181 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(1.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local182 = (((MaterialFloat3)0.00000000) - Local181);
	MaterialFloat Local183 = length(Local182);
	MaterialFloat3 Local184 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,1.00000000,0.00000000));
	MaterialFloat3 Local185 = (((MaterialFloat3)0.00000000) - Local184);
	MaterialFloat Local186 = length(Local185);
	MaterialFloat2 Local187 = MaterialFloat2(DERIV_BASE_VALUE(Local183),DERIV_BASE_VALUE(Local186));
	MaterialFloat3 Local188 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat3 Local189 = (((MaterialFloat3)0.00000000) - Local188);
	MaterialFloat Local190 = length(Local189);
	MaterialFloat3 Local191 = MaterialFloat3(DERIV_BASE_VALUE(Local187),DERIV_BASE_VALUE(Local190));
	MaterialFloat3 Local192 = (LWCToFloat(Local180) / DERIV_BASE_VALUE(Local191));
	MaterialFloat3 Local193 = normalize(Local165);
	MaterialFloat Local194 = dot(Local192,Local193);
	MaterialFloat Local195 = (Material.PreshaderBuffer[11].y * Local167);
	MaterialFloat Local196 = (Local194 / Local195);
	MaterialFloat Local197 = saturate(Local196);
	MaterialFloat Local198 = (Local179 * Local197);
	MaterialFloat Local199 = (Local198 * 6.28318548);
	FLWCVector2 Local200 = LWCMultiply(Local172, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[11].w)));
	MaterialFloat2 Local201 = LWCFrac(Local200);
	MaterialFloat4 Local202 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local201,-1.00000000));
	MaterialFloat3 Local203 = (Local202.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local204 = (((MaterialFloat3)Material.PreshaderBuffer[12].x) * Local203);
	MaterialFloat Local205 = PositiveClampedPow(Local176,5.00000000);
	MaterialFloat3 Local206 = (((MaterialFloat3)Local205) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local207 = (Local206 + MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000));
	MaterialFloat3 Local208 = cross(Local165,Local207);
	MaterialFloat3 Local209 = (Local204 + Local208);
	MaterialFloat3 Local210 = (Local209 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local211 = length(Local210);
	MaterialFloat3 Local212 = (Local209 / ((MaterialFloat3)Local211));
	MaterialFloat3 Local213 = RotateAboutAxis(MaterialFloat4(Local212,Local199),Local160,DERIV_BASE_VALUE(Local67));
	MaterialFloat Local214 = (Local105 * Material.PreshaderBuffer[12].y);
	MaterialFloat3 Local215 = (((MaterialFloat3)Local214) + Local106);
	MaterialFloat Local216 = (Material.PreshaderBuffer[12].z * Local108);
	MaterialFloat2 Local217 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local216,Local216));
	MaterialFloat Local218 = (Local143 - 1.00000000);
	MaterialFloat Local219 = (Local218 / 2.00000000);
	MaterialFloat Local220 = saturate(Local219);
	MaterialFloat Local221 = (DERIV_BASE_VALUE(Local220) * 2.00000000);
	MaterialFloat Local222 = saturate(DERIV_BASE_VALUE(Local221));
	MaterialFloat2 Local223 = lerp(DERIV_BASE_VALUE(Local117),MaterialFloat2(Local124.r,Local124.g),DERIV_BASE_VALUE(Local222));
	MaterialFloat Local224 = (DERIV_BASE_VALUE(Local221) - 1.00000000);
	MaterialFloat Local225 = saturate(DERIV_BASE_VALUE(Local224));
	MaterialFloat2 Local226 = lerp(Local223,MaterialFloat2(Local138.r,Local138.g),DERIV_BASE_VALUE(Local225));
	MaterialFloat4 Local227 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local226,-1.00000000));
	FLWCVector3 Local228 = LWCMultiply(Local227.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local229 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local226,-1.00000000));
	MaterialFloat3 Local230 = (((MaterialFloat3)-0.50000000) + Local229.rgb);
	MaterialFloat3 Local231 = (Local230 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local232 = LWCMultiplyVector(Local231, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local233 = normalize(Local232);
	MaterialFloat Local234 = (Local229.a * 2048.00000000);
	MaterialFloat Local235 = max(Local234,8.00000000);
	MaterialFloat3 Local236 = (Local233 * ((MaterialFloat3)Local235));
	FLWCVector3 Local237 = LWCAdd(Local228, LWCPromote(Local236));
	FLWCScalar Local238 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000)), Local237);
	FLWCScalar Local239 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local237);
	FLWCVector2 Local240 = LWCAdd(LWCPromote(Local217), MakeLWCVector(LWCPromote(Local238),LWCPromote(Local239)));
	MaterialFloat2 Local241 = LWCFrac(Local240);
	MaterialFloat4 Local242 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local241,-1.00000000));
	MaterialFloat Local243 = (Local215.x * Local242.a);
	MaterialFloat Local244 = dot(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000),Local233);
	MaterialFloat Local245 = (Local244 + Material.PreshaderBuffer[10].w);
	MaterialFloat Local246 = (Local245 * Material.PreshaderBuffer[11].x);
	MaterialFloat Local247 = (Local243 * Local246);
	FLWCVector3 Local248 = LWCSubtract(DERIV_BASE_VALUE(Local67), Local228);
	MaterialFloat3 Local249 = (LWCToFloat(Local248) / DERIV_BASE_VALUE(Local191));
	MaterialFloat3 Local250 = normalize(Local233);
	MaterialFloat Local251 = dot(Local249,Local250);
	MaterialFloat Local252 = (Material.PreshaderBuffer[12].w * Local235);
	MaterialFloat Local253 = (Local251 / Local252);
	MaterialFloat Local254 = saturate(Local253);
	MaterialFloat Local255 = (Local247 * Local254);
	MaterialFloat Local256 = (Local255 * 6.28318548);
	FLWCVector2 Local257 = LWCMultiply(Local240, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[13].y)));
	MaterialFloat2 Local258 = LWCFrac(Local257);
	MaterialFloat4 Local259 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local258,-1.00000000));
	MaterialFloat3 Local260 = (Local259.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local261 = (((MaterialFloat3)Material.PreshaderBuffer[13].z) * Local260);
	MaterialFloat Local262 = PositiveClampedPow(Local244,5.00000000);
	MaterialFloat3 Local263 = (((MaterialFloat3)Local262) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local264 = (Local263 + MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000));
	MaterialFloat3 Local265 = cross(Local233,Local264);
	MaterialFloat3 Local266 = (Local261 + Local265);
	MaterialFloat3 Local267 = (Local266 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local268 = length(Local267);
	MaterialFloat3 Local269 = (Local266 / ((MaterialFloat3)Local268));
	MaterialFloat3 Local270 = RotateAboutAxis(MaterialFloat4(Local269,Local256),Local228,DERIV_BASE_VALUE(Local67));
	MaterialFloat Local271 = saturate(Local143);
	MaterialFloat3 Local272 = (Local270 * ((MaterialFloat3)DERIV_BASE_VALUE(Local271)));
	MaterialFloat3 Local273 = (Local213 + Local272);
	MaterialFloat Local274 = (Local105 * Material.PreshaderBuffer[13].w);
	MaterialFloat3 Local275 = (((MaterialFloat3)Local274) + Local106);
	MaterialFloat Local276 = (Material.PreshaderBuffer[14].x * Local108);
	MaterialFloat2 Local277 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local276,Local276));
	MaterialFloat Local278 = (Local143 - 2.00000000);
	MaterialFloat Local279 = saturate(Local278);
	MaterialFloat2 Local280 = lerp(DERIV_BASE_VALUE(Local117),MaterialFloat2(Local124.r,Local124.g),DERIV_BASE_VALUE(Local279));
	MaterialFloat4 Local281 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local280,-1.00000000));
	FLWCVector3 Local282 = LWCMultiply(Local281.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local283 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local280,-1.00000000));
	MaterialFloat3 Local284 = (((MaterialFloat3)-0.50000000) + Local283.rgb);
	MaterialFloat3 Local285 = (Local284 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local286 = LWCMultiplyVector(Local285, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local287 = normalize(Local286);
	MaterialFloat Local288 = (Local283.a * 2048.00000000);
	MaterialFloat Local289 = max(Local288,8.00000000);
	MaterialFloat3 Local290 = (Local287 * ((MaterialFloat3)Local289));
	FLWCVector3 Local291 = LWCAdd(Local282, LWCPromote(Local290));
	FLWCScalar Local292 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000)), Local291);
	FLWCScalar Local293 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local291);
	FLWCVector2 Local294 = LWCAdd(LWCPromote(Local277), MakeLWCVector(LWCPromote(Local292),LWCPromote(Local293)));
	MaterialFloat2 Local295 = LWCFrac(Local294);
	MaterialFloat4 Local296 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local295,-1.00000000));
	MaterialFloat Local297 = (Local275.x * Local296.a);
	MaterialFloat Local298 = dot(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000),Local287);
	MaterialFloat Local299 = (Local298 + Material.PreshaderBuffer[10].w);
	MaterialFloat Local300 = (Local299 * Material.PreshaderBuffer[11].x);
	MaterialFloat Local301 = (Local297 * Local300);
	FLWCVector3 Local302 = LWCSubtract(DERIV_BASE_VALUE(Local67), Local282);
	MaterialFloat3 Local303 = (LWCToFloat(Local302) / DERIV_BASE_VALUE(Local191));
	MaterialFloat3 Local304 = normalize(Local287);
	MaterialFloat Local305 = dot(Local303,Local304);
	MaterialFloat Local306 = (Material.PreshaderBuffer[14].y * Local289);
	MaterialFloat Local307 = (Local305 / Local306);
	MaterialFloat Local308 = saturate(Local307);
	MaterialFloat Local309 = (Local301 * Local308);
	MaterialFloat Local310 = (Local309 * 6.28318548);
	FLWCVector2 Local311 = LWCMultiply(Local294, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[14].w)));
	MaterialFloat2 Local312 = LWCFrac(Local311);
	MaterialFloat4 Local313 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local312,-1.00000000));
	MaterialFloat3 Local314 = (Local313.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local315 = (((MaterialFloat3)Material.PreshaderBuffer[15].x) * Local314);
	MaterialFloat Local316 = PositiveClampedPow(Local298,5.00000000);
	MaterialFloat3 Local317 = (((MaterialFloat3)Local316) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local318 = (Local317 + MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000));
	MaterialFloat3 Local319 = cross(Local287,Local318);
	MaterialFloat3 Local320 = (Local315 + Local319);
	MaterialFloat3 Local321 = (Local320 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local322 = length(Local321);
	MaterialFloat3 Local323 = (Local320 / ((MaterialFloat3)Local322));
	MaterialFloat3 Local324 = RotateAboutAxis(MaterialFloat4(Local323,Local310),Local282,DERIV_BASE_VALUE(Local67));
	MaterialFloat Local325 = saturate(Local218);
	MaterialFloat3 Local326 = (Local324 * ((MaterialFloat3)DERIV_BASE_VALUE(Local325)));
	MaterialFloat3 Local327 = (Local273 + Local326);
	MaterialFloat Local328 = (Local105 * Material.PreshaderBuffer[15].y);
	MaterialFloat3 Local329 = (((MaterialFloat3)Local328) + Local106);
	MaterialFloat Local330 = (Material.PreshaderBuffer[15].z * Local108);
	MaterialFloat2 Local331 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local330,Local330));
	MaterialFloat4 Local332 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,DERIV_BASE_VALUE(Local117),-1.00000000));
	FLWCVector3 Local333 = LWCMultiply(Local332.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local334 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local117),-1.00000000));
	MaterialFloat3 Local335 = (((MaterialFloat3)-0.50000000) + Local334.rgb);
	MaterialFloat3 Local336 = (Local335 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local337 = LWCMultiplyVector(Local336, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local338 = normalize(Local337);
	MaterialFloat Local339 = (Local334.a * 2048.00000000);
	MaterialFloat Local340 = max(Local339,8.00000000);
	MaterialFloat3 Local341 = (Local338 * ((MaterialFloat3)Local340));
	FLWCVector3 Local342 = LWCAdd(Local333, LWCPromote(Local341));
	FLWCScalar Local343 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000)), Local342);
	FLWCScalar Local344 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local342);
	FLWCVector2 Local345 = LWCAdd(LWCPromote(Local331), MakeLWCVector(LWCPromote(Local343),LWCPromote(Local344)));
	MaterialFloat2 Local346 = LWCFrac(Local345);
	MaterialFloat4 Local347 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local346,-1.00000000));
	MaterialFloat Local348 = (Local329.x * Local347.a);
	MaterialFloat Local349 = dot(MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000),Local338);
	MaterialFloat Local350 = (Local349 + Material.PreshaderBuffer[10].w);
	MaterialFloat Local351 = (Local350 * Material.PreshaderBuffer[11].x);
	MaterialFloat Local352 = (Local348 * Local351);
	FLWCVector3 Local353 = LWCSubtract(DERIV_BASE_VALUE(Local67), Local333);
	MaterialFloat3 Local354 = (LWCToFloat(Local353) / DERIV_BASE_VALUE(Local191));
	MaterialFloat3 Local355 = normalize(Local338);
	MaterialFloat Local356 = dot(Local354,Local355);
	MaterialFloat Local357 = (Material.PreshaderBuffer[15].w * Local340);
	MaterialFloat Local358 = (Local356 / Local357);
	MaterialFloat Local359 = saturate(Local358);
	MaterialFloat Local360 = (Local352 * Local359);
	MaterialFloat Local361 = (Local360 * 6.28318548);
	FLWCVector2 Local362 = LWCMultiply(Local345, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[16].y)));
	MaterialFloat2 Local363 = LWCFrac(Local362);
	MaterialFloat4 Local364 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local363,-1.00000000));
	MaterialFloat3 Local365 = (Local364.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local366 = (((MaterialFloat3)Material.PreshaderBuffer[16].z) * Local365);
	MaterialFloat Local367 = PositiveClampedPow(Local349,5.00000000);
	MaterialFloat3 Local368 = (((MaterialFloat3)Local367) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local369 = (Local368 + MaterialFloat3(MaterialFloat2(Local115,Local116),0.00000000));
	MaterialFloat3 Local370 = cross(Local338,Local369);
	MaterialFloat3 Local371 = (Local366 + Local370);
	MaterialFloat3 Local372 = (Local371 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local373 = length(Local372);
	MaterialFloat3 Local374 = (Local371 / ((MaterialFloat3)Local373));
	MaterialFloat3 Local375 = RotateAboutAxis(MaterialFloat4(Local374,Local361),Local333,DERIV_BASE_VALUE(Local67));
	MaterialFloat3 Local376 = (Local375 * ((MaterialFloat3)DERIV_BASE_VALUE(Local279)));
	MaterialFloat3 Local377 = (Local327 + Local376);
	MaterialFloat3 Local378 = CustomExpression9(Parameters,Local377);
	return Local378;;
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
	MaterialFloat Local37 = saturate(Local36);
	MaterialFloat Local38 = (Local37 * 0.50000000);
	MaterialFloat Local39 = lerp(0.00000000,Local38,Material.PreshaderBuffer[7].y);
	MaterialFloat Local40 = (Local25.g * Material.PreshaderBuffer[7].z);
	MaterialFloat Local41 = (Local40 * 2.00000000);
	MaterialFloat Local42 = saturate(Local41);
	MaterialFloat Local43 = lerp(0.00000000,1.00000000,Local42);
	MaterialFloat4 Local44 = Parameters.VertexColor;
	MaterialFloat Local45 = DERIV_BASE_VALUE(Local44).a;
	MaterialFloat Local46 = (DERIV_BASE_VALUE(Local45) * 1.20000005);
	MaterialFloat Local47 = lerp(Local25.r,Local29.r,0.20000000);
	MaterialFloat Local48 = (Local47 * 5.00000000);
	MaterialFloat Local49 = PositiveClampedPow(DERIV_BASE_VALUE(Local46),Local48);
	MaterialFloat2 Local50 = GetPixelPosition(Parameters);
	MaterialFloat Local51 = View.TemporalAAParams.x;
	MaterialFloat2 Local52 = (Local50 + MaterialFloat2(Local51,Local51));
	MaterialFloat Local53 = CustomExpression0(Parameters,Local52);
	MaterialFloat2 Local54 = (Local50 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local55 = MaterialStoreTexCoordScale(Parameters, Local54, 6);
	MaterialFloat4 Local56 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local54,View.MaterialTextureMipBias));
	MaterialFloat Local57 = MaterialStoreTexSample(Parameters, Local56, 6);
	MaterialFloat Local58 = (Local53 + Local56.r);
	MaterialFloat Local59 = (Local58 * 0.16665000);
	MaterialFloat Local60 = (Local49 + Local59);
	MaterialFloat Local61 = (Local60 + -0.50000000);

	PixelMaterialInputs.EmissiveColor = Local16;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local61;
	PixelMaterialInputs.BaseColor = Local34;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = Local39;
	PixelMaterialInputs.Roughness = Local43;
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