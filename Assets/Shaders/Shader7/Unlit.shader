Shader "Studies/Shader7/Unlit" {
    
    Properties {
        _ColorA ("First Color", Color) = (1,1,1,1)
        _ColorB ("Second Color", Color) = (0,0,0,1)
        
        _ColorStart ("Color Start", Range(0,1)) = 0
        _ColorEnd ("Color End", Range(0,1)) = 1
    }
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _ColorA;
            float4 _ColorB;
            
            half _ColorStart;
            half _ColorEnd;
            
            struct MeshData {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };
            
            float InverseLerp(float a, float b, float v) {
                return (v-a)/(b-a);
            }
            
            v2f vert (MeshData mesh) {
                v2f output;
                output.vertex = UnityObjectToClipPos(mesh.vertex);
                
                float4 color = InverseLerp(_ColorStart, _ColorEnd, mesh.uv0);
                color = saturate(color);
                color = lerp(_ColorA, _ColorB, color);

                output.color = color;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                
                return i.color;
            }
            ENDCG
        }
    }
}
