﻿Shader "Unity Shaders Book/Chapter 10/Mirror" {
	Properties {
		_MainTex ("Main Tex", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" "Queue"="Geometry"}
		
		Pass {
			HLSLPROGRAM
			
			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			
			sampler2D _MainTex;
			
			struct a2v {
				float3 vertex : POSITION;
				float3 texcoord : TEXCOORD0;
			};
			
			struct v2f {
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			
			v2f vert(a2v v) {
				v2f o;
				o.pos = TransformObjectToHClip(v.vertex);
				
				o.uv = v.texcoord;
				// Mirror needs to filp x
				o.uv.x = 1 - o.uv.x;
				
				return o;
			}
			
			half4 frag(v2f i) : SV_Target {
				return tex2D(_MainTex, i.uv);
			}
			
			ENDHLSL
		}
	} 
 	FallBack Off
}
