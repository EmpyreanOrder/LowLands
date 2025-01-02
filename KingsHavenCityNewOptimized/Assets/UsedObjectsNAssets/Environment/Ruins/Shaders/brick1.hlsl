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
SAMPLER( sampler_Material_Texture2D_0 );
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER( sampler_Material_Texture2D_1 );
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER( sampler_Material_Texture2D_2 );
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER( sampler_Material_Texture2D_3 );
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER( sampler_Material_Texture2D_4 );
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER( sampler_Material_Texture2D_5 );
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER( sampler_Material_Texture2D_6 );
TEXTURE2D(       Material_Texture2D_7 );
SAMPLER( sampler_Material_Texture2D_7 );

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
	float4 PreshaderBuffer[13];
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
	Material.PreshaderBuffer[1] = float4(1.500000,10.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.024678,0.360000,0.276553,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.024678,0.360000,0.276553,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,2.000000,0.000000,-1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.000000,0.800000,32.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(8.000000,0.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat4 CustomExpression2(FMaterialPixelParameters Parameters,Texture2D Tex, SamplerState TexSampler ,MaterialFloat2 UV,MaterialFloat MaxSteps,MaterialFloat stepsize,MaterialFloat2 UVDist,MaterialFloat2 InDDX,MaterialFloat2 InDDY,MaterialFloat4 HeightMapChannel)
{
float rayheight=1;
float oldray=1;
float2 offset=0;
float oldtex=1;
float texatray;
float yintersect;
int i=0;

LOOP
while (i<MaxSteps+2)
{
texatray=dot(HeightMapChannel, Texture2DSampleGrad( Tex, TexSampler,UV+offset,InDDX, InDDY));

if (rayheight < texatray)
{
float xintersect = (oldray-oldtex)+(texatray-rayheight);
xintersect=(texatray-rayheight)/xintersect;
yintersect=(oldray*(xintersect))+(rayheight*(1-xintersect));
offset-=(xintersect*UVDist);
break;
}

oldray=rayheight;
rayheight-=stepsize;
offset+=UVDist;
oldtex=texatray;


i++;
}

float4 output;
output.xy=offset;
output.z=yintersect; output.w=1;
return output; 
}

MaterialFloat4 CustomExpression1(FMaterialPixelParameters Parameters,Texture2D Tex, SamplerState TexSampler ,MaterialFloat2 UV,MaterialFloat MaxSteps,MaterialFloat stepsize,MaterialFloat2 UVDist,MaterialFloat2 InDDX,MaterialFloat2 InDDY,MaterialFloat4 HeightMapChannel)
{
float rayheight=1;
float oldray=1;
float2 offset=0;
float oldtex=1;
float texatray;
float yintersect;
int i=0;

LOOP
while (i<MaxSteps+2)
{
texatray=dot(HeightMapChannel, Texture2DSampleGrad( Tex, TexSampler,UV+offset,InDDX, InDDY));

if (rayheight < texatray)
{
float xintersect = (oldray-oldtex)+(texatray-rayheight);
xintersect=(texatray-rayheight)/xintersect;
yintersect=(oldray*(xintersect))+(rayheight*(1-xintersect));
offset-=(xintersect*UVDist);
break;
}

oldray=rayheight;
rayheight-=stepsize;
offset+=UVDist;
oldtex=texatray;


i++;
}

float4 output;
output.xy=offset;
output.z=yintersect; output.w=1;
return output; 
}

MaterialFloat CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat2 p)
{
return Mod( ((uint)(p.x) + 2 * (uint)(p.y)) , 5 );
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	return MaterialFloat3(0.00000000,0.00000000,0.00000000);;
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
	MaterialFloat4 Local2 = Parameters.VertexColor;
	MaterialFloat Local3 = DERIV_BASE_VALUE(Local2).a;
	MaterialFloat Local4 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 5);
	MaterialFloat4 Local5 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,sampler_Material_Texture2D_0,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 5);
	MaterialFloat Local7 = (DERIV_BASE_VALUE(Local3) * Local5.a);
	MaterialFloat Local8 = (DERIV_BASE_VALUE(Local3) + Local7);
	MaterialFloat Local9 = PositiveClampedPow(Local8,Material.PreshaderBuffer[1].y);
	MaterialFloat Local10 = saturate(Local9);
	MaterialFloat Local11 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 3);
	MaterialFloat4 Local12 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_1,sampler_Material_Texture2D_1,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local13 = MaterialStoreTexSample(Parameters, Local12, 3);
	MaterialFloat3 Local14 = (Local12.rgb * MaterialFloat3(1.00000000,-1.00000000,1.00000000));
	MaterialFloat4 Local15 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_2,sampler_Material_Texture2D_2,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local16 = MaterialStoreTexSample(Parameters, Local15, 3);
	MaterialFloat3 Local17 = (Local15.rgb * MaterialFloat3(1.00000000,-1.00000000,1.00000000));
	MaterialFloat3 Local18 = lerp(Local14,Local17,Local10);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local18;


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
	MaterialFloat3 Local19 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[2].xyz,Material.PreshaderBuffer[1].z);
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 1);
	MaterialFloat4 Local21 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,sampler_Material_Texture2D_3,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 1);
	MaterialFloat3 Local23 = (Local21.rgb * Material.PreshaderBuffer[6].xyz);
	MaterialFloat Local24 = dot(Local23,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local25 = lerp(Local23,((MaterialFloat3)Local24),Material.PreshaderBuffer[6].w);
	MaterialFloat3 Local26 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[4].x),((MaterialFloat3)0.00000000),Local25);
	MaterialFloat3 Local27 = (Local26 + Local25);
	MaterialFloat3 Local28 = lerp(Material.PreshaderBuffer[7].yzw,((MaterialFloat3)Material.PreshaderBuffer[7].x),Local27);
	MaterialFloat3 Local29 = saturate(Local28);
	MaterialFloat3 Local30 = DERIV_BASE_VALUE(Local2).rgb;
	MaterialFloat3 Local31 = (Local29 * DERIV_BASE_VALUE(Local30));
	MaterialFloat4 Local32 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local33 = MaterialStoreTexSample(Parameters, Local32, 1);
	MaterialFloat3 Local34 = (Local32.rgb * Material.PreshaderBuffer[9].xyz);
	MaterialFloat Local35 = dot(Local34,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local36 = lerp(Local34,((MaterialFloat3)Local35),Material.PreshaderBuffer[6].w);
	MaterialFloat3 Local37 = RotateAboutAxis(MaterialFloat4(normalize(MaterialFloat3(1.00000000,1.00000000,1.00000000)),Material.PreshaderBuffer[4].x),((MaterialFloat3)0.00000000),Local36);
	MaterialFloat3 Local38 = (Local37 + Local36);
	MaterialFloat3 Local39 = lerp(Material.PreshaderBuffer[7].yzw,((MaterialFloat3)Material.PreshaderBuffer[7].x),Local38);
	MaterialFloat3 Local40 = saturate(Local39);
	MaterialFloat3 Local41 = (Local40 * DERIV_BASE_VALUE(Local30));
	MaterialFloat3 Local42 = lerp(Local31,Local41,Local10);
	MaterialFloat4 Local43 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,sampler_Material_Texture2D_5,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local44 = MaterialStoreTexSample(Parameters, Local43, 1);
	MaterialFloat Local45 = (Local43.b + Material.PreshaderBuffer[9].w);
	MaterialFloat4 Local46 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,sampler_Material_Texture2D_6,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias));
	MaterialFloat Local47 = MaterialStoreTexSample(Parameters, Local46, 1);
	MaterialFloat Local48 = (Local46.b + Material.PreshaderBuffer[10].x);
	MaterialFloat Local49 = lerp(Local45,Local48,Local10);
	MaterialFloat Local50 = (Local43.r + Material.PreshaderBuffer[10].y);
	MaterialFloat Local51 = (Local46.r + Material.PreshaderBuffer[10].z);
	MaterialFloat Local52 = lerp(Local50,Local51,Local10);
	MaterialFloat Local53 = (Local43.g + Material.PreshaderBuffer[10].w);
	MaterialFloat Local54 = (Local46.g + Material.PreshaderBuffer[11].x);
	MaterialFloat Local55 = lerp(Local53,Local54,Local10);
	MaterialFloat3 Local56 = mul((MaterialFloat3x3)(Parameters.TangentToWorld), Parameters.CameraVector);
	MaterialFloat2 Local57 = (Local56.rg * ((MaterialFloat2)-1.00000000));
	MaterialFloat2 Local58 = (Local57 / ((MaterialFloat2)Local56.b));
	MaterialFloat2 Local59 = (((MaterialFloat2)Material.PreshaderBuffer[11].y) * Local58);
	MaterialFloat2 Local60 = (Local59 * ((MaterialFloat2)((1.00000000 - 1.00000000) * -1.00000000)));
	MaterialFloat2 Local61 = (DERIV_BASE_VALUE(Local1) + Local60);
	MaterialFloat2 Local62 = GetPixelPosition(Parameters);
	MaterialFloat Local63 = View.TemporalAAParams.x;
	MaterialFloat2 Local64 = (Local62 + MaterialFloat2(Local63,Local63));
	MaterialFloat Local65 = CustomExpression0(Parameters,Local64);
	MaterialFloat2 Local66 = (Local62 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local67 = MaterialStoreTexCoordScale(Parameters, Local66, 2);
	MaterialFloat4 Local68 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_7,sampler_Material_Texture2D_7,Local66,View.MaterialTextureMipBias));
	MaterialFloat Local69 = MaterialStoreTexSample(Parameters, Local68, 2);
	MaterialFloat Local70 = (Local68.r * 1.00000000);
	MaterialFloat Local71 = (Local65 + Local70);
	MaterialFloat Local72 = (Local71 * 0.16665000);
	MaterialFloat Local73 = (0.50000000 + Local72);
	MaterialFloat Local74 = (Local73 + -0.50000000);
	MaterialFloat Local75 = lerp(1.00000000,Material.PreshaderBuffer[11].z,Local74);
	MaterialFloat Local76 = (Material.PreshaderBuffer[11].w * Local75);
	MaterialFloat Local77 = (Material.PreshaderBuffer[12].x * Local75);
	MaterialFloat Local78 = dot(Parameters.CameraVector,Parameters.TangentToWorld[2]);
	MaterialFloat Local79 = abs(Local78);
	MaterialFloat Local80 = saturate(Local79);
	MaterialFloat Local81 = lerp(Local76,Local77,Local80);
	MaterialFloat Local82 = floor(Local81);
	MaterialFloat Local83 = (1.00000000 / Local81);
	MaterialFloat2 Local84 = (Local59 * ((MaterialFloat2)Local83));
	MaterialFloat2 Local85 = ddx((float2)Local61);
	MaterialFloat2 Local86 = ddy((float2)Local61);
	MaterialFloat4 Local87 = CustomExpression1(Parameters,Material_Texture2D_5,sampler_Material_Texture2D_5,Local61,Local82,Local83,Local84,Local85,Local86,MaterialFloat4(0.00000000,0.00000000,0.00000000,1.00000000));
	MaterialFloat Local88 = (1.00000000 - Local87.b);
	MaterialFloat Local89 = (Local88 * Material.PreshaderBuffer[11].y);
	MaterialFloat3 Local90 = (MaterialFloat3(Local87.rg,Local89) - ((MaterialFloat3)0.00000000));
	MaterialFloat Local91 = length(Local90);
	MaterialFloat2 Local92 = abs(Local85);
	MaterialFloat2 Local93 = (Local92 - ((MaterialFloat2)0.00000000));
	MaterialFloat Local94 = length(Local93);
	FLWCVector3 Local95 = GetWorldPosition(Parameters);
	MaterialFloat3 Local96 = LWCDdx(DERIV_BASE_VALUE(Local95));
	MaterialFloat3 Local97 = (((MaterialFloat3)0.00000000) - DERIV_BASE_VALUE(Local96));
	MaterialFloat Local98 = length(DERIV_BASE_VALUE(Local97));
	MaterialFloat Local99 = (Local94 / DERIV_BASE_VALUE(Local98));
	MaterialFloat2 Local100 = abs(Local86);
	MaterialFloat2 Local101 = (Local100 - ((MaterialFloat2)0.00000000));
	MaterialFloat Local102 = length(Local101);
	MaterialFloat3 Local103 = LWCDdy(DERIV_BASE_VALUE(Local95));
	MaterialFloat3 Local104 = (((MaterialFloat3)0.00000000) - DERIV_BASE_VALUE(Local103));
	MaterialFloat Local105 = length(DERIV_BASE_VALUE(Local104));
	MaterialFloat Local106 = (Local102 / DERIV_BASE_VALUE(Local105));
	MaterialFloat Local107 = max(Local99,Local106);
	MaterialFloat3 Local108 = mul(MaterialFloat3(0.00000000,0.00000000,1.00000000), (MaterialFloat3x3)(ResolvedView.ViewToTranslatedWorld));
	MaterialFloat3 Local109 = Local108;
	MaterialFloat Local110 = dot(Local109,Parameters.CameraVector);
	MaterialFloat Local111 = abs(Local110);
	MaterialFloat Local112 = (Local107 / Local111);
	MaterialFloat Local113 = (Local91 / Local112);
	MaterialFloat4 Local114 = CustomExpression2(Parameters,Material_Texture2D_6,sampler_Material_Texture2D_6,Local61,Local82,Local83,Local84,Local85,Local86,MaterialFloat4(0.00000000,0.00000000,0.00000000,1.00000000));
	MaterialFloat Local115 = (1.00000000 - Local114.b);
	MaterialFloat Local116 = (Local115 * Material.PreshaderBuffer[11].y);
	MaterialFloat3 Local117 = (MaterialFloat3(Local114.rg,Local116) - ((MaterialFloat3)0.00000000));
	MaterialFloat Local118 = length(Local117);
	MaterialFloat Local119 = (Local118 / Local112);
	MaterialFloat Local120 = lerp(Local113,Local119,Local10);

	PixelMaterialInputs.EmissiveColor = Local19;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local42;
	PixelMaterialInputs.Metallic = Local49;
	PixelMaterialInputs.Specular = Local52;
	PixelMaterialInputs.Roughness = Local55;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local18;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = Local120;
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

	
	UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	Parameters.WorldPosition = UnrealWorldPos;
	Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
	Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
	Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up

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
	//Convert from unreal units to unity
	Offset /= float3( 100, 100, 100 );
	Offset = Offset.xzy;
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