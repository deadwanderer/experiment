package main
ShaderType :: enum {
	Vertex,
	Fragment,
	Compute,
}
Shader_Data::struct{
	type: ShaderType,
	dxil: []byte,
	spv:  []byte,
}
textured_quad_vert := Shader_Data {
	type = .Vertex,
	dxil = #load("../bin/shaders/TexturedQuad.vert.dxil"),
	spv = #load("../bin/shaders/TexturedQuad.vert.spv"),
}
textured_quad_array_frag := Shader_Data {
	type = .Fragment,
	dxil = #load("../bin/shaders/TexturedQuadArray.frag.dxil"),
	spv = #load("../bin/shaders/TexturedQuadArray.frag.spv"),
}
