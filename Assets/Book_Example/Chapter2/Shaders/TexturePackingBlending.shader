Shader "CookBook/TexturePackingBlending" 
{
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1, 1, 1, 1)
		
		// Input Textures
		_ColorA ("Terrain Color A", Color) = (1, 1, 1, 1)
		_ColorB ("Terrain Color B", Color) = (1, 1, 1, 1)
		_RTexture ("Red Channel Texture", 2D) = ""{}
		_GTexture ("Green Channel Texture", 2D) = ""{}
		_BTexture ("Blue Channel Texture", 2D) = ""{}
		_ATexture ("Alpha Channel Texture", 2D) = ""{}
		_BlendTex ("Blend Texture", 2D) = ""{}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Get Value from "Properies" block
		float4 _MainTint;
		float4 _ColorA;
		float4 _ColorB;
		sampler2D _RTexture;
		sampler2D _GTexture;
		sampler2D _BTexture;
		sampler2D _ATexture;
		sampler2D _BlendTex;
		
		struct Input {
			float2 uv_RTexture;
			float2 uv_GTexture;
			float2 uv_BTexture;
			float2 uv_ATexture;
			float2 uv_BlendTex;
		};

		
		void surf(Input IN, inout SurfaceOutput o)
		{
			// 혼합할 텍스처로부터 픽셀 데이터를 얻어온다.
			// 텍스쳐가 R,G,B,A 또는 X,Y,Z & W를 리턴하기 때문에
			// 여기에 float4형이 필요하다.
			float4 blendData = tex2D(_BlendTex, IN.uv_BlendTex);

			// 혼합할 텍스처로부터 데이터를 얻어온다.
			float4 rTexData = tex2D(_RTexture, IN.uv_RTexture);
			float4 gTexData = tex2D(_GTexture, IN.uv_GTexture);
			float4 bTexData = tex2D(_BTexture, IN.uv_BTexture);
			float4 aTexData = tex2D(_ATexture, IN.uv_ATexture);

			// 이제 새 RGBA 값을 구성해 다른 혼합된 텍스처를 함께 더해야 한다.
			float4 finalColor;
			finalColor = lerp(rTexData, gTexData, blendData.g);
			finalColor = lerp(finalColor, bTexData, blendData.b);
			//finalColor = lerp(finalColor, aTexData, blendData.a);
			finalColor.a = 1.0;

			// 터레인이 가진 색조를 더한다.
			float4 terrainLayers = lerp(_ColorA, _ColorB, blendData.r);
			finalColor *= terrainLayers;
			finalColor = saturate(finalColor);
			
			
			// 텍스처와 색조를 적용한다.
			o.Albedo = finalColor.rgb * _MainTint.rgb;
			o.Alpha = finalColor.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}