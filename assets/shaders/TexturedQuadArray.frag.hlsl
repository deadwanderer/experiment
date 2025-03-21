Texture2DArray<float4> Texture : register(t0, space2);
SamplerState Sampler : register(s0, space2);

float4 main(float2 TexCoord : TEXCOORD0) : SV_Target0 {
    uint array_index = uint(int(TexCoord.y > 0.5f));
    return Texture.Sample(Sampler, float3(TexCoord, float(array_index)));
}