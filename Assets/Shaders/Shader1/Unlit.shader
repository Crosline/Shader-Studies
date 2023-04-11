Shader "Studies/Shader1/Unlit" {
    
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
            
            float _Value;
            float4 _Color;

            struct MeshData { // per-vertex
                float4 vertex : POSITION;
                // float3 normal : NORMAL;
                // float4 tangent : TANGENT;
                float2 uv0 : TEXCOORD0;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                // float3 normal : NORMAL;
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            float3 toFloat3(float4 f4)
            {
                return f4.xyz;
            }

            v2f vert (MeshData mesh) {
                v2f output;
                // o.normal = v.normal + _Value;
                output.vertex = UnityObjectToClipPos(toFloat3(mesh.vertex));
                output.color = _Color;
                output.uv = mesh.uv0;
                return output;
            }

            fixed4 frag (v2f i) : SV_Target {
                // sample the texture
                return i.color;
            }
            ENDCG
        }
    }
}
