Shader "Pixelate" {
	Properties{
		_CellSize("Cell Size", Vector) = (0.02, 0.02, 0, 0)
	}
		SubShader{
			Tags{ "RenderType" = "Opaque" "Queue" = "Transparent" }
			LOD 200

			GrabPass{ "_PixelationGrabTexture" }

			Pass{
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#include "UnityCG.cginc"

				struct v2f {
					float4 pos : SV_POSITION;
					float4 grabUV : TEXCOORD0;
				};

		
				float4 _CellSize;

				v2f vert(appdata_base v) {
					v2f o;
					o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
					o.grabUV = ComputeGrabScreenPos(o.pos);
					return o;
				}

				sampler2D _PixelationGrabTexture;

				float4 frag(v2f IN) : COLOR{
					float increase = 0.2f;

					float2 steppedUV = IN.grabUV.xy / IN.grabUV.w;
					steppedUV /= _CellSize.xy / _ScreenParams.xy;
					steppedUV = round(steppedUV);
					steppedUV *= _CellSize.xy / _ScreenParams.xy;
					half4 c = tex2D(_PixelationGrabTexture, steppedUV);
					//c.r *= (c.r + increase);
					//c.g *= (c.g + increase);
					//c.b *= (c.b + increase);
					c.rgb *= 0.5;
					

					return c;
				}

				ENDCG
			}

		}

}