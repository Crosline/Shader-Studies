Shader "Studies/Shader6/Unlit" {
    
    Properties {
        _ColorA ("First Color", Color) = (1,1,1,1)
        _ColorB ("Second Color", Color) = (0,0,0,1)
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
            
            struct MeshData {
                float4 vertex : POSITION;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (MeshData mesh) {
                v2f output;
                output.vertex = UnityObjectToClipPos(mesh.vertex);
                output.uv = mesh.uv0;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
