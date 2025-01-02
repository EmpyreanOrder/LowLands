//Instead of using the UV coords of the mesh to draw the words, performs a projection onto the mesh.
Shader "Deep Space Labs/Unlit/MeshTextDrawer"
{
    Properties
    {
        //[PerRendererData] _Color("Main Color", Color) = (0.5,0.5,0.5,1)
        _SymbolTex("Symbol Texture", 2D) = "" {}
        _SymbolOpacity("LOD Symbol Opacity", Range(0,1)) = .25
        [NoScaleOffset]_DigitsTex("Digits Texture", 2D) = "" {}
        _Word1Opacity("Word 1 Opacity", Range(0, 1)) = .75
        _Word2Opacity("Word 2 Opacity", Range(0, 1)) = .75
        _Word1TilingAndOffset("Word 1 Tiling and Offset", Vector) = (1, 1, -.07, .3)
        _Word2TilingAndOffset("Word 2 Tiling and Offset", Vector) = (1, 1, .02, -.31)
        _WordPadding("Word Padding", Vector) = (.302, .845, .09, .752)
    }

        SubShader
        {
            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag

                #include "UnityCG.cginc"

                static const int BLANK_SPACE_INDEX = 35;
                static const float DIGIT_UV_WIDTH_IN_LOOKUP_TEX = .15625;

                //strangely access to Matrix4x4 by index is by row first, then column
                //this means row 1, column 2 index is calculated as row + column * 4, rather 
                //than the usual row * 4 + column. So the first char of the word will be at row 0, column 0 as usual
                //but the second char is at row 1 column 0, instead of row 0 column 1.
                static const int2 indicesLookup[16] =
                {
                    int2(0,0),
                    int2(0,1),
                    int2(0,2),
                    int2(0,3),
                    int2(1,0),
                    int2(1,1),
                    int2(1,2),
                    int2(1,3),
                    int2(2,0),
                    int2(2,1),
                    int2(2,2),
                    int2(2,3),
                    int2(3,0),
                    int2(3,1),
                    int2(3,2),
                    int2(3,3)
                };

                //uvOffset will be 0.15625
                //6 rows. 6 columns - accomodates 35 unique chars (+ empty space)
                //row 0 is top row in new tex, the y values here will go from larger to smaller
                static const float2 digitOffsetLookup[36] =
                {
                    float2(0,.84375),
                    float2(.15625,.84375),
                    float2(.3125,.84375),
                    float2(.46875,.84375),
                    float2(.625,.84375),
                    float2(.78125,.84375),
                    float2(0,.6875),
                    float2(.15625,.6875),
                    float2(.3125,.6875),
                    float2(.46875,.6875),
                    float2(.625,.6875),
                    float2(.78125,.6875),
                    float2(0,.53125),
                    float2(.15625,.53125),
                    float2(.3125,.53125),
                    float2(.46875,.53125),
                    float2(.625,.53125),
                    float2(.78125,.53125),
                    float2(0,.375),
                    float2(.15625,.375),
                    float2(.3125,.375),
                    float2(.46875,.375),
                    float2(.625,.375),
                    float2(.78125,.375),
                    float2(0,.21875),
                    float2(.15625,.21875),
                    float2(.3125,.21875),
                    float2(.46875,.21875),
                    float2(.625,.21875),
                    float2(.78125,.21875),
                    float2(0,.0625),
                    float2(.15625,.0625),
                    float2(.3125,.0625),
                    float2(.46875,.0625),
                    float2(.625,.0625),
                    float2(.78125,.0625)
                };


                struct appdata
                {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                    float2 uv : TEXCOORD1;
                    fixed4 vertColor : COLOR;
                };

                struct v2f
                {
                    float4 pos : SV_POSITION;
                    fixed3 vertColor : COLOR;
                    float2 symbolUV : TEXCOORD0;
                    float4 wordUVsTransformed : TEXCOORD1;
                    float4 wordUVDimensions : TEXCOORD2;
                    float4 word1UVBoundaries : TEXCOORD3;
                    float4 word2UVBoundaries : TEXCOORD4;
                    float3 n : TEXCOORD5;
                };

                //variables set via inspector
                sampler2D _DigitsTex;
                sampler2D _SymbolTex;
                float4 _SymbolTex_ST;

                //variables set via coding, once per material.
                float _SymbolOpacity;
                float _Word1Opacity;
                float _Word2Opacity;
                float4 _Word1TilingAndOffset;
                float4 _Word2TilingAndOffset;
                float4 _WordPadding;

                //variables set via coding, per each separate instance using the material
                float4 _Color;
                float4x4 _Word1CharIndices;
                float4x4 _Word2aCharIndices;
                float4x4 _Word2bCharIndices;
                float3 _MeshWorldPosStart;
                float3 _MeshWorldDimensions;
                float _ColorEntireMesh;//if true (1), the entire mesh is colored, if false (0), only the symbol is displayed

                //float4x4 _num_indices;
                /*UNITY_INSTANCING_BUFFER_START(Props)
                    UNITY_DEFINE_INSTANCED_PROP(float4x4, _num_indices)
                    UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
                UNITY_INSTANCING_BUFFER_END(Props)*/

                float2 TransformWordUVs(float2 uvs, float4 wordTilingAndOffset)
                {
                    return float2(uvs.x * wordTilingAndOffset.x + wordTilingAndOffset.z, uvs.y * wordTilingAndOffset.y + wordTilingAndOffset.w);
                }

                v2f vert(appdata v)
                {
                    v2f vOutput;
                    vOutput.vertColor = v.vertColor.rgb;
                    vOutput.pos = UnityObjectToClipPos(v.vertex);
                    vOutput.symbolUV = TRANSFORM_TEX(v.uv, _SymbolTex);
                    vOutput.n = v.normal;

                    float3 worldPos = mul(unity_ObjectToWorld, v.vertex);

                    float xNormalAbs = abs(v.normal.x);
                    float yNormalAbs = abs(v.normal.y);
                    float zNormalAbs = abs(v.normal.z);
                    float2 vertUVs;
                    if (xNormalAbs > yNormalAbs)
                    {
                        if (xNormalAbs > zNormalAbs)
                        {
                            //x axis is dominant
                            if (v.normal.x > 0)
                            {
                                vertUVs.x = (worldPos.z - _MeshWorldPosStart.z) / _MeshWorldDimensions.z;
                            }
                            else
                            {
                                vertUVs.x = 1 - ((worldPos.z - _MeshWorldPosStart.z) / _MeshWorldDimensions.z);
                            }

                            vertUVs.y = (worldPos.y - floor(worldPos.y) - _MeshWorldPosStart.y) / _MeshWorldDimensions.y;
                        }
                        else
                        {
                            //z axis is dominant
                            if (v.normal.z > 0)
                            {
                                vertUVs.x = 1 - ((worldPos.x - _MeshWorldPosStart.x) / _MeshWorldDimensions.x);
                            }
                            else
                            {
                                vertUVs.x = (ceil(worldPos.x) - worldPos.x - _MeshWorldPosStart.x) / _MeshWorldDimensions.x;
                            }

                            vertUVs.y = (worldPos.y - _MeshWorldPosStart.y) / _MeshWorldDimensions.y;
                        }
                    }
                    else
                    {
                        if (yNormalAbs > zNormalAbs)
                        {
                            vertUVs.x = (worldPos.x - _MeshWorldPosStart.x) / _MeshWorldDimensions.x;

                            //y axis is dominant
                            if (v.normal.y > 0)
                            {
                                vertUVs.y = (worldPos.z - _MeshWorldPosStart.z) / _MeshWorldDimensions.z;
                            }
                            else
                            {
                                vertUVs.y = 1 - ((worldPos.z - _MeshWorldPosStart.z) / _MeshWorldDimensions.z);
                            }
                        }
                        else
                        {
                            //z axis is dominant
                            if (v.normal.z > 0)
                            {
                                vertUVs.x = 1 - ((worldPos.x - _MeshWorldPosStart.x) / _MeshWorldDimensions.x);
                            }
                            else
                            {
                                vertUVs.x = (worldPos.x - _MeshWorldPosStart.x) / _MeshWorldDimensions.x;
                            }

                            vertUVs.y = (worldPos.y - _MeshWorldPosStart.y) / _MeshWorldDimensions.y;
                        }
                    }

                    vOutput.wordUVDimensions = float4(
                        (1.0 - _WordPadding.x) / (int)_Word1CharIndices[3][3],
                        1.0 - _WordPadding.y,
                        (1.0 - _WordPadding.z) / (int)_Word2bCharIndices[3][3],
                        1.0 - _WordPadding.w);

                    vOutput.wordUVsTransformed = float4(TransformWordUVs(vertUVs, _Word1TilingAndOffset), TransformWordUVs(vertUVs, _Word2TilingAndOffset));

                    vOutput.word1UVBoundaries = float4
                        (
                            _WordPadding.x * .5,
                            1 - (_WordPadding.y * .5),
                            (_WordPadding.x * .5) + (vOutput.wordUVDimensions.x * (int)_Word1CharIndices[3][3]),
                            _WordPadding.y * .5
                        );

                    vOutput.word2UVBoundaries = float4
                        (
                            _WordPadding.z * .5,
                            1 - (_WordPadding.w * .5),
                            (_WordPadding.z * .5) + (vOutput.wordUVDimensions.z * (int)_Word2bCharIndices[3][3]),
                            _WordPadding.w * .5
                            );

                    return vOutput;
                }

                float2 calculateWord1LookupTextureUV(float2 normalizedDigitUV, v2f vOutput)
                {
                    float2 zeroAlignedUV = float2(normalizedDigitUV.x - vOutput.word1UVBoundaries.x, normalizedDigitUV.y - vOutput.word1UVBoundaries.w);

                    float sequenceIndex = floor(zeroAlignedUV.x / vOutput.wordUVDimensions.x);

                    int2 digitIndices = indicesLookup[sequenceIndex];

                    int digitLookupTextureIndex = _Word1CharIndices[digitIndices.y][digitIndices.x];

                    //figure out where this fragment is in relation to it's digit space
                    float2 fragTInDigitSpace = float2((zeroAlignedUV.x - (sequenceIndex * vOutput.wordUVDimensions.x)) / vOutput.wordUVDimensions.x, zeroAlignedUV.y / vOutput.wordUVDimensions.y);

                    float zeroRelativeTexUVX = lerp(0, DIGIT_UV_WIDTH_IN_LOOKUP_TEX, fragTInDigitSpace.x);
                    float zeroRelativeTexUVY = lerp(0, DIGIT_UV_WIDTH_IN_LOOKUP_TEX, fragTInDigitSpace.y);

                    float2 uvOffset = digitOffsetLookup[digitLookupTextureIndex];

                    return float2(zeroRelativeTexUVX + uvOffset.x, zeroRelativeTexUVY + uvOffset.y);
                }

                float2 calculateWord2LookupTextureUV(float2 normalizedDigitUV, v2f vOutput)
                {
                    float2 zeroAlignedUV = float2(normalizedDigitUV.x - vOutput.word2UVBoundaries.x, normalizedDigitUV.y - vOutput.word2UVBoundaries.w);

                    float sequenceIndex = floor(zeroAlignedUV.x / vOutput.wordUVDimensions.z);

                    int digitLookupTextureIndex;

                    if (sequenceIndex < 15.5)
                    {
                        int2 digitIndices = indicesLookup[sequenceIndex];

                        digitLookupTextureIndex = _Word2aCharIndices[digitIndices.y][digitIndices.x];
                    }
                    else
                    {
                        int2 digitIndices = indicesLookup[sequenceIndex - 16];

                        digitLookupTextureIndex = _Word2bCharIndices[digitIndices.y][digitIndices.x];
                    }

                    //figure out where this fragment is in relation to it's digit space
                    float2 fragTInDigitSpace = float2((zeroAlignedUV.x - (sequenceIndex * vOutput.wordUVDimensions.z)) / vOutput.wordUVDimensions.z, zeroAlignedUV.y / vOutput.wordUVDimensions.w);

                    float zeroRelativeTexUVX = lerp(0, DIGIT_UV_WIDTH_IN_LOOKUP_TEX, fragTInDigitSpace.x);
                    float zeroRelativeTexUVY = lerp(0, DIGIT_UV_WIDTH_IN_LOOKUP_TEX, fragTInDigitSpace.y);

                    float2 uvOffset = digitOffsetLookup[digitLookupTextureIndex];

                    return float2(zeroRelativeTexUVX + uvOffset.x, zeroRelativeTexUVY + uvOffset.y);
                }

                float median(float r, float g, float b) {
                    return max(min(r, g), min(max(r, g), b));
                }

                //unit range = pxRange (8) / px size of letter (160) = .05
                static const float2 unitRange = float2(.05, .05);
                static const float2 one = float2(1.0, 1.0);
                float screenPxRange(float2 wordCharLookupTextureUV)
                {
                    //return 160.0 / 320.0;
                    //vec2 unitRange = vec2(pxRange) / vec2(textureSize(msdf, 0));
                    float2 screenTexSize = one / fwidth(wordCharLookupTextureUV);
                    return max(0.5 * dot(unitRange, screenTexSize), 1.0);
                }

                fixed4 calculateFinalWordColor(float2 wordCharLookupTextureUV, float opacity, fixed3 vertColor) {
                    fixed3 msd = tex2D(_DigitsTex, wordCharLookupTextureUV).rgb;
                    float sd = median(msd.r, msd.g, msd.b);
                    float screenPxDistance = screenPxRange(wordCharLookupTextureUV) * (sd - .25);
                    float opacityFromTex = clamp(screenPxDistance, 0.0, 1.0);
                    return fixed4(lerp(vertColor, fixed3(0, 0, 0), opacity * opacityFromTex), 1);
                }

                fixed4 frag(v2f vOutput) : SV_Target
                {
                    float2 word1NormalizedDigitUV = float2(vOutput.wordUVsTransformed.x - floor(vOutput.wordUVsTransformed.x), vOutput.wordUVsTransformed.y - floor(vOutput.wordUVsTransformed.y));

                    fixed4 word1Color;
                    if (word1NormalizedDigitUV.x < vOutput.word1UVBoundaries.x
                        || word1NormalizedDigitUV.y > vOutput.word1UVBoundaries.y
                        || word1NormalizedDigitUV.x > vOutput.word1UVBoundaries.z
                        || word1NormalizedDigitUV.y < vOutput.word1UVBoundaries.w)
                    {
                        word1Color = fixed4(vOutput.vertColor, 1);
                    }
                    else
                    {
                        float2 word1TexUV = calculateWord1LookupTextureUV(word1NormalizedDigitUV, vOutput);
                        word1Color = calculateFinalWordColor(word1TexUV, _Word1Opacity, vOutput.vertColor);
                    }

                    float2 word2NormalizedDigitUV = float2(vOutput.wordUVsTransformed.z - floor(vOutput.wordUVsTransformed.z), vOutput.wordUVsTransformed.w - floor(vOutput.wordUVsTransformed.w));

                    fixed4 word2Color;
                    if (word2NormalizedDigitUV.x < vOutput.word2UVBoundaries.x
                        || word2NormalizedDigitUV.y > vOutput.word2UVBoundaries.y
                        || word2NormalizedDigitUV.x > vOutput.word2UVBoundaries.z
                        || word2NormalizedDigitUV.y < vOutput.word2UVBoundaries.w)
                    {
                        word2Color = fixed4(vOutput.vertColor, 1);
                    }
                    else
                    {
                        float2 word2TexUV = calculateWord2LookupTextureUV(word2NormalizedDigitUV, vOutput);
                        word2Color = calculateFinalWordColor(word2TexUV, _Word2Opacity, vOutput.vertColor);
                    }

                    fixed4 combinedWordColor = word1Color * word2Color;

                    if (_ColorEntireMesh)
                        return combinedWordColor * _Color;
                    else
                        return lerp(combinedWordColor, _Color, tex2D(_SymbolTex, vOutput.symbolUV).r * _SymbolOpacity);
                }


                ENDCG
            }
        }
}
