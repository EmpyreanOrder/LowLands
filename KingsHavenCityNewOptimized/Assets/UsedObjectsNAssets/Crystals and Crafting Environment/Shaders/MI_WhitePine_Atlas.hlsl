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
	float4 PreshaderBuffer[34];
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
	Material.PreshaderBuffer[3] = float4(0.659765,0.352941,0.121569,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.659765,0.352941,0.121569,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.340235,0.647059,0.878431,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.680470,1.294118,1.756862,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.319530,0.705882,0.243138,0.659765);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.352941,0.121569,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.651042,0.522073,0.080211,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.651042,0.522073,0.080211,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.348958,0.477927,0.919789,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,0.000000,10.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(1.300000,0.900000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.000000,1.000000,1.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(10000.000000,0.000100,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(0.000000,17.000000,5.000000,17.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.058824,0.058824,0.200000,0.700000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-0.875000,-0.875000,-0.444400,-0.875000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(-0.444400,3.000000,4.000000,0.250000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(2.000000,0.500000,0.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(3.000000,0.333333,2.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.000000,3.000000,2.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(2.000000,0.500000,0.000000,3.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(1.000000,1.000000,2.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.000000,1.000000,1.200000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(1.000000,0.000000,1.000000,1.200000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(-0.848000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(-0.848000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(1.848000,0.000000,0.000000,0.200000);//(Unknown)
	Material.PreshaderBuffer[33] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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

MaterialFloat3 CustomExpression11(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat3 CustomExpression10(FMaterialVertexParameters Parameters,MaterialFloat3 InValue)
{
#if COMPILER_HLSL
return MakePrecise(InValue);
#else
return InValue;
#endif
}

MaterialFloat CustomExpression9(FMaterialVertexParameters Parameters,MaterialFloat InValue)
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
	MaterialFloat4 Local97 = MaterialCollection0.Vectors[0];
	MaterialFloat Local98 = CustomExpression1(Parameters,Local97.b);
	MaterialFloat Local99 = (Local98 * 0.10000000);
	MaterialFloat Local100 = (Local99 * Material.PreshaderBuffer[18].z);
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
	MaterialFloat Local132 = (Local99 * 0.05000000);
	MaterialFloat Local133 = (Local132 * Material.PreshaderBuffer[18].w);
	FLWCVector2 Local134 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local104)), LWCGetY(DERIV_BASE_VALUE(Local104)));
	FLWCVector2 Local135 = LWCMultiply(DERIV_BASE_VALUE(Local134), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local136 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local135), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local137 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_5,samplerMaterial_Texture2D_5,Local136,-1.00000000));
	FLWCVector3 Local138 = LWCMultiply(DERIV_BASE_VALUE(Local104), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local139 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local138), 0),LWCGetComponent(DERIV_BASE_VALUE(Local138), 1));
	FLWCVector2 Local140 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local139));
	MaterialFloat Local141 = CustomExpression2(Parameters,Local97.r);
	MaterialFloat Local142 = (Local141 * 6.28318548);
	MaterialFloat Local143 = cos(Local142);
	MaterialFloat Local144 = sin(Local142);
	MaterialFloat Local145 = (Local144 * -1.00000000);
	FLWCScalar Local146 = LWCDot(DERIV_BASE_VALUE(Local140), LWCPromote(MaterialFloat2(Local143,Local145)));
	FLWCScalar Local147 = LWCDot(DERIV_BASE_VALUE(Local140), LWCPromote(MaterialFloat2(Local144,Local143)));
	FLWCVector2 Local148 = LWCAdd(LWCPromote(MaterialFloat2(0.50000000,0.50000000)), MakeLWCVector(LWCPromote(Local146),LWCPromote(Local147)));
	MaterialFloat4 Local149 = MaterialCollection0.Vectors[1];
	MaterialFloat Local150 = CustomExpression3(Parameters,Local149.r);
	FLWCVector2 Local151 = LWCMultiply(Local148, LWCPromote(((MaterialFloat2)Local150)));
	MaterialFloat Local152 = CustomExpression4(Parameters,Local97.a);
	MaterialFloat Local153 = (Local152 * 0.10000000);
	MaterialFloat Local154 = (View.RealTime * Local153);
	FLWCVector2 Local155 = LWCAdd(Local151, LWCPromote(((MaterialFloat2)Local154)));
	FLWCVector2 Local156 = LWCAdd(LWCPromote(MaterialFloat2(Local137.r,Local137.g)), Local155);
	FLWCVector2 Local157 = LWCLerp(Local156,Local155,0.89999998);
	FLWCVector2 Local158 = LWCMultiply(Local157, LWCPromote(((MaterialFloat2)0.50000000)));
	MaterialFloat2 Local159 = LWCApplyAddressMode(Local158, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local160 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local159,-1.00000000);
	MaterialFloat2 Local161 = LWCApplyAddressMode(Local157, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local162 = Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,Local161,-1.00000000);
	MaterialFloat3 Local163 = lerp(Local160.rgb,Local162.rgb,0.50000000);
	MaterialFloat Local164 = (View.RealTime * 0.20000000);
	MaterialFloat Local165 = (Local164 * 6.28318548);
	MaterialFloat Local166 = cos(Local165);
	MaterialFloat Local167 = (DERIV_BASE_VALUE(Local166) + 1.00000000);
	MaterialFloat Local168 = (DERIV_BASE_VALUE(Local167) * 0.05000000);
	MaterialFloat3 Local169 = (Local163 + ((MaterialFloat3)DERIV_BASE_VALUE(Local168)));
	MaterialFloat3 Local170 = saturate(Local169);
	MaterialFloat Local171 = (Local99 * 0.10000000);
	MaterialFloat3 Local172 = (Local170 * ((MaterialFloat3)Local171));
	MaterialFloat3 Local173 = (((MaterialFloat3)Local133) + Local172);
	MaterialFloat Local174 = (Local99 * 0.50000000);
	MaterialFloat Local175 = (Material.PreshaderBuffer[19].x * Local174);
	MaterialFloat2 Local176 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local175,Local175));
	MaterialFloat Local177 = CustomExpression5(Parameters,Local97.r);
	MaterialFloat Local178 = (1.00000000 - Local177);
	MaterialFloat Local179 = (Local178 + 0.64999998);
	MaterialFloat Local180 = (Local179 * 6.28318548);
	MaterialFloat Local181 = cos(Local180);
	MaterialFloat Local182 = sin(Local180);
	MaterialFloat2 Local183 = Parameters.TexCoords[1].xy;
	MaterialFloat4 Local184 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local183),-1.00000000));
	MaterialFloat Local185 = CustomExpression6(Parameters,Local184.a);
	MaterialFloat Local186 = fmod(Local185,Material.PreshaderBuffer[19].w);
	MaterialFloat Local187 = (Local185 * Material.PreshaderBuffer[20].x);
	MaterialFloat Local188 = floor(Local187);
	MaterialFloat2 Local189 = (MaterialFloat2(Local186,Local188) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local190 = (Local189 * Material.PreshaderBuffer[20].yz);
	MaterialFloat4 Local191 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,MaterialFloat2(Local190.r,Local190.g),-1.00000000));
	MaterialFloat Local192 = CustomExpression7(Parameters,Local191.a);
	MaterialFloat Local193 = select((abs(Local192 - Local185) > 0.00001000), select((Local192 >= Local185), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat2 Local194 = (DERIV_BASE_VALUE(Local183) * Material.PreshaderBuffer[19].yz);
	MaterialFloat2 Local195 = floor(DERIV_BASE_VALUE(Local194));
	MaterialFloat Local196 = (Local195.g * Material.PreshaderBuffer[19].w);
	MaterialFloat Local197 = (Local195.r + Local196);
	MaterialFloat Local198 = select((abs(Local185 - Local197) > 0.00001000), select((Local185 >= Local197), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local199 = (Local193.r + Local198.r);
	MaterialFloat Local200 = fmod(Local192,Material.PreshaderBuffer[19].w);
	MaterialFloat Local201 = (Local192 * Material.PreshaderBuffer[20].x);
	MaterialFloat Local202 = floor(Local201);
	MaterialFloat2 Local203 = (MaterialFloat2(Local200,Local202) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local204 = (Local203 * Material.PreshaderBuffer[20].yz);
	MaterialFloat4 Local205 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,MaterialFloat2(Local204.r,Local204.g),-1.00000000));
	MaterialFloat Local206 = CustomExpression8(Parameters,Local205.a);
	MaterialFloat Local207 = select((abs(Local206 - Local192) > 0.00001000), select((Local206 >= Local192), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local208 = (Local199 + Local207.r);
	MaterialFloat Local209 = ceil(Local208);
	MaterialFloat Local210 = (Local209 / 3.00000000);
	MaterialFloat Local211 = (Local210 * 3.00000000);
	MaterialFloat Local212 = saturate(Local211);
	MaterialFloat2 Local213 = lerp(DERIV_BASE_VALUE(Local183),MaterialFloat2(Local190.r,Local190.g),DERIV_BASE_VALUE(Local212));
	MaterialFloat Local214 = (Local211 - 1.00000000);
	MaterialFloat Local215 = saturate(Local214);
	MaterialFloat2 Local216 = lerp(Local213,MaterialFloat2(Local204.r,Local204.g),DERIV_BASE_VALUE(Local215));
	MaterialFloat Local217 = fmod(Local206,Material.PreshaderBuffer[19].w);
	MaterialFloat Local218 = (Local206 * Material.PreshaderBuffer[20].x);
	MaterialFloat Local219 = floor(Local218);
	MaterialFloat2 Local220 = (MaterialFloat2(Local217,Local219) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local221 = (Local220 * Material.PreshaderBuffer[20].yz);
	MaterialFloat Local222 = (Local214 - 1.00000000);
	MaterialFloat Local223 = saturate(Local222);
	MaterialFloat2 Local224 = lerp(Local216,MaterialFloat2(Local221.r,Local221.g),DERIV_BASE_VALUE(Local223));
	MaterialFloat4 Local225 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local224,-1.00000000));
	FLWCVector3 Local226 = LWCMultiply(Local225.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local227 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local224,-1.00000000));
	MaterialFloat3 Local228 = (((MaterialFloat3)-0.50000000) + Local227.rgb);
	MaterialFloat3 Local229 = (Local228 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local230 = LWCMultiplyVector(Local229, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local231 = normalize(Local230);
	MaterialFloat Local232 = (Local227.a * 2048.00000000);
	MaterialFloat Local233 = max(Local232,8.00000000);
	MaterialFloat3 Local234 = (Local231 * ((MaterialFloat3)Local233));
	FLWCVector3 Local235 = LWCAdd(Local226, LWCPromote(Local234));
	FLWCScalar Local236 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000)), Local235);
	FLWCScalar Local237 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local235);
	FLWCVector2 Local238 = LWCAdd(LWCPromote(Local176), MakeLWCVector(LWCPromote(Local236),LWCPromote(Local237)));
	MaterialFloat2 Local239 = LWCFrac(Local238);
	MaterialFloat4 Local240 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local239,-1.00000000));
	MaterialFloat Local241 = (Local173.x * Local240.a);
	MaterialFloat Local242 = dot(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000),Local231);
	MaterialFloat Local243 = (Local242 + Material.PreshaderBuffer[21].w);
	MaterialFloat Local244 = (Local243 * Material.PreshaderBuffer[22].x);
	MaterialFloat Local245 = (Local241 * Local244);
	FLWCVector3 Local246 = LWCSubtract(DERIV_BASE_VALUE(Local104), Local226);
	MaterialFloat3 Local247 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(1.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local248 = (((MaterialFloat3)0.00000000) - Local247);
	MaterialFloat Local249 = length(Local248);
	MaterialFloat3 Local250 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,1.00000000,0.00000000));
	MaterialFloat3 Local251 = (((MaterialFloat3)0.00000000) - Local250);
	MaterialFloat Local252 = length(Local251);
	MaterialFloat2 Local253 = MaterialFloat2(DERIV_BASE_VALUE(Local249),DERIV_BASE_VALUE(Local252));
	MaterialFloat3 Local254 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat3 Local255 = (((MaterialFloat3)0.00000000) - Local254);
	MaterialFloat Local256 = length(Local255);
	MaterialFloat3 Local257 = MaterialFloat3(DERIV_BASE_VALUE(Local253),DERIV_BASE_VALUE(Local256));
	MaterialFloat3 Local258 = (LWCToFloat(Local246) / DERIV_BASE_VALUE(Local257));
	MaterialFloat3 Local259 = normalize(Local231);
	MaterialFloat Local260 = dot(Local258,Local259);
	MaterialFloat Local261 = (Material.PreshaderBuffer[22].y * Local233);
	MaterialFloat Local262 = (Local260 / Local261);
	MaterialFloat Local263 = saturate(Local262);
	MaterialFloat Local264 = (Local245 * Local263);
	MaterialFloat Local265 = (Local264 * 6.28318548);
	FLWCVector2 Local266 = LWCMultiply(Local238, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[22].w)));
	MaterialFloat2 Local267 = LWCFrac(Local266);
	MaterialFloat4 Local268 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local267,-1.00000000));
	MaterialFloat3 Local269 = (Local268.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local270 = (((MaterialFloat3)Material.PreshaderBuffer[23].x) * Local269);
	MaterialFloat Local271 = PositiveClampedPow(Local242,5.00000000);
	MaterialFloat3 Local272 = (((MaterialFloat3)Local271) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local273 = (Local272 + MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000));
	MaterialFloat3 Local274 = cross(Local231,Local273);
	MaterialFloat3 Local275 = (Local270 + Local274);
	MaterialFloat3 Local276 = (Local275 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local277 = length(Local276);
	MaterialFloat3 Local278 = (Local275 / ((MaterialFloat3)Local277));
	MaterialFloat3 Local279 = RotateAboutAxis(MaterialFloat4(Local278,Local265),Local226,DERIV_BASE_VALUE(Local104));
	MaterialFloat Local280 = (Local171 * Material.PreshaderBuffer[23].y);
	MaterialFloat3 Local281 = (((MaterialFloat3)Local280) + Local172);
	MaterialFloat Local282 = (Material.PreshaderBuffer[23].z * Local174);
	MaterialFloat2 Local283 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local282,Local282));
	MaterialFloat Local284 = (Local209 - 1.00000000);
	MaterialFloat Local285 = (Local284 / 2.00000000);
	MaterialFloat Local286 = saturate(Local285);
	MaterialFloat Local287 = (DERIV_BASE_VALUE(Local286) * 2.00000000);
	MaterialFloat Local288 = saturate(DERIV_BASE_VALUE(Local287));
	MaterialFloat2 Local289 = lerp(DERIV_BASE_VALUE(Local183),MaterialFloat2(Local190.r,Local190.g),DERIV_BASE_VALUE(Local288));
	MaterialFloat Local290 = (DERIV_BASE_VALUE(Local287) - 1.00000000);
	MaterialFloat Local291 = saturate(DERIV_BASE_VALUE(Local290));
	MaterialFloat2 Local292 = lerp(Local289,MaterialFloat2(Local204.r,Local204.g),DERIV_BASE_VALUE(Local291));
	MaterialFloat4 Local293 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local292,-1.00000000));
	FLWCVector3 Local294 = LWCMultiply(Local293.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local295 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local292,-1.00000000));
	MaterialFloat3 Local296 = (((MaterialFloat3)-0.50000000) + Local295.rgb);
	MaterialFloat3 Local297 = (Local296 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local298 = LWCMultiplyVector(Local297, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local299 = normalize(Local298);
	MaterialFloat Local300 = (Local295.a * 2048.00000000);
	MaterialFloat Local301 = max(Local300,8.00000000);
	MaterialFloat3 Local302 = (Local299 * ((MaterialFloat3)Local301));
	FLWCVector3 Local303 = LWCAdd(Local294, LWCPromote(Local302));
	FLWCScalar Local304 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000)), Local303);
	FLWCScalar Local305 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local303);
	FLWCVector2 Local306 = LWCAdd(LWCPromote(Local283), MakeLWCVector(LWCPromote(Local304),LWCPromote(Local305)));
	MaterialFloat2 Local307 = LWCFrac(Local306);
	MaterialFloat4 Local308 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local307,-1.00000000));
	MaterialFloat Local309 = (Local281.x * Local308.a);
	MaterialFloat Local310 = dot(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000),Local299);
	MaterialFloat Local311 = (Local310 + Material.PreshaderBuffer[21].w);
	MaterialFloat Local312 = (Local311 * Material.PreshaderBuffer[22].x);
	MaterialFloat Local313 = (Local309 * Local312);
	FLWCVector3 Local314 = LWCSubtract(DERIV_BASE_VALUE(Local104), Local294);
	MaterialFloat3 Local315 = (LWCToFloat(Local314) / DERIV_BASE_VALUE(Local257));
	MaterialFloat3 Local316 = normalize(Local299);
	MaterialFloat Local317 = dot(Local315,Local316);
	MaterialFloat Local318 = (Material.PreshaderBuffer[23].w * Local301);
	MaterialFloat Local319 = (Local317 / Local318);
	MaterialFloat Local320 = saturate(Local319);
	MaterialFloat Local321 = (Local313 * Local320);
	MaterialFloat Local322 = (Local321 * 6.28318548);
	FLWCVector2 Local323 = LWCMultiply(Local306, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[24].y)));
	MaterialFloat2 Local324 = LWCFrac(Local323);
	MaterialFloat4 Local325 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local324,-1.00000000));
	MaterialFloat3 Local326 = (Local325.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local327 = (((MaterialFloat3)Material.PreshaderBuffer[24].z) * Local326);
	MaterialFloat Local328 = PositiveClampedPow(Local310,5.00000000);
	MaterialFloat3 Local329 = (((MaterialFloat3)Local328) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local330 = (Local329 + MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000));
	MaterialFloat3 Local331 = cross(Local299,Local330);
	MaterialFloat3 Local332 = (Local327 + Local331);
	MaterialFloat3 Local333 = (Local332 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local334 = length(Local333);
	MaterialFloat3 Local335 = (Local332 / ((MaterialFloat3)Local334));
	MaterialFloat3 Local336 = RotateAboutAxis(MaterialFloat4(Local335,Local322),Local294,DERIV_BASE_VALUE(Local104));
	MaterialFloat Local337 = saturate(Local209);
	MaterialFloat3 Local338 = (Local336 * ((MaterialFloat3)DERIV_BASE_VALUE(Local337)));
	MaterialFloat3 Local339 = (Local279 + Local338);
	MaterialFloat Local340 = (Local171 * Material.PreshaderBuffer[24].w);
	MaterialFloat3 Local341 = (((MaterialFloat3)Local340) + Local172);
	MaterialFloat Local342 = (Material.PreshaderBuffer[25].x * Local174);
	MaterialFloat2 Local343 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local342,Local342));
	MaterialFloat Local344 = (Local209 - 2.00000000);
	MaterialFloat Local345 = saturate(Local344);
	MaterialFloat2 Local346 = lerp(DERIV_BASE_VALUE(Local183),MaterialFloat2(Local190.r,Local190.g),DERIV_BASE_VALUE(Local345));
	MaterialFloat4 Local347 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local346,-1.00000000));
	FLWCVector3 Local348 = LWCMultiply(Local347.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local349 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local346,-1.00000000));
	MaterialFloat3 Local350 = (((MaterialFloat3)-0.50000000) + Local349.rgb);
	MaterialFloat3 Local351 = (Local350 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local352 = LWCMultiplyVector(Local351, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local353 = normalize(Local352);
	MaterialFloat Local354 = (Local349.a * 2048.00000000);
	MaterialFloat Local355 = max(Local354,8.00000000);
	MaterialFloat3 Local356 = (Local353 * ((MaterialFloat3)Local355));
	FLWCVector3 Local357 = LWCAdd(Local348, LWCPromote(Local356));
	FLWCScalar Local358 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000)), Local357);
	FLWCScalar Local359 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local357);
	FLWCVector2 Local360 = LWCAdd(LWCPromote(Local343), MakeLWCVector(LWCPromote(Local358),LWCPromote(Local359)));
	MaterialFloat2 Local361 = LWCFrac(Local360);
	MaterialFloat4 Local362 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local361,-1.00000000));
	MaterialFloat Local363 = (Local341.x * Local362.a);
	MaterialFloat Local364 = dot(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000),Local353);
	MaterialFloat Local365 = (Local364 + Material.PreshaderBuffer[21].w);
	MaterialFloat Local366 = (Local365 * Material.PreshaderBuffer[22].x);
	MaterialFloat Local367 = (Local363 * Local366);
	FLWCVector3 Local368 = LWCSubtract(DERIV_BASE_VALUE(Local104), Local348);
	MaterialFloat3 Local369 = (LWCToFloat(Local368) / DERIV_BASE_VALUE(Local257));
	MaterialFloat3 Local370 = normalize(Local353);
	MaterialFloat Local371 = dot(Local369,Local370);
	MaterialFloat Local372 = (Material.PreshaderBuffer[25].y * Local355);
	MaterialFloat Local373 = (Local371 / Local372);
	MaterialFloat Local374 = saturate(Local373);
	MaterialFloat Local375 = (Local367 * Local374);
	MaterialFloat Local376 = (Local375 * 6.28318548);
	FLWCVector2 Local377 = LWCMultiply(Local360, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[25].w)));
	MaterialFloat2 Local378 = LWCFrac(Local377);
	MaterialFloat4 Local379 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local378,-1.00000000));
	MaterialFloat3 Local380 = (Local379.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local381 = (((MaterialFloat3)Material.PreshaderBuffer[26].x) * Local380);
	MaterialFloat Local382 = PositiveClampedPow(Local364,5.00000000);
	MaterialFloat3 Local383 = (((MaterialFloat3)Local382) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local384 = (Local383 + MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000));
	MaterialFloat3 Local385 = cross(Local353,Local384);
	MaterialFloat3 Local386 = (Local381 + Local385);
	MaterialFloat3 Local387 = (Local386 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local388 = length(Local387);
	MaterialFloat3 Local389 = (Local386 / ((MaterialFloat3)Local388));
	MaterialFloat3 Local390 = RotateAboutAxis(MaterialFloat4(Local389,Local376),Local348,DERIV_BASE_VALUE(Local104));
	MaterialFloat Local391 = saturate(Local284);
	MaterialFloat3 Local392 = (Local390 * ((MaterialFloat3)DERIV_BASE_VALUE(Local391)));
	MaterialFloat3 Local393 = (Local339 + Local392);
	MaterialFloat Local394 = (Local171 * Material.PreshaderBuffer[26].y);
	MaterialFloat3 Local395 = (((MaterialFloat3)Local394) + Local172);
	MaterialFloat Local396 = (Material.PreshaderBuffer[26].z * Local174);
	MaterialFloat2 Local397 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local396,Local396));
	MaterialFloat4 Local398 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,DERIV_BASE_VALUE(Local183),-1.00000000));
	FLWCVector3 Local399 = LWCMultiply(Local398.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local400 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local183),-1.00000000));
	MaterialFloat3 Local401 = (((MaterialFloat3)-0.50000000) + Local400.rgb);
	MaterialFloat3 Local402 = (Local401 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local403 = LWCMultiplyVector(Local402, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local404 = normalize(Local403);
	MaterialFloat Local405 = (Local400.a * 2048.00000000);
	MaterialFloat Local406 = max(Local405,8.00000000);
	MaterialFloat3 Local407 = (Local404 * ((MaterialFloat3)Local406));
	FLWCVector3 Local408 = LWCAdd(Local399, LWCPromote(Local407));
	FLWCScalar Local409 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000)), Local408);
	FLWCScalar Local410 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local408);
	FLWCVector2 Local411 = LWCAdd(LWCPromote(Local397), MakeLWCVector(LWCPromote(Local409),LWCPromote(Local410)));
	MaterialFloat2 Local412 = LWCFrac(Local411);
	MaterialFloat4 Local413 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local412,-1.00000000));
	MaterialFloat Local414 = (Local395.x * Local413.a);
	MaterialFloat Local415 = dot(MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000),Local404);
	MaterialFloat Local416 = (Local415 + Material.PreshaderBuffer[21].w);
	MaterialFloat Local417 = (Local416 * Material.PreshaderBuffer[22].x);
	MaterialFloat Local418 = (Local414 * Local417);
	FLWCVector3 Local419 = LWCSubtract(DERIV_BASE_VALUE(Local104), Local399);
	MaterialFloat3 Local420 = (LWCToFloat(Local419) / DERIV_BASE_VALUE(Local257));
	MaterialFloat3 Local421 = normalize(Local404);
	MaterialFloat Local422 = dot(Local420,Local421);
	MaterialFloat Local423 = (Material.PreshaderBuffer[26].w * Local406);
	MaterialFloat Local424 = (Local422 / Local423);
	MaterialFloat Local425 = saturate(Local424);
	MaterialFloat Local426 = (Local418 * Local425);
	MaterialFloat Local427 = (Local426 * 6.28318548);
	FLWCVector2 Local428 = LWCMultiply(Local411, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[27].y)));
	MaterialFloat2 Local429 = LWCFrac(Local428);
	MaterialFloat4 Local430 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_10,samplerMaterial_Texture2D_10,Local429,-1.00000000));
	MaterialFloat3 Local431 = (Local430.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local432 = (((MaterialFloat3)Material.PreshaderBuffer[27].z) * Local431);
	MaterialFloat Local433 = PositiveClampedPow(Local415,5.00000000);
	MaterialFloat3 Local434 = (((MaterialFloat3)Local433) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local435 = (Local434 + MaterialFloat3(MaterialFloat2(Local181,Local182),0.00000000));
	MaterialFloat3 Local436 = cross(Local404,Local435);
	MaterialFloat3 Local437 = (Local432 + Local436);
	MaterialFloat3 Local438 = (Local437 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local439 = length(Local438);
	MaterialFloat3 Local440 = (Local437 / ((MaterialFloat3)Local439));
	MaterialFloat3 Local441 = RotateAboutAxis(MaterialFloat4(Local440,Local427),Local399,DERIV_BASE_VALUE(Local104));
	MaterialFloat3 Local442 = (Local441 * ((MaterialFloat3)DERIV_BASE_VALUE(Local345)));
	MaterialFloat3 Local443 = (Local393 + Local442);
	MaterialFloat3 Local444 = (Local443 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local445 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local131),Local444,Local443);
	MaterialFloat4 Local446 = Parameters.VertexColor;
	MaterialFloat Local447 = DERIV_BASE_VALUE(Local446).g;
	MaterialFloat3 Local448 = (Local445 * ((MaterialFloat3)DERIV_BASE_VALUE(Local447)));
	MaterialFloat Local449 = CustomExpression9(Parameters,Local97.g);
	MaterialFloat Local450 = (Local449 * 0.03000000);
	MaterialFloat Local451 = (Local170.r * 0.00500000);
	MaterialFloat Local452 = (Local450 + Local451);
	MaterialFloat Local453 = (Local452 * Material.PreshaderBuffer[27].w);
	MaterialFloat3 Local454 = (Local448 * ((MaterialFloat3)Local453));
	MaterialFloat3 Local455 = (Local454 + Local443);
	MaterialFloat3 Local456 = CustomExpression10(Parameters,Local455);
	return Local456;;
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
	MaterialFloat Local457 = (Local53.b * Material.PreshaderBuffer[29].x);
	MaterialFloat3 Local458 = (Local62 * ((MaterialFloat3)Local457));
	MaterialFloat Local459 = dot(Local458,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local460 = lerp(Local458,((MaterialFloat3)Local459),Material.PreshaderBuffer[29].z);
	MaterialFloat3 Local461 = PositiveClampedPow(Local460,((MaterialFloat3)Material.PreshaderBuffer[29].w));
	MaterialFloat3 Local462 = (((MaterialFloat3)1.00000000) - Local461);
	MaterialFloat3 Local463 = (Local462 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local464 = (Local463 * Material.PreshaderBuffer[32].xyz);
	MaterialFloat3 Local465 = (((MaterialFloat3)1.00000000) - Local464);
	MaterialFloat3 Local466 = (Local461 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local467 = (Local466 * Material.PreshaderBuffer[31].xyz);
	MaterialFloat Local468 = select((Local461.r >= 0.50000000), Local465.r, Local467.r);
	MaterialFloat Local469 = select((Local461.g >= 0.50000000), Local465.g, Local467.g);
	MaterialFloat Local470 = select((Local461.b >= 0.50000000), Local465.b, Local467.b);
	MaterialFloat4 Local471 = Parameters.VertexColor;
	MaterialFloat Local472 = DERIV_BASE_VALUE(Local471).a;
	MaterialFloat3 Local473 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)DERIV_BASE_VALUE(Local472)),Local57);
	MaterialFloat3 Local474 = lerp(Local461,MaterialFloat3(MaterialFloat2(Local468,Local469),Local470),Local473);
	MaterialFloat3 Local475 = lerp(Local461,Local474,Material.PreshaderBuffer[32].w);

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
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local475,Material.PreshaderBuffer[33].x);
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