Shader "Cg shader using blending" {
	Properties {
		_ColorMain ("color near to point", Color) = (0.5, 0.5, 0.5, 0.5)
		[Enum(UnityEngine.Rendering.BlendMode)] _BlendSrc ("Src Blend mode", Float) = 1
		[Enum(UnityEngine.Rendering.BlendMode)] _BlendDst ("Dst Blend mode", Float) = 1
		[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull mode", Float) = 2
	}
   SubShader {
      Tags { "Queue" = "Transparent" } 
      Blend [_BlendSrc] [_BlendDst]
      Cull [_Cull]
         // draw after all opaque geometry has been drawn
      Pass {
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects

         

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
               // the fourth component (alpha) is important: 
               // this is semitransparent green
         }
 
         ENDCG  
      }
   }
}