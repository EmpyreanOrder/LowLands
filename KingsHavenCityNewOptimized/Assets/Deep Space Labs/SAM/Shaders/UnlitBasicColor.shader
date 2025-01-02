// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Deep Space Labs/Unlit/BasicColor"
{
    Properties
    {
        _Color("Main Color", Color) = (0.5,0.5,0.5,1)
    }
        SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
            };

            float4 _Color;

            v2f vert(appdata v)
            {
                v2f vOutput;
                vOutput.pos = UnityObjectToClipPos(v.vertex);

                return vOutput;
            }

            fixed4 frag(v2f vOutput) : SV_Target
            {
                return _Color;
            }


            ENDCG
        }
    }
}
