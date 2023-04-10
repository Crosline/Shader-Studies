Shader "Shader1/Unlit" {
    
    Properties {
//        _MainTex ("Texture", 2D) = "white" {}
        _Value ("Value", float) = 0.0
    }
    
    SubShader {
        Tags { "RenderType"="Opaque" }

        Pass {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"
            
            float _Value;

            struct MeshData {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float4 color : COLOR;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
            };

            struct v2f {
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float4 vertex : SV_POSITION;
            };


            v2f vert (MeshData v) {
                v2f o;
                o.normal = v.normal + _Value;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target {
                // sample the texture
                return i.vertex;
            }
            ENDCG
        }
    }
}
