Shader "Studies/Shader8/Unlit" {
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
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
                float color = cos((i.uv.x + _Time * 0.5)* 25);
                
                return color;
            }
            ENDCG
        }
    }
}
