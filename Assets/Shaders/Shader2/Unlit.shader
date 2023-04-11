Shader "Shader2/Unlit" {
    
    Properties {
//        _MainTex ("Texture", 2D) = "white" {}
//        _Value ("Value", Float) = 0.0
        _Color ("Color", Color) = (.25, .5, .5, 1)
    }
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float4 _Color;

            struct MeshData { // per-vertex
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                // float4 tangent : TANGENT;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                // float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 vertex : SV_POSITION;
            };

            float3 toFloat3(float4 f4)
            {
                return f4.xyz;
            }

            v2f vert (MeshData v) {
                v2f output;
                output.normal = v.normal;
                output.vertex = UnityObjectToClipPos(toFloat3(v.vertex));
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                // sample the texture
                return float4(i.normal, 1);
            }
            ENDCG
        }
    }
}
