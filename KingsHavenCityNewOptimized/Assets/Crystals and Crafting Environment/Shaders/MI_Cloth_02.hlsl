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
	float4 PreshaderBuffer[12];
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
	Material.PreshaderBuffer[1] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.162029,0.162029,0.162029,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,0.162029,0.162029,0.162029);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,0.162029,0.162029,0.162029);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.125000,0.103810,0.091146,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,0.125000,0.103810,0.091146);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.125000,0.103810,0.091146);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,0.000000,0.500000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.180000,0.500000,4.000000,0.050000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000500,1.000000,-0.050000,0.400000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.200000,0.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat3 CustomExpression1(FMaterialVertexParameters Parameters)
{
return GetPrimitiveData(Parameters).LocalObjectBoundsMax.xyz;
}

MaterialFloat3 CustomExpression0(FMaterialVertexParameters Parameters)
{
return GetPrimitiveData(Parameters).LocalObjectBoundsMin.xyz;
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	FLWCVector3 Local10 = GetWorldPosition(Parameters);
	MaterialFloat3 Local11 = LWCMultiply(DERIV_BASE_VALUE(Local10), GetWorldToInstance(Parameters));
	MaterialFloat3 Local12 = CustomExpression0(Parameters);
	MaterialFloat3 Local13 = (DERIV_BASE_VALUE(Local11) - Local12);
	MaterialFloat3 Local14 = CustomExpression1(Parameters);
	MaterialFloat3 Local15 = (Local14 - Local12);
	MaterialFloat3 Local16 = (Local13 / Local15);
	MaterialFloat Local17 = (Local16.r * 3.14159274);
	MaterialFloat Local18 = sin(Local17);
	MaterialFloat Local19 = (Local18 * Material.PreshaderBuffer[8].y);
	FLWCVector3 Local20 = TransformLocalPositionToWorld(Parameters, MaterialFloat3(0.00000000,0.00000000,0.00000000));
	FLWCScalar Local21 = LWCAdd(LWCGetX(MakeLWCVector(LWCGetComponent(Local20, 0),LWCGetComponent(Local20, 1))), LWCGetY(MakeLWCVector(LWCGetComponent(Local20, 0),LWCGetComponent(Local20, 1))));
	FLWCScalar Local22 = LWCAdd(Local21, LWCPromote(View.GameTime));
	MaterialFloat4 Local23 = Parameters.VertexColor;
	MaterialFloat Local24 = DERIV_BASE_VALUE(Local23).a;
	MaterialFloat Local25 = (DERIV_BASE_VALUE(Local24) * Material.PreshaderBuffer[8].z);
	FLWCScalar Local26 = LWCSubtract(Local22, LWCPromote(DERIV_BASE_VALUE(Local25)));
	MaterialFloat Local27 = (Local18 * Material.PreshaderBuffer[8].w);
	FLWCScalar Local28 = LWCSubtract(DERIV_BASE_VALUE(Local26), LWCPromote(Local27));
	FLWCScalar Local29 = LWCMultiply(Local28, LWCPromote(Material.PreshaderBuffer[9].x));
	FLWCScalar Local30 = LWCMultiply(Local29, LWCPromote(6.28318548));
	MaterialFloat Local31 = LWCSin(Local30);
	MaterialFloat3 Local32 = LWCNormalize(DERIV_BASE_VALUE(Local10));
	MaterialFloat3 Local33 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(0.00000000,1.00000000,0.00000000).rgb);
	MaterialFloat Local34 = dot(DERIV_BASE_VALUE(Local32),Local33);
	MaterialFloat Local35 = (DERIV_BASE_VALUE(Local34) * Material.PreshaderBuffer[9].y);
	MaterialFloat Local36 = (Local31 - DERIV_BASE_VALUE(Local35));
	MaterialFloat Local37 = abs(DERIV_BASE_VALUE(Local34));
	MaterialFloat Local38 = (1.00000000 - DERIV_BASE_VALUE(Local37));
	MaterialFloat Local39 = (DERIV_BASE_VALUE(Local38) * Material.PreshaderBuffer[9].z);
	MaterialFloat Local40 = (1.00000000 - DERIV_BASE_VALUE(Local39));
	MaterialFloat Local41 = (Local36 * DERIV_BASE_VALUE(Local40));
	MaterialFloat Local42 = (Local41 * Material.PreshaderBuffer[10].x);
	MaterialFloat Local43 = (Local42 * 6.28318548);
	MaterialFloat3 Local44 = TransformLocalVectorToWorld(Parameters, MaterialFloat3(1.00000000,0.00000000,0.00000000).rgb);
	FLWCVector3 Local45 = LWCAdd(LWCPromote(MaterialFloat3(MaterialFloat2(0.00000000,0.00000000),Local19)), DERIV_BASE_VALUE(Local10));
	MaterialFloat3 Local46 = RotateAboutAxis(MaterialFloat4(Local44,Local43),Local20,Local45);
	MaterialFloat3 Local47 = (MaterialFloat3(MaterialFloat2(0.00000000,0.00000000),Local19) + Local46);
	MaterialFloat Local48 = (View.GameTime * Material.PreshaderBuffer[10].y);
	MaterialFloat Local49 = (Local48 * -0.50000000);
	MaterialFloat3 Local50 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb) * ((MaterialFloat3)Local49));
	FLWCVector3 Local51 = LWCDivide(DERIV_BASE_VALUE(Local10), ((MaterialFloat3)1024.00000000));
	FLWCVector3 Local52 = LWCAdd(LWCPromote(Local50), DERIV_BASE_VALUE(Local51));
	FLWCVector3 Local53 = LWCAdd(DERIV_BASE_VALUE(Local52), LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local54 = LWCFrac(DERIV_BASE_VALUE(Local53));
	MaterialFloat3 Local55 = (DERIV_BASE_VALUE(Local54) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local56 = (DERIV_BASE_VALUE(Local55) + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local57 = abs(DERIV_BASE_VALUE(Local56));
	MaterialFloat3 Local58 = (DERIV_BASE_VALUE(Local57) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local59 = (((MaterialFloat3)3.00000000) - DERIV_BASE_VALUE(Local58));
	MaterialFloat3 Local60 = (DERIV_BASE_VALUE(Local59) * DERIV_BASE_VALUE(Local57));
	MaterialFloat3 Local61 = (DERIV_BASE_VALUE(Local60) * DERIV_BASE_VALUE(Local57));
	MaterialFloat Local62 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),DERIV_BASE_VALUE(Local61));
	FLWCVector3 Local63 = LWCDivide(DERIV_BASE_VALUE(Local10), ((MaterialFloat3)200.00000000));
	FLWCVector3 Local64 = LWCAdd(LWCPromote(((MaterialFloat3)Local49)), DERIV_BASE_VALUE(Local63));
	FLWCVector3 Local65 = LWCAdd(DERIV_BASE_VALUE(Local64), LWCPromote(((MaterialFloat3)0.50000000)));
	MaterialFloat3 Local66 = LWCFrac(DERIV_BASE_VALUE(Local65));
	MaterialFloat3 Local67 = (DERIV_BASE_VALUE(Local66) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local68 = (DERIV_BASE_VALUE(Local67) + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local69 = abs(DERIV_BASE_VALUE(Local68));
	MaterialFloat3 Local70 = (DERIV_BASE_VALUE(Local69) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local71 = (((MaterialFloat3)3.00000000) - DERIV_BASE_VALUE(Local70));
	MaterialFloat3 Local72 = (DERIV_BASE_VALUE(Local71) * DERIV_BASE_VALUE(Local69));
	MaterialFloat3 Local73 = (DERIV_BASE_VALUE(Local72) * DERIV_BASE_VALUE(Local69));
	MaterialFloat3 Local74 = (DERIV_BASE_VALUE(Local73) - ((MaterialFloat3)0.00000000));
	MaterialFloat Local75 = length(DERIV_BASE_VALUE(Local74));
	MaterialFloat Local76 = (DERIV_BASE_VALUE(Local62) + DERIV_BASE_VALUE(Local75));
	MaterialFloat Local77 = (DERIV_BASE_VALUE(Local76) * 6.28318548);
	MaterialFloat4 Local78 = MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000)),DERIV_BASE_VALUE(Local77));
	MaterialFloat3 Local79 = (Local47 + MaterialFloat3(0.00000000,0.00000000,-10.00000000));
	MaterialFloat3 Local80 = RotateAboutAxis(DERIV_BASE_VALUE(Local78),Local79,Local47);
	MaterialFloat Local81 = (DERIV_BASE_VALUE(Local24) * Material.PreshaderBuffer[10].z);
	MaterialFloat3 Local82 = (Local80 * ((MaterialFloat3)DERIV_BASE_VALUE(Local81)));
	MaterialFloat3 Local83 = (Local82 * ((MaterialFloat3)Material.PreshaderBuffer[10].w));
	MaterialFloat3 Local84 = (Local83 + Local47);
	MaterialFloat Local85 = (DERIV_BASE_VALUE(Local24) - 0.20000000);
	MaterialFloat Local86 = saturate(DERIV_BASE_VALUE(Local85));
	MaterialFloat Local87 = (Material.PreshaderBuffer[11].x * DERIV_BASE_VALUE(Local86));
	MaterialFloat3 Local88 = (Local84 * ((MaterialFloat3)DERIV_BASE_VALUE(Local87)));
	MaterialFloat3 Local89 = (Local47 + Local88);
	return Local89;;
}
void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb;


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
	MaterialFloat3 Local0 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[1].yzw,Material.PreshaderBuffer[1].x);
	MaterialFloat2 Local1 = Parameters.TexCoords[0].xy;
	MaterialFloat Local2 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 0);
	MaterialFloat4 Local3 = Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local1),View.MaterialTextureMipBias);
	MaterialFloat Local4 = MaterialStoreTexSample(Parameters, Local3, 0);
	MaterialFloat Local5 = (Local3.g * Material.PreshaderBuffer[4].x);
	MaterialFloat3 Local6 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000).rgb,Material.PreshaderBuffer[4].yzw,Local5);
	MaterialFloat Local7 = (Local3.b * Material.PreshaderBuffer[7].x);
	MaterialFloat3 Local8 = lerp(Local6,Material.PreshaderBuffer[7].yzw,Local7);
	MaterialFloat Local9 = (Local3.r * Material.PreshaderBuffer[8].x);

	PixelMaterialInputs.EmissiveColor = Local0;
	PixelMaterialInputs.Opacity = 0.00000000;
	PixelMaterialInputs.OpacityMask = Local9;
	PixelMaterialInputs.BaseColor = Local8;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = 0.50000000.r;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(MaterialFloat3(0.00000000,0.00000000,0.00000000).rgb,Material.PreshaderBuffer[11].y);
	PixelMaterialInputs.AmbientOcclusion = 1.00000000.r;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 2;
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