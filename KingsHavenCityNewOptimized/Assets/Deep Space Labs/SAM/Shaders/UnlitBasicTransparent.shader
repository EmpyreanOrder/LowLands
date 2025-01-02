Shader "Deep Space Labs/Unlit/BasicTransparent"
{
	Properties
	{
		_Color("Main Color", Color) = (0.5,0.5,0.5,1)
	}
		SubShader
	{
		Tags {"Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 100

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			float4 _Color;

			struct appdata {
				float4 vertex : POSITION;
				fixed4 color : COLOR;
			};

			struct v2f {
				float4 position : SV_POSITION;
				float4 color : COLOR0;
			};

			v2f vert(appdata v) {
				v2f o;
				o.position = UnityObjectToClipPos(v.vertex);
				o.color = _Color;
				return o;
			}

			fixed4 frag(v2f i) : SV_TARGET{
				return i.color;
			}
			ENDCG
		}
	}
}
