Shader "Studies/Shader10/Unlit" {
    
    Properties {
        _ColorA ("First Color", Color) = (1,1,1,1)
        _ColorB ("Second Color", Color) = (0,0,0,1)
    }
    
    SubShader {
        Tags {
                "RenderType" = "Transparent" 
                "Queue" = "Transparent"
            }

        Pass {
            Cull OFF
            ZWrite OFF
            ZTest LEqual
            Blend ONE ONE
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            #define TAU 6.283185307179586
            #define PI TAU/2
            
            float4 _ColorA;
            float4 _ColorB;
            
            struct MeshData {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            
            float InverseLerp(float a, float b, float v) {
                return (v-a)/(b-a);
            }
            
            v2f vert (MeshData mesh) {
                v2f output;
                output.vertex = UnityObjectToClipPos(mesh.vertex);

                output.normal = mesh.normal;
                output.uv = mesh.uv;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {

                // float t = abs(frac(i.uv.x * 5) * 2 -1);
                float xOffset = cos(i.uv.y * TAU * 8) * 0.01;
                float color = cos((i.uv.x + xOffset + _Time.y * 0.05)* TAU * 8) * 0.5 + 0.5;
                color *= 1-i.uv.y;
                float removeTopAndBottom = abs(i.normal.y) < 0.99;
                float waves = color * removeTopAndBottom;
                
                float4 gradient = lerp(_ColorA, _ColorB, color);
                
                
                
                return gradient * waves;
            }
            ENDCG
        }
    }
}
