Texture2DArray<float4> Texture : register(t0, space2);
SamplerState Sampler : register(s0, space2);

float4 main(float2 TexCoord : TEXCOORD0) : SV_Target0 {
    uint array_index = TexCoord.x > 0.67f ? 2 : TexCoord.x > 0.33f ? 1 : 0;
    return Texture.Sample(Sampler, float3(TexCoord, float(array_index)));
}