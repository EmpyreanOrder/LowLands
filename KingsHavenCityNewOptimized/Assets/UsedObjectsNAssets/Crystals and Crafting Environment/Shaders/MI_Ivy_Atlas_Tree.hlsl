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
	float4 PreshaderBuffer[29];
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
	Material.PreshaderBuffer[9] = float4(1.500000,10000.000000,0.000100,1.100000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(1.000000,0.000000,17.000000,5.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(17.000000,0.058824,0.058824,0.200000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.700000,-0.875000,-0.875000,-0.444400);//(Unknown)
	Material.PreshaderBuffer[13] = float4(-0.875000,-0.444400,3.000000,4.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.250000,2.000000,0.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(3.000000,3.000000,0.333333,2.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.500000,0.000000,3.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.500000,2.000000,0.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(3.000000,1.000000,1.000000,2.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(2.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.000000,0.720000,1.500000,0.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.720000,1.000000,0.000000,1.500000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.500000,1.000000,0.200000,1.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(0.500000,1.000000,0.200000,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.500000,0.000000,0.800000,1.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
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
	MaterialFloat4 Local57 = MaterialCollection0.Vectors[0];
	MaterialFloat Local58 = CustomExpression1(Parameters,Local57.b);
	MaterialFloat Local59 = (Local58 * 0.10000000);
	MaterialFloat Local60 = (Local59 * Material.PreshaderBuffer[9].w);
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
	MaterialFloat Local92 = (Local59 * 0.05000000);
	MaterialFloat Local93 = (Local92 * Material.PreshaderBuffer[10].x);
	FLWCVector2 Local94 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local64)), LWCGetY(DERIV_BASE_VALUE(Local64)));
	FLWCVector2 Local95 = LWCMultiply(DERIV_BASE_VALUE(Local94), LWCPromote(((MaterialFloat2)0.00010000)));
	MaterialFloat2 Local96 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local95), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat4 Local97 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_4,samplerMaterial_Texture2D_4,Local96,-1.00000000));
	FLWCVector3 Local98 = LWCMultiply(DERIV_BASE_VALUE(Local64), LWCPromote(((MaterialFloat3)0.00010000)));
	FLWCVector2 Local99 = MakeLWCVector(LWCGetComponent(DERIV_BASE_VALUE(Local98), 0),LWCGetComponent(DERIV_BASE_VALUE(Local98), 1));
	FLWCVector2 Local100 = LWCAdd(LWCPromote(MaterialFloat2(-0.50000000,-0.50000000)), DERIV_BASE_VALUE(Local99));
	MaterialFloat Local101 = CustomExpression2(Parameters,Local57.r);
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
	MaterialFloat Local112 = CustomExpression4(Parameters,Local57.a);
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
	MaterialFloat Local131 = (Local59 * 0.10000000);
	MaterialFloat3 Local132 = (Local130 * ((MaterialFloat3)Local131));
	MaterialFloat3 Local133 = (((MaterialFloat3)Local93) + Local132);
	MaterialFloat Local134 = (Local59 * 0.50000000);
	MaterialFloat Local135 = (Material.PreshaderBuffer[10].y * Local134);
	MaterialFloat2 Local136 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local135,Local135));
	MaterialFloat Local137 = CustomExpression5(Parameters,Local57.r);
	MaterialFloat Local138 = (1.00000000 - Local137);
	MaterialFloat Local139 = (Local138 + 0.64999998);
	MaterialFloat Local140 = (Local139 * 6.28318548);
	MaterialFloat Local141 = cos(Local140);
	MaterialFloat Local142 = sin(Local140);
	MaterialFloat2 Local143 = Parameters.TexCoords[1].xy;
	MaterialFloat4 Local144 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local143),-1.00000000));
	MaterialFloat Local145 = CustomExpression6(Parameters,Local144.a);
	MaterialFloat Local146 = fmod(Local145,Material.PreshaderBuffer[11].x);
	MaterialFloat Local147 = (Local145 * Material.PreshaderBuffer[11].y);
	MaterialFloat Local148 = floor(Local147);
	MaterialFloat2 Local149 = (MaterialFloat2(Local146,Local148) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local150 = (Local149 * Material.PreshaderBuffer[11].zw);
	MaterialFloat4 Local151 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,MaterialFloat2(Local150.r,Local150.g),-1.00000000));
	MaterialFloat Local152 = CustomExpression7(Parameters,Local151.a);
	MaterialFloat Local153 = select((abs(Local152 - Local145) > 0.00001000), select((Local152 >= Local145), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat2 Local154 = (DERIV_BASE_VALUE(Local143) * Material.PreshaderBuffer[10].zw);
	MaterialFloat2 Local155 = floor(DERIV_BASE_VALUE(Local154));
	MaterialFloat Local156 = (Local155.g * Material.PreshaderBuffer[11].x);
	MaterialFloat Local157 = (Local155.r + Local156);
	MaterialFloat Local158 = select((abs(Local145 - Local157) > 0.00001000), select((Local145 >= Local157), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local159 = (Local153.r + Local158.r);
	MaterialFloat Local160 = fmod(Local152,Material.PreshaderBuffer[11].x);
	MaterialFloat Local161 = (Local152 * Material.PreshaderBuffer[11].y);
	MaterialFloat Local162 = floor(Local161);
	MaterialFloat2 Local163 = (MaterialFloat2(Local160,Local162) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local164 = (Local163 * Material.PreshaderBuffer[11].zw);
	MaterialFloat4 Local165 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_6,samplerMaterial_Texture2D_6,MaterialFloat2(Local164.r,Local164.g),-1.00000000));
	MaterialFloat Local166 = CustomExpression8(Parameters,Local165.a);
	MaterialFloat Local167 = select((abs(Local166 - Local152) > 0.00001000), select((Local166 >= Local152), 1.00000000, 1.00000000), 0.00000000);
	MaterialFloat Local168 = (Local159 + Local167.r);
	MaterialFloat Local169 = ceil(Local168);
	MaterialFloat Local170 = (Local169 / 3.00000000);
	MaterialFloat Local171 = (Local170 * 3.00000000);
	MaterialFloat Local172 = saturate(Local171);
	MaterialFloat2 Local173 = lerp(DERIV_BASE_VALUE(Local143),MaterialFloat2(Local150.r,Local150.g),DERIV_BASE_VALUE(Local172));
	MaterialFloat Local174 = (Local171 - 1.00000000);
	MaterialFloat Local175 = saturate(Local174);
	MaterialFloat2 Local176 = lerp(Local173,MaterialFloat2(Local164.r,Local164.g),DERIV_BASE_VALUE(Local175));
	MaterialFloat Local177 = fmod(Local166,Material.PreshaderBuffer[11].x);
	MaterialFloat Local178 = (Local166 * Material.PreshaderBuffer[11].y);
	MaterialFloat Local179 = floor(Local178);
	MaterialFloat2 Local180 = (MaterialFloat2(Local177,Local179) + ((MaterialFloat2)0.50000000));
	MaterialFloat2 Local181 = (Local180 * Material.PreshaderBuffer[11].zw);
	MaterialFloat Local182 = (Local174 - 1.00000000);
	MaterialFloat Local183 = saturate(Local182);
	MaterialFloat2 Local184 = lerp(Local176,MaterialFloat2(Local181.r,Local181.g),DERIV_BASE_VALUE(Local183));
	MaterialFloat4 Local185 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,Local184,-1.00000000));
	FLWCVector3 Local186 = LWCMultiply(Local185.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local187 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local184,-1.00000000));
	MaterialFloat3 Local188 = (((MaterialFloat3)-0.50000000) + Local187.rgb);
	MaterialFloat3 Local189 = (Local188 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local190 = LWCMultiplyVector(Local189, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local191 = normalize(Local190);
	MaterialFloat Local192 = (Local187.a * 2048.00000000);
	MaterialFloat Local193 = max(Local192,8.00000000);
	MaterialFloat3 Local194 = (Local191 * ((MaterialFloat3)Local193));
	FLWCVector3 Local195 = LWCAdd(Local186, LWCPromote(Local194));
	FLWCScalar Local196 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000)), Local195);
	FLWCScalar Local197 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local195);
	FLWCVector2 Local198 = LWCAdd(LWCPromote(Local136), MakeLWCVector(LWCPromote(Local196),LWCPromote(Local197)));
	MaterialFloat2 Local199 = LWCFrac(Local198);
	MaterialFloat4 Local200 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local199,-1.00000000));
	MaterialFloat Local201 = (Local133.x * Local200.a);
	MaterialFloat Local202 = dot(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000),Local191);
	MaterialFloat Local203 = (Local202 + Material.PreshaderBuffer[13].x);
	MaterialFloat Local204 = (Local203 * Material.PreshaderBuffer[13].y);
	MaterialFloat Local205 = (Local201 * Local204);
	FLWCVector3 Local206 = LWCSubtract(DERIV_BASE_VALUE(Local64), Local186);
	MaterialFloat3 Local207 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(1.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local208 = (((MaterialFloat3)0.00000000) - Local207);
	MaterialFloat Local209 = length(Local208);
	MaterialFloat3 Local210 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,1.00000000,0.00000000));
	MaterialFloat3 Local211 = (((MaterialFloat3)0.00000000) - Local210);
	MaterialFloat Local212 = length(Local211);
	MaterialFloat2 Local213 = MaterialFloat2(DERIV_BASE_VALUE(Local209),DERIV_BASE_VALUE(Local212));
	MaterialFloat3 Local214 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,1.00000000));
	MaterialFloat3 Local215 = (((MaterialFloat3)0.00000000) - Local214);
	MaterialFloat Local216 = length(Local215);
	MaterialFloat3 Local217 = MaterialFloat3(DERIV_BASE_VALUE(Local213),DERIV_BASE_VALUE(Local216));
	MaterialFloat3 Local218 = (LWCToFloat(Local206) / DERIV_BASE_VALUE(Local217));
	MaterialFloat3 Local219 = normalize(Local191);
	MaterialFloat Local220 = dot(Local218,Local219);
	MaterialFloat Local221 = (Material.PreshaderBuffer[13].z * Local193);
	MaterialFloat Local222 = (Local220 / Local221);
	MaterialFloat Local223 = saturate(Local222);
	MaterialFloat Local224 = (Local205 * Local223);
	MaterialFloat Local225 = (Local224 * 6.28318548);
	FLWCVector2 Local226 = LWCMultiply(Local198, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[14].x)));
	MaterialFloat2 Local227 = LWCFrac(Local226);
	MaterialFloat4 Local228 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local227,-1.00000000));
	MaterialFloat3 Local229 = (Local228.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local230 = (((MaterialFloat3)Material.PreshaderBuffer[14].y) * Local229);
	MaterialFloat Local231 = PositiveClampedPow(Local202,5.00000000);
	MaterialFloat3 Local232 = (((MaterialFloat3)Local231) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local233 = (Local232 + MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000));
	MaterialFloat3 Local234 = cross(Local191,Local233);
	MaterialFloat3 Local235 = (Local230 + Local234);
	MaterialFloat3 Local236 = (Local235 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local237 = length(Local236);
	MaterialFloat3 Local238 = (Local235 / ((MaterialFloat3)Local237));
	MaterialFloat3 Local239 = RotateAboutAxis(MaterialFloat4(Local238,Local225),Local186,DERIV_BASE_VALUE(Local64));
	MaterialFloat Local240 = (Local131 * Material.PreshaderBuffer[14].z);
	MaterialFloat3 Local241 = (((MaterialFloat3)Local240) + Local132);
	MaterialFloat Local242 = (Material.PreshaderBuffer[14].w * Local134);
	MaterialFloat2 Local243 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local242,Local242));
	MaterialFloat Local244 = (Local169 - 1.00000000);
	MaterialFloat Local245 = (Local244 / 2.00000000);
	MaterialFloat Local246 = saturate(Local245);
	MaterialFloat Local247 = (DERIV_BASE_VALUE(Local246) * 2.00000000);
	MaterialFloat Local248 = saturate(DERIV_BASE_VALUE(Local247));
	MaterialFloat2 Local249 = lerp(DERIV_BASE_VALUE(Local143),MaterialFloat2(Local150.r,Local150.g),DERIV_BASE_VALUE(Local248));
	MaterialFloat Local250 = (DERIV_BASE_VALUE(Local247) - 1.00000000);
	MaterialFloat Local251 = saturate(DERIV_BASE_VALUE(Local250));
	MaterialFloat2 Local252 = lerp(Local249,MaterialFloat2(Local164.r,Local164.g),DERIV_BASE_VALUE(Local251));
	MaterialFloat4 Local253 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,Local252,-1.00000000));
	FLWCVector3 Local254 = LWCMultiply(Local253.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local255 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local252,-1.00000000));
	MaterialFloat3 Local256 = (((MaterialFloat3)-0.50000000) + Local255.rgb);
	MaterialFloat3 Local257 = (Local256 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local258 = LWCMultiplyVector(Local257, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local259 = normalize(Local258);
	MaterialFloat Local260 = (Local255.a * 2048.00000000);
	MaterialFloat Local261 = max(Local260,8.00000000);
	MaterialFloat3 Local262 = (Local259 * ((MaterialFloat3)Local261));
	FLWCVector3 Local263 = LWCAdd(Local254, LWCPromote(Local262));
	FLWCScalar Local264 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000)), Local263);
	FLWCScalar Local265 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local263);
	FLWCVector2 Local266 = LWCAdd(LWCPromote(Local243), MakeLWCVector(LWCPromote(Local264),LWCPromote(Local265)));
	MaterialFloat2 Local267 = LWCFrac(Local266);
	MaterialFloat4 Local268 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local267,-1.00000000));
	MaterialFloat Local269 = (Local241.x * Local268.a);
	MaterialFloat Local270 = dot(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000),Local259);
	MaterialFloat Local271 = (Local270 + Material.PreshaderBuffer[13].x);
	MaterialFloat Local272 = (Local271 * Material.PreshaderBuffer[13].y);
	MaterialFloat Local273 = (Local269 * Local272);
	FLWCVector3 Local274 = LWCSubtract(DERIV_BASE_VALUE(Local64), Local254);
	MaterialFloat3 Local275 = (LWCToFloat(Local274) / DERIV_BASE_VALUE(Local217));
	MaterialFloat3 Local276 = normalize(Local259);
	MaterialFloat Local277 = dot(Local275,Local276);
	MaterialFloat Local278 = (Material.PreshaderBuffer[15].x * Local261);
	MaterialFloat Local279 = (Local277 / Local278);
	MaterialFloat Local280 = saturate(Local279);
	MaterialFloat Local281 = (Local273 * Local280);
	MaterialFloat Local282 = (Local281 * 6.28318548);
	FLWCVector2 Local283 = LWCMultiply(Local266, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[15].z)));
	MaterialFloat2 Local284 = LWCFrac(Local283);
	MaterialFloat4 Local285 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local284,-1.00000000));
	MaterialFloat3 Local286 = (Local285.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local287 = (((MaterialFloat3)Material.PreshaderBuffer[15].w) * Local286);
	MaterialFloat Local288 = PositiveClampedPow(Local270,5.00000000);
	MaterialFloat3 Local289 = (((MaterialFloat3)Local288) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local290 = (Local289 + MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000));
	MaterialFloat3 Local291 = cross(Local259,Local290);
	MaterialFloat3 Local292 = (Local287 + Local291);
	MaterialFloat3 Local293 = (Local292 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local294 = length(Local293);
	MaterialFloat3 Local295 = (Local292 / ((MaterialFloat3)Local294));
	MaterialFloat3 Local296 = RotateAboutAxis(MaterialFloat4(Local295,Local282),Local254,DERIV_BASE_VALUE(Local64));
	MaterialFloat Local297 = saturate(Local169);
	MaterialFloat3 Local298 = (Local296 * ((MaterialFloat3)DERIV_BASE_VALUE(Local297)));
	MaterialFloat3 Local299 = (Local239 + Local298);
	MaterialFloat Local300 = (Local131 * Material.PreshaderBuffer[16].x);
	MaterialFloat3 Local301 = (((MaterialFloat3)Local300) + Local132);
	MaterialFloat Local302 = (Material.PreshaderBuffer[16].y * Local134);
	MaterialFloat2 Local303 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local302,Local302));
	MaterialFloat Local304 = (Local169 - 2.00000000);
	MaterialFloat Local305 = saturate(Local304);
	MaterialFloat2 Local306 = lerp(DERIV_BASE_VALUE(Local143),MaterialFloat2(Local150.r,Local150.g),DERIV_BASE_VALUE(Local305));
	MaterialFloat4 Local307 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,Local306,-1.00000000));
	FLWCVector3 Local308 = LWCMultiply(Local307.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local309 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,Local306,-1.00000000));
	MaterialFloat3 Local310 = (((MaterialFloat3)-0.50000000) + Local309.rgb);
	MaterialFloat3 Local311 = (Local310 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local312 = LWCMultiplyVector(Local311, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local313 = normalize(Local312);
	MaterialFloat Local314 = (Local309.a * 2048.00000000);
	MaterialFloat Local315 = max(Local314,8.00000000);
	MaterialFloat3 Local316 = (Local313 * ((MaterialFloat3)Local315));
	FLWCVector3 Local317 = LWCAdd(Local308, LWCPromote(Local316));
	FLWCScalar Local318 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000)), Local317);
	FLWCScalar Local319 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local317);
	FLWCVector2 Local320 = LWCAdd(LWCPromote(Local303), MakeLWCVector(LWCPromote(Local318),LWCPromote(Local319)));
	MaterialFloat2 Local321 = LWCFrac(Local320);
	MaterialFloat4 Local322 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local321,-1.00000000));
	MaterialFloat Local323 = (Local301.x * Local322.a);
	MaterialFloat Local324 = dot(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000),Local313);
	MaterialFloat Local325 = (Local324 + Material.PreshaderBuffer[13].x);
	MaterialFloat Local326 = (Local325 * Material.PreshaderBuffer[13].y);
	MaterialFloat Local327 = (Local323 * Local326);
	FLWCVector3 Local328 = LWCSubtract(DERIV_BASE_VALUE(Local64), Local308);
	MaterialFloat3 Local329 = (LWCToFloat(Local328) / DERIV_BASE_VALUE(Local217));
	MaterialFloat3 Local330 = normalize(Local313);
	MaterialFloat Local331 = dot(Local329,Local330);
	MaterialFloat Local332 = (Material.PreshaderBuffer[16].z * Local315);
	MaterialFloat Local333 = (Local331 / Local332);
	MaterialFloat Local334 = saturate(Local333);
	MaterialFloat Local335 = (Local327 * Local334);
	MaterialFloat Local336 = (Local335 * 6.28318548);
	FLWCVector2 Local337 = LWCMultiply(Local320, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[17].x)));
	MaterialFloat2 Local338 = LWCFrac(Local337);
	MaterialFloat4 Local339 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local338,-1.00000000));
	MaterialFloat3 Local340 = (Local339.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local341 = (((MaterialFloat3)Material.PreshaderBuffer[17].y) * Local340);
	MaterialFloat Local342 = PositiveClampedPow(Local324,5.00000000);
	MaterialFloat3 Local343 = (((MaterialFloat3)Local342) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local344 = (Local343 + MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000));
	MaterialFloat3 Local345 = cross(Local313,Local344);
	MaterialFloat3 Local346 = (Local341 + Local345);
	MaterialFloat3 Local347 = (Local346 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local348 = length(Local347);
	MaterialFloat3 Local349 = (Local346 / ((MaterialFloat3)Local348));
	MaterialFloat3 Local350 = RotateAboutAxis(MaterialFloat4(Local349,Local336),Local308,DERIV_BASE_VALUE(Local64));
	MaterialFloat Local351 = saturate(Local244);
	MaterialFloat3 Local352 = (Local350 * ((MaterialFloat3)DERIV_BASE_VALUE(Local351)));
	MaterialFloat3 Local353 = (Local299 + Local352);
	MaterialFloat Local354 = (Local131 * Material.PreshaderBuffer[17].z);
	MaterialFloat3 Local355 = (((MaterialFloat3)Local354) + Local132);
	MaterialFloat Local356 = (Material.PreshaderBuffer[17].w * Local134);
	MaterialFloat2 Local357 = (((MaterialFloat2)fmod(View.GameTime,99999997952.00000000)) * MaterialFloat2(Local356,Local356));
	MaterialFloat4 Local358 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local143),-1.00000000));
	FLWCVector3 Local359 = LWCMultiply(Local358.rgb, GetInstanceToWorld(Parameters));
	MaterialFloat4 Local360 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_8,samplerMaterial_Texture2D_8,DERIV_BASE_VALUE(Local143),-1.00000000));
	MaterialFloat3 Local361 = (((MaterialFloat3)-0.50000000) + Local360.rgb);
	MaterialFloat3 Local362 = (Local361 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local363 = LWCMultiplyVector(Local362, GetInstanceToWorld(Parameters));
	MaterialFloat3 Local364 = normalize(Local363);
	MaterialFloat Local365 = (Local360.a * 2048.00000000);
	MaterialFloat Local366 = max(Local365,8.00000000);
	MaterialFloat3 Local367 = (Local364 * ((MaterialFloat3)Local366));
	FLWCVector3 Local368 = LWCAdd(Local359, LWCPromote(Local367));
	FLWCScalar Local369 = LWCDot(LWCPromote(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000)), Local368);
	FLWCScalar Local370 = LWCDot(LWCPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000)), Local368);
	FLWCVector2 Local371 = LWCAdd(LWCPromote(Local357), MakeLWCVector(LWCPromote(Local369),LWCPromote(Local370)));
	MaterialFloat2 Local372 = LWCFrac(Local371);
	MaterialFloat4 Local373 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local372,-1.00000000));
	MaterialFloat Local374 = (Local355.x * Local373.a);
	MaterialFloat Local375 = dot(MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000),Local364);
	MaterialFloat Local376 = (Local375 + Material.PreshaderBuffer[13].x);
	MaterialFloat Local377 = (Local376 * Material.PreshaderBuffer[13].y);
	MaterialFloat Local378 = (Local374 * Local377);
	FLWCVector3 Local379 = LWCSubtract(DERIV_BASE_VALUE(Local64), Local359);
	MaterialFloat3 Local380 = (LWCToFloat(Local379) / DERIV_BASE_VALUE(Local217));
	MaterialFloat3 Local381 = normalize(Local364);
	MaterialFloat Local382 = dot(Local380,Local381);
	MaterialFloat Local383 = (Material.PreshaderBuffer[18].x * Local366);
	MaterialFloat Local384 = (Local382 / Local383);
	MaterialFloat Local385 = saturate(Local384);
	MaterialFloat Local386 = (Local378 * Local385);
	MaterialFloat Local387 = (Local386 * 6.28318548);
	FLWCVector2 Local388 = LWCMultiply(Local371, LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[18].z)));
	MaterialFloat2 Local389 = LWCFrac(Local388);
	MaterialFloat4 Local390 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleLevel(Material_Texture2D_9,samplerMaterial_Texture2D_9,Local389,-1.00000000));
	MaterialFloat3 Local391 = (Local390.rgb - ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local392 = (((MaterialFloat3)Material.PreshaderBuffer[18].w) * Local391);
	MaterialFloat Local393 = PositiveClampedPow(Local375,5.00000000);
	MaterialFloat3 Local394 = (((MaterialFloat3)Local393) * MaterialFloat3(0.00000000,0.00000000,-0.20000000));
	MaterialFloat3 Local395 = (Local394 + MaterialFloat3(MaterialFloat2(Local141,Local142),0.00000000));
	MaterialFloat3 Local396 = cross(Local364,Local395);
	MaterialFloat3 Local397 = (Local392 + Local396);
	MaterialFloat3 Local398 = (Local397 - ((MaterialFloat3)0.00000000));
	MaterialFloat Local399 = length(Local398);
	MaterialFloat3 Local400 = (Local397 / ((MaterialFloat3)Local399));
	MaterialFloat3 Local401 = RotateAboutAxis(MaterialFloat4(Local400,Local387),Local359,DERIV_BASE_VALUE(Local64));
	MaterialFloat3 Local402 = (Local401 * ((MaterialFloat3)DERIV_BASE_VALUE(Local305)));
	MaterialFloat3 Local403 = (Local353 + Local402);
	MaterialFloat3 Local404 = (Local403 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local405 = RotateAboutAxis(MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),Local91),Local404,Local403);
	MaterialFloat4 Local406 = Parameters.VertexColor;
	MaterialFloat Local407 = DERIV_BASE_VALUE(Local406).g;
	MaterialFloat3 Local408 = (Local405 * ((MaterialFloat3)DERIV_BASE_VALUE(Local407)));
	MaterialFloat Local409 = CustomExpression9(Parameters,Local57.g);
	MaterialFloat Local410 = (Local409 * 0.03000000);
	MaterialFloat Local411 = (Local130.r * 0.00500000);
	MaterialFloat Local412 = (Local410 + Local411);
	MaterialFloat Local413 = (Local412 * Material.PreshaderBuffer[19].x);
	MaterialFloat3 Local414 = (Local408 * ((MaterialFloat3)Local413));
	MaterialFloat3 Local415 = (Local414 + Local403);
	MaterialFloat3 Local416 = CustomExpression10(Parameters,Local415);
	return Local416;;
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
	MaterialFloat Local417 = (Local14.b * Material.PreshaderBuffer[21].x);
	MaterialFloat3 Local418 = (Local12 * ((MaterialFloat3)Local417));
	MaterialFloat Local419 = dot(Local418,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local420 = lerp(Local418,((MaterialFloat3)Local419),Material.PreshaderBuffer[21].z);
	MaterialFloat3 Local421 = PositiveClampedPow(Local420,((MaterialFloat3)Material.PreshaderBuffer[21].w));
	MaterialFloat3 Local422 = (((MaterialFloat3)1.00000000) - Local421);
	MaterialFloat3 Local423 = (Local422 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local424 = (Local423 * Material.PreshaderBuffer[24].xyz);
	MaterialFloat3 Local425 = (((MaterialFloat3)1.00000000) - Local424);
	MaterialFloat3 Local426 = (Local421 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local427 = (Local426 * Material.PreshaderBuffer[23].xyz);
	MaterialFloat Local428 = select((Local421.r >= 0.50000000), Local425.r, Local427.r);
	MaterialFloat Local429 = select((Local421.g >= 0.50000000), Local425.g, Local427.g);
	MaterialFloat Local430 = select((Local421.b >= 0.50000000), Local425.b, Local427.b);
	MaterialFloat3 Local431 = lerp(Local421,MaterialFloat3(MaterialFloat2(Local428,Local429),Local430),Material.PreshaderBuffer[24].w);
	MaterialFloat3 Local432 = (((MaterialFloat3)1.00000000) - Local431);
	MaterialFloat3 Local433 = (Local432 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local434 = (Local433 * Material.PreshaderBuffer[27].xyz);
	MaterialFloat3 Local435 = (((MaterialFloat3)1.00000000) - Local434);
	MaterialFloat3 Local436 = (Local431 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local437 = (Local436 * Material.PreshaderBuffer[26].xyz);
	MaterialFloat Local438 = select((Local431.r >= 0.50000000), Local435.r, Local437.r);
	MaterialFloat Local439 = select((Local431.g >= 0.50000000), Local435.g, Local437.g);
	MaterialFloat Local440 = select((Local431.b >= 0.50000000), Local435.b, Local437.b);
	MaterialFloat4 Local441 = Parameters.VertexColor;
	MaterialFloat Local442 = DERIV_BASE_VALUE(Local441).a;
	MaterialFloat3 Local443 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),((MaterialFloat3)DERIV_BASE_VALUE(Local442)),Local24);
	MaterialFloat3 Local444 = lerp(Local431,MaterialFloat3(MaterialFloat2(Local438,Local439),Local440),Local443);
	MaterialFloat3 Local445 = lerp(Local431,Local444,Material.PreshaderBuffer[27].w);

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
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local445,Material.PreshaderBuffer[28].x);
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