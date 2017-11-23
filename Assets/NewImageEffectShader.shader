Shader "Hidden/NewImageEffectShader"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_NoiseTex ("NoiseTexture", 2D) = "gray" {}
		Scale ("Scale", int) = 40
		NoiseIntensity ("NoiseIntensity", int) = 5
	}
	SubShader
	{
		// No culling or depth
		Cull Off ZWrite Off ZTest Always

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv;
				return o;
			}
			
			sampler2D _MainTex;
			sampler2D _NoiseTex;

			int Scale;
			int NoiseIntensity;

			fixed4 frag (v2f i) : SV_Target
			{
				float u = (int)(i.uv.x * Scale);
				float v = (int)(i.uv.y * Scale);

				fixed4 col = tex2D(_MainTex, float2(u,v) / Scale);
				fixed4 col2 = tex2D(_NoiseTex, float2(u, v) / Scale);

				col += fixed4(i.uv, 0, 1);
				col += col2 / NoiseIntensity;

				return col;
			}
			ENDCG
		}
	}
}
