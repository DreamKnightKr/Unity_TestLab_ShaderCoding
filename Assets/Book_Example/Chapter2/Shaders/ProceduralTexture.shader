Shader "CookBook/ProceduralTexture" 
{
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Get Value from "Properies" block
		fixed4 _MainTint;
		sampler2D _MainTex;
		
		struct Input {
			float2 uv_MainTex;
		};

		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// 텍스처와 색조를 적용한다.
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}