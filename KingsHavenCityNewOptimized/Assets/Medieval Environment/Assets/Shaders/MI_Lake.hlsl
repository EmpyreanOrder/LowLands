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
	Material.PreshaderBuffer[1] = float4(0.700000,1825.766724,0.000548,0.270182);//(Unknown)
	Material.PreshaderBuffer[2] = float4(2327.657715,0.000430,0.103061,16668.367188);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.022244,0.026042,0.018446,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.057292,0.047110,0.021400,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(477.786591,477.786591,0.002093,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.057292,0.047110,0.021400,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(0.022244,0.026042,0.018446,0.050000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(2063.783447,0.000485,0.666667,192.913879);//(Unknown)
	Material.PreshaderBuffer[10] = float4(192.913879,0.005184,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.137966,-0.171428,64.064346,64.064346);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.015609,2.000000,0.000000,0.000000);//(Unknown)
}
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat Local0 = (Material.PreshaderBuffer[1].x * View.GameTime);
	MaterialFloat Local1 = (Local0 * 0.10000000);
	FLWCVector3 Local2 = GetWorldPosition(Parameters);
	FLWCVector2 Local3 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local2)), LWCGetY(DERIV_BASE_VALUE(Local2)));
	FLWCVector2 Local4 = LWCMultiply(DERIV_BASE_VALUE(Local3), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[1].z)));
	MaterialFloat2 Local5 = Parameters.TexCoords[0].xy;
	FLWCVector2 Local6 = LWCAdd(DERIV_BASE_VALUE(Local4), LWCPromote(DERIV_BASE_VALUE(Local5)));
	FLWCVector2 Local7 = LWCAdd(LWCPromote(MaterialFloat2(Local1,Local1)), DERIV_BASE_VALUE(Local6));
	MaterialFloat2 Local8 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local7), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local9 = MaterialStoreTexCoordScale(Parameters, Local8, 0);
	MaterialFloat4 Local10 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local8,View.MaterialTextureMipBias));
	MaterialFloat Local11 = MaterialStoreTexSample(Parameters, Local10, 0);
	MaterialFloat2 Local12 = (((MaterialFloat2)-0.50000000) + Local10.rgb.rg);
	MaterialFloat2 Local13 = (Local12 * ((MaterialFloat2)0.50000000));
	MaterialFloat Local14 = dot(Local13,Local13);
	MaterialFloat Local15 = (1.00000000 - Local14);
	MaterialFloat Local16 = saturate(Local15);
	MaterialFloat Local17 = sqrt(Local16);
	MaterialFloat Local18 = (Local0 * -0.10000000);
	FLWCVector2 Local19 = LWCAdd(LWCPromote(MaterialFloat2(Local18,Local18)), DERIV_BASE_VALUE(Local6));
	MaterialFloat2 Local20 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local19), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local21 = MaterialStoreTexCoordScale(Parameters, Local20, 0);
	MaterialFloat4 Local22 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local20,View.MaterialTextureMipBias));
	MaterialFloat Local23 = MaterialStoreTexSample(Parameters, Local22, 0);
	MaterialFloat2 Local24 = (((MaterialFloat2)-0.50000000) + Local22.rgb.rg);
	MaterialFloat2 Local25 = (Local24 * ((MaterialFloat2)0.50000000));
	MaterialFloat Local26 = dot(Local25,Local25);
	MaterialFloat Local27 = (1.00000000 - Local26);
	MaterialFloat Local28 = saturate(Local27);
	MaterialFloat Local29 = sqrt(Local28);
	MaterialFloat3 Local30 = (MaterialFloat3(Local13,Local17) + MaterialFloat3(Local25,Local29));
	FLWCVector2 Local31 = LWCAdd(LWCPromote(MaterialFloat2(Local18,Local1)), DERIV_BASE_VALUE(Local6));
	MaterialFloat2 Local32 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local31), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local33 = MaterialStoreTexCoordScale(Parameters, Local32, 0);
	MaterialFloat4 Local34 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local32,View.MaterialTextureMipBias));
	MaterialFloat Local35 = MaterialStoreTexSample(Parameters, Local34, 0);
	MaterialFloat2 Local36 = (((MaterialFloat2)-0.50000000) + Local34.rgb.rg);
	MaterialFloat2 Local37 = (Local36 * ((MaterialFloat2)0.50000000));
	MaterialFloat Local38 = dot(Local37,Local37);
	MaterialFloat Local39 = (1.00000000 - Local38);
	MaterialFloat Local40 = saturate(Local39);
	MaterialFloat Local41 = sqrt(Local40);
	FLWCVector2 Local42 = LWCAdd(LWCPromote(MaterialFloat2(Local1,Local18)), DERIV_BASE_VALUE(Local6));
	MaterialFloat2 Local43 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local42), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local44 = MaterialStoreTexCoordScale(Parameters, Local43, 0);
	MaterialFloat4 Local45 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local43,View.MaterialTextureMipBias));
	MaterialFloat Local46 = MaterialStoreTexSample(Parameters, Local45, 0);
	MaterialFloat2 Local47 = (((MaterialFloat2)-0.50000000) + Local45.rgb.rg);
	MaterialFloat2 Local48 = (Local47 * ((MaterialFloat2)0.50000000));
	MaterialFloat Local49 = dot(Local48,Local48);
	MaterialFloat Local50 = (1.00000000 - Local49);
	MaterialFloat Local51 = saturate(Local50);
	MaterialFloat Local52 = sqrt(Local51);
	MaterialFloat3 Local53 = (MaterialFloat3(Local37,Local41) + MaterialFloat3(Local48,Local52));
	MaterialFloat3 Local54 = (Local30 + Local53);
	MaterialFloat2 Local55 = (Local54.rg * ((MaterialFloat2)Material.PreshaderBuffer[1].w));
	FLWCVector2 Local56 = LWCMultiply(DERIV_BASE_VALUE(Local3), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[2].y)));
	FLWCVector2 Local57 = LWCAdd(DERIV_BASE_VALUE(Local56), LWCPromote(DERIV_BASE_VALUE(Local5)));
	MaterialFloat2 Local58 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local57), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local59 = MaterialStoreTexCoordScale(Parameters, Local58, 0);
	MaterialFloat4 Local60 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local58,View.MaterialTextureMipBias));
	MaterialFloat Local61 = MaterialStoreTexSample(Parameters, Local60, 0);
	MaterialFloat2 Local62 = (((MaterialFloat2)-0.50000000) + Local60.rgb.rg);
	MaterialFloat2 Local63 = (Local62 * ((MaterialFloat2)0.50000000));
	MaterialFloat Local64 = dot(Local63,Local63);
	MaterialFloat Local65 = (1.00000000 - Local64);
	MaterialFloat Local66 = saturate(Local65);
	MaterialFloat Local67 = sqrt(Local66);
	MaterialFloat2 Local68 = (MaterialFloat3(Local63,Local67).rg * ((MaterialFloat2)Material.PreshaderBuffer[2].z));
	MaterialFloat Local69 = GetPixelDepth(Parameters);
	MaterialFloat Local70 = DERIV_BASE_VALUE(Local69).r;
	MaterialFloat Local71 = (DERIV_BASE_VALUE(Local70) - Material.PreshaderBuffer[2].w);
	MaterialFloat Local72 = (DERIV_BASE_VALUE(Local71) / 1.00000000);
	MaterialFloat Local73 = saturate(DERIV_BASE_VALUE(Local72));
	MaterialFloat3 Local74 = lerp(MaterialFloat3(Local55,Local54.b),MaterialFloat3(Local68,MaterialFloat3(Local63,Local67).b),DERIV_BASE_VALUE(Local73));

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local74;


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
	MaterialFloat3 Local75 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[3].yzw,Material.PreshaderBuffer[3].x);
	MaterialFloat Local76 = CalcSceneDepth(ScreenAlignedPosition(GetScreenPosition(Parameters)));
	MaterialFloat Local77 = (Local76 - DERIV_BASE_VALUE(Local69));
	MaterialFloat Local78 = (Local77 * Material.PreshaderBuffer[6].z);
	MaterialFloat Local79 = saturate(Local78);
	MaterialFloat Local80 = (1.00000000 * Local79);
	MaterialFloat Local81 = saturate(Local80);
	MaterialFloat Local82 = (1.00000000 - Local81);
	MaterialFloat3 Local83 = lerp(Material.PreshaderBuffer[8].xyz,Material.PreshaderBuffer[7].xyz,Local82);
	MaterialFloat Local84 = (Material.PreshaderBuffer[8].w * View.GameTime);
	MaterialFloat Local85 = (Local84 * 0.10000000);
	FLWCVector2 Local86 = LWCMultiply(DERIV_BASE_VALUE(Local3), LWCPromote(((MaterialFloat2)Material.PreshaderBuffer[9].y)));
	FLWCVector2 Local87 = LWCAdd(DERIV_BASE_VALUE(Local86), LWCPromote(DERIV_BASE_VALUE(Local5)));
	FLWCVector2 Local88 = LWCAdd(DERIV_BASE_VALUE(Local87), LWCPromote(MaterialFloat2(0.30000001,0.10000000)));
	FLWCVector2 Local89 = LWCAdd(LWCPromote(MaterialFloat2(Local85,Local85)), DERIV_BASE_VALUE(Local88));
	MaterialFloat2 Local90 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local89), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local91 = MaterialStoreTexCoordScale(Parameters, Local90, 0);
	MaterialFloat4 Local92 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local90,View.MaterialTextureMipBias));
	MaterialFloat Local93 = MaterialStoreTexSample(Parameters, Local92, 0);
	MaterialFloat Local94 = (Local84 * -0.10000000);
	FLWCVector2 Local95 = LWCAdd(DERIV_BASE_VALUE(Local87), LWCPromote(MaterialFloat2(0.80000001,0.20000000)));
	FLWCVector2 Local96 = LWCAdd(LWCPromote(MaterialFloat2(Local94,Local94)), DERIV_BASE_VALUE(Local95));
	MaterialFloat2 Local97 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local96), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local98 = MaterialStoreTexCoordScale(Parameters, Local97, 0);
	MaterialFloat4 Local99 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local97,View.MaterialTextureMipBias));
	MaterialFloat Local100 = MaterialStoreTexSample(Parameters, Local99, 0);
	MaterialFloat Local101 = (Local92.a + Local99.a);
	FLWCVector2 Local102 = LWCAdd(DERIV_BASE_VALUE(Local87), LWCPromote(MaterialFloat2(-0.30000001,-0.69999999)));
	FLWCVector2 Local103 = LWCAdd(LWCPromote(MaterialFloat2(Local94,Local85)), DERIV_BASE_VALUE(Local102));
	MaterialFloat2 Local104 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local103), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local105 = MaterialStoreTexCoordScale(Parameters, Local104, 0);
	MaterialFloat4 Local106 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local104,View.MaterialTextureMipBias));
	MaterialFloat Local107 = MaterialStoreTexSample(Parameters, Local106, 0);
	FLWCVector2 Local108 = LWCAdd(DERIV_BASE_VALUE(Local87), LWCPromote(MaterialFloat2(-0.05000000,-0.30000001)));
	FLWCVector2 Local109 = LWCAdd(LWCPromote(MaterialFloat2(Local85,Local94)), DERIV_BASE_VALUE(Local108));
	MaterialFloat2 Local110 = LWCApplyAddressMode(DERIV_BASE_VALUE(Local109), LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local111 = MaterialStoreTexCoordScale(Parameters, Local110, 0);
	MaterialFloat4 Local112 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,Local110,View.MaterialTextureMipBias));
	MaterialFloat Local113 = MaterialStoreTexSample(Parameters, Local112, 0);
	MaterialFloat Local114 = (Local106.a + Local112.a);
	MaterialFloat Local115 = (Local101 + Local114);
	MaterialFloat Local116 = (Local115 * Material.PreshaderBuffer[9].z);
	MaterialFloat Local117 = PositiveClampedPow(Local116,1.50000000);
	MaterialFloat Local118 = (Local117 * 2.00000000);
	MaterialFloat3 Local119 = (Local83 + ((MaterialFloat3)0.02000000));
	MaterialFloat3 Local120 = (((MaterialFloat3)Local118) * Local119);
	MaterialFloat Local121 = (Local77 * Material.PreshaderBuffer[10].y);
	MaterialFloat Local122 = saturate(Local121);
	MaterialFloat Local123 = (1.00000000 * Local122);
	MaterialFloat Local124 = saturate(Local123);
	MaterialFloat Local125 = (1.00000000 - Local124);
	MaterialFloat3 Local126 = lerp(Local83,Local120,Local125);
	MaterialFloat3 Local127 = lerp(Local126,Local83,DERIV_BASE_VALUE(Local73));
	MaterialFloat3 Local128 = (Local127 * ((MaterialFloat3)Material.PreshaderBuffer[10].z));
	MaterialFloat Local129 = (Local77 * Material.PreshaderBuffer[12].x);
	MaterialFloat Local130 = saturate(Local129);
	MaterialFloat Local131 = (Material.PreshaderBuffer[12].y * Local130);

	PixelMaterialInputs.EmissiveColor = Local75;
	PixelMaterialInputs.Opacity = Local131;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local128;
	PixelMaterialInputs.Metallic = Material.PreshaderBuffer[10].w;
	PixelMaterialInputs.Specular = Material.PreshaderBuffer[11].x;
	PixelMaterialInputs.Roughness = Material.PreshaderBuffer[11].y;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local74;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat3(MaterialFloat3(1.00000000,0.00000000,0.00000000).xy,Material.PreshaderBuffer[12].z);
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