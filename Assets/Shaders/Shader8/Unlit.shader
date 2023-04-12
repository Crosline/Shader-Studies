Shader "Studies/Shader8/Unlit" {
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            #define TAU 6.283185307179586
            #define PI TAU/2
            
            struct MeshData {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };
            
            float InverseLerp(float a, float b, float v) {
                return (v-a)/(b-a);
            }
            
            v2f vert (MeshData mesh) {
                v2f output;
                output.vertex = UnityObjectToClipPos(mesh.vertex);

                output.uv = mesh.uv;
                return output;
            }

            float4 frag (v2f i) : SV_Target {

                // float t = abs(frac(i.uv.x * 5) * 2 -1);
                float xOffset = cos(i.uv.y * TAU * 8) * 0.01;
                float color = cos((i.uv.x + xOffset + _Time.y * 0.05)* TAU * 8);
                
                return color * -(i.uv.y);
            }
            ENDCG
        }
    }
}
