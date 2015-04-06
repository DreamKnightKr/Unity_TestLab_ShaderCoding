Shader "CookBook/Scrolling" 
{
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_ScrollXSpeed ("X Scroll Speed", Range(0, 10)) = 2
		_ScrollYSpeed ("Y Scroll Speed", Range(0, 10)) = 2
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Get Value from "Properies" block
		fixed4 _MainTint;
		sampler2D _MainTex;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;
		
		struct Input {
			float2 uv_MainTex;
		};

		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// tex2D() 함수로 전달하기 전에
			// UV를 저장하는 별도의 변수를 생성한다.
			fixed2 scrolledUV = IN.uv_MainTex;

			// 시간에 따라 UV를 조정하기 위해
			// x와 y를 저장하는 각각의 변수를 생성한다.
			fixed xScrollValue = _ScrollXSpeed * _Time;
			fixed yScrollValue = _ScrollYSpeed * _Time;

			//최종 UV오프셋을 적용한다.
			scrolledUV += fixed2(xScrollValue, yScrollValue);

			// 텍스처와 색조를 적용한다.
			half4 c = tex2D(_MainTex, scrolledUV);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}