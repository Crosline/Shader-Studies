Shader "Studies/Shader11/Unlit" {
    
    Properties {
        [ShowAsVector2] _WaveAmp ("Wave Amplitude", Vector) = (1, 1, 0, 0)
    }
    
    SubShader {
        Tags {
                "RenderType" = "Opaque" 
                "Queue" = "Geometry"
            }

        Pass {
            Cull OFF
            ZWrite ON
            ZTest LEqual
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            #define TAU 6.283185307179586
            #define PI TAU/2

            half2 _WaveAmp;
            
            struct MeshData {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            float getwave(float x)
            {
                return cos((x + _Time.y * 0.05)* TAU * 8);
            }

            v2f vert (MeshData mesh) {
                v2f output;
                float waves_x = getwave(mesh.uv.x);
                float waves_y = getwave(mesh.uv.y);
                // mesh.vertex.y = waves_x * waves_y * _WaveAmp.x;
                mesh.vertex.y = (waves_x * _WaveAmp.x) + (waves_y * _WaveAmp.y);
                output.vertex = UnityObjectToClipPos(mesh.vertex);
                
                output.uv = mesh.uv;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                float waves = getwave(i.uv.x) * 0.5 + 0.5;
                return waves;
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
