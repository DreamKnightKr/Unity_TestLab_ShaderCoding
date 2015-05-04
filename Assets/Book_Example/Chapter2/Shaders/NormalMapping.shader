Shader "CookBook/NormalMapping" 
{
	Properties {
		_MainTint ("Diffuse Tint", Color) = (1, 1, 1, 1)
		_NormalTex ("Norma Map", 2D) = "bump" {}
		_NormalIntensity ("Normal Map Intensity", Range(0, 2)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert
		
		// Get Value from "Properies" block
		float4 _MainTint;
		sampler2D _NormalTex;
		float _NormalIntensity;
		
		
		struct Input {
			float2 uv_NormalTex;
		};
		
		void surf (Input IN, inout SurfaceOutput o) 
		{
			//Get teh normal Data out of the normal map textures
			//using the UnpackNormal() function.
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			normalMap = float3(normalMap.x * _NormalIntensity, normalMap.y * _NormalIntensity, normalMap.z);
						
			//Apply the new normals to the lighting model
			o.Normal = normalMap.rgb;
			o.Albedo = _MainTint.rgb;
			o.Alpha = _MainTint.a;
		}
		
		ENDCG
	} 
	FallBack "Diffuse"
}