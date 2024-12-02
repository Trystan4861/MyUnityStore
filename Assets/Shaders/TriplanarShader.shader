/*
 * Triplanar Shader for Unity
 * 
 * Descripción:
 * Este shader aplica una textura a un objeto utilizando proyección triplanar, 
 * proyectando la textura desde tres direcciones (ejes X, Y, Z). Permite controlar 
 * el tamaño de la textura con el parámetro _Scale, donde un valor mayor de _Scale 
 * hace que la textura se vea más grande y un valor menor la hace más pequeña.
 * 
 * Autor: @Trystan4861
 * Fecha: 02-12-2024
 * Licencia: MIT
 * 
 * Para más detalles, consulta el repositorio en GitHub: https://github.com/Trystan4861/MyUnityStore/Assets/Shaders
 */

 Shader "Custom/Triplanar"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Scale ("Texture Scale", Float) = 1.0 // El valor de _Scale será proporcional al tamaño de la textura
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 worldPos : TEXCOORD0;
                float3 normal : TEXCOORD1;
            };

            sampler2D _MainTex;
            float _Scale; // Escala de la textura (ahora proporcional al tamaño)

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                o.normal = normalize(mul((float3x3)unity_ObjectToWorld, v.normal));
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float3 blending = abs(i.normal);
                blending = normalize(pow(blending, 10.0)); // Suaviza las transiciones
                blending /= (blending.x + blending.y + blending.z);

                // Ahora dividimos las coordenadas por _Scale, lo que hace que un valor mayor de _Scale haga la textura más grande
                float4 xTex = tex2D(_MainTex, i.worldPos.yz / _Scale); // División por _Scale
                float4 yTex = tex2D(_MainTex, i.worldPos.xz / _Scale); // División por _Scale
                float4 zTex = tex2D(_MainTex, i.worldPos.xy / _Scale); // División por _Scale

                return xTex * blending.x + yTex * blending.y + zTex * blending.z;
            }
            ENDCG
        }
    }
}
