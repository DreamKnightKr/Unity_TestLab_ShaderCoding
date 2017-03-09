Shader "Cg shader using discard" {
   SubShader {
      Pass {
         Cull Off // turn off triangle culling, alternatives are:
         // Cull Back (or nothing): cull only back faces 
         // Cull Front : cull only front faces
 
         CGPROGRAM 
 
         #pragma vertex vert  
         #pragma fragment frag 
 
         struct vertexInput {
            float4 vertex : POSITION;
         };
         struct vertexOutput {
            float4 pos : SV_POSITION;
            float4 posInObjectCoords : TEXCOORD0;
         };

         float4x4 _matrixTemp;
 
         vertexOutput vert(vertexInput input) 
         {
            vertexOutput output;
 
            output.pos =  mul(UNITY_MATRIX_MVP, input.vertex);
            output.posInObjectCoords = mul(unity_ObjectToWorld, input.vertex);
            output.posInObjectCoords = mul(_matrixTemp, output.posInObjectCoords);

 			return output;
         }
 
         float4 frag(vertexOutput input) : COLOR 
         {
         	
            if (input.posInObjectCoords.x > -0.5 && input.posInObjectCoords.x < 0.5 &&
                     input.posInObjectCoords.y > -0.5 && input.posInObjectCoords.y < 0.5 &&
                     input.posInObjectCoords.z > -0.5 && input.posInObjectCoords.z < 0.5)
                     discard;
            return float4(0.0, 1.0, 0.0, 1.0); // green
         }
 
         ENDCG  
      }
   }
}