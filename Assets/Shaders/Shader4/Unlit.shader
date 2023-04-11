Shader "Studies/Shader4/Unlit" {
    
    Properties {
    }
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _Color;

            struct MeshData {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float3 toFloat3(float4 f4)
            {
                return f4.xyz;
            }

            v2f vert (MeshData v) {
                v2f output;
                output.vertex = UnityObjectToClipPos(toFloat3(v.vertex));
                output.uv = v.uv0;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
