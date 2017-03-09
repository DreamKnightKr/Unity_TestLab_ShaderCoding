Shader "Cg shader using blending 2Pass" {
	Properties {
		_ColorMain ("color near to point", Color) = (0.5, 0.5, 0.5, 0.5)
		[Enum(UnityEngine.Rendering.BlendMode)] _BlendSrc ("Src Blend mode", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _BlendDst ("Dst Blend mode", Float) = 1
	}
   SubShader {
      Tags { "Queue" = "Transparent" } 
      Blend [_BlendSrc] [_BlendDst]
         // draw after all opaque geometry has been drawn
      Pass {
      	Cull Front // first pass renders only back faces 
             // (the "inside")

         CGPROGRAM 
 
         #pragma vertex vert 
         #pragma fragment frag

         uniform float4 _ColorMain;
 
         float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
         {
            return mul(UNITY_MATRIX_MVP, vertexPos);
         }
 
         float4 frag(void) : COLOR 
         {
            return _ColorMain;
         }
 
         ENDCG  
      }

      Pass {
      	Cull Back // first pass renders only back faces 
             // (the "inside")

         CGPROGRAM 
 
         #pragma vertex vert 
         #pragma fragment frag

         uniform float4 _ColorMain;
 
         float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
         {
            return mul(UNITY_MATRIX_MVP, vertexPos);
         }
 
         float4 frag(void) : COLOR 
         {
            return _ColorMain;
         }
 
         ENDCG  
      }
   }
}