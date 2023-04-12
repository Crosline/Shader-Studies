Shader "Studies/Shader12/Unlit" {
    
    Properties {
        _WaveAmp ("Wave Amplitude", Float) = 1
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

            half _WaveAmp;
            
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
                return cos((x + _Time.y * 0.05)* TAU * 5);
            }
            
            float getwaveradial(float2 uv)
            {
                float2 centeredUV = uv * 2 - 1;
                float wave = getwave(length(centeredUV));
                wave *= 1-length(centeredUV);
                return wave;
            }

            v2f vert (MeshData mesh) {
                v2f output;
                float waves = getwaveradial(mesh.uv);
                // mesh.vertex.y = waves_x * waves_y * _WaveAmp.x;
                mesh.vertex.y = (waves * _WaveAmp);
                output.vertex = UnityObjectToClipPos(mesh.vertex);
                
                output.uv = mesh.uv;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                float waves = getwaveradial(i.uv);
                return waves;
                return float4(i.uv, 0, 1);
            }
            ENDCG
        }
    }
}
