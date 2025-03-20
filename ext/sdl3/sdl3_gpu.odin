package sdl3

import "core:c"

Device :: struct {}
Buffer :: struct {}
Transfer_Buffer :: struct {}
Texture :: struct {}
Sampler :: struct {}
Shader :: struct {}
Compute_Pipeline :: struct {}
Graphics_Pipeline :: struct {}
Command_Buffer :: struct {}
Render_Pass :: struct {}
Compute_Pass :: struct {}
Copy_Pass :: struct {}
Fence :: struct {}


Primitive_Type :: enum c.int {
	Triangle_List, /**< A series of separate triangles. */
	Triangle_Strip, /**< A series of connected triangles. */
	Line_List, /**< A series of separate lines. */
	Line_Strip, /**< A series of connected lines. */
	Point_List, /**< A series of separate points. */
}

Load_Op :: enum c.int {
	Load, /**< The previous contents of the texture will be preserved. */
	Clear, /**< The contents of the texture will be cleared to a color. */
	Dont_Care, /**< The previous contents of the texture need not be preserved. The contents will be undefined. */
}

Store_Op :: enum c.int {
	Store, /**< The contents generated during the render pass will be written to memory. */
	Dont_Care, /**< The contents generated during the render pass are not needed and may be discarded. The contents will be undefined. */
	Resolve, /**< The multisample contents generated during the render pass will be resolved to a non-multisample texture. The contents in the multisample texture may then be discarded and will be undefined. */
	Resolve_And_Store, /**< The multisample contents generated during the render pass will be resolved to a non-multisample texture. The contents in the multisample texture will be written to memory. */
}

Index_Element_Size :: enum c.int {
	Sixteen, /**< The index elements are 16-bit. */
	ThirtyTwo, /**< The index elements are 32-bit. */
}

Texture_Format :: enum c.int {
	Invalid,

	/* Unsigned Normalized Float Color Formats */
	A8_UNorm,
	R8_UNorm,
	R8G8_UNorm,
	R8G8B8A8_UNorm,
	R16_UNorm,
	R16G16_UNorm,
	R16G16B16A16_UNorm,
	R10G10B10A2_UNorm,
	B5G6R5_UNorm,
	B5G5R5A1_UNorm,
	B4G4R4A4_UNorm,
	B8G8R8A8_UNorm,
	/* Compressed Unsigned Normalized Float Color Formats */
	BC1_RGBA_UNorm,
	BC2_RGBA_UNorm,
	BC3_RGBA_UNorm,
	BC4_R_UNorm,
	BC5_RG_UNorm,
	BC7_RGBA_UNorm,
	/* Compressed Signed Float Color Formats */
	BC6H_RGB_Float,
	/* Compressed Unsigned Float Color Formats */
	BC6H_RGB_UFloat,
	/* Signed Normalized Float Color Formats  */
	R8_SNorm,
	R8G8_SNorm,
	R8G8B8A8_SNorm,
	R16_SNorm,
	R16G16_SNorm,
	R16G16B16A16_SNorm,
	/* Signed Float Color Formats */
	R16_Float,
	R16G16_Float,
	R16G16B16A16_Float,
	R32_Float,
	R32G32_Float,
	R32G32B32A32_Float,
	/* Unsigned Float Color Formats */
	R11G11B10_UFloat,
	/* Unsigned Integer Color Formats */
	R8_UInt,
	R8G8_UInt,
	R8G8B8A8_UInt,
	R16_UInt,
	R16G16_UInt,
	R16G16B16A16_UInt,
	R32_UInt,
	R32G32_UInt,
	R32G32B32A32_UInt,
	/* Signed Integer Color Formats */
	R8_Int,
	R8G8_Int,
	R8G8B8A8_Int,
	R16_Int,
	R16G16_Int,
	R16G16B16A16_Int,
	R32_Int,
	R32G32_Int,
	R32G32B32A32_Int,
	/* Srgb Unsigned Normalized Color Formats */
	R8G8B8A8_UNorm_Srgb,
	B8G8R8A8_UNorm_Srgb,
	/* Compressed Srgb Unsigned Normalized Color Formats */
	BC1_RGBA_UNorm_Srgb,
	BC2_RGBA_UNorm_Srgb,
	BC3_RGBA_UNorm_Srgb,
	BC7_RGBA_UNorm_Srgb,
	/* Depth Formats */
	D16_UNorm,
	D24_UNorm,
	D32_Float,
	D24_UNorm_S8_UInt,
	D32_Float_S8_UInt,
	/* Compressed ASTC Normalized Float Color Formats*/
	ASTC_4x4_UNorm,
	ASTC_5x4_UNorm,
	ASTC_5x5_UNorm,
	ASTC_6x5_UNorm,
	ASTC_6x6_UNorm,
	ASTC_8x5_UNorm,
	ASTC_8x6_UNorm,
	ASTC_8x8_UNorm,
	ASTC_10x5_UNorm,
	ASTC_10x6_UNorm,
	ASTC_10x8_UNorm,
	ASTC_10x10_UNorm,
	ASTC_12x10_UNorm,
	ASTC_12x12_UNorm,
	/* Compressed Srgb ASTC Normalized Float Color Formats*/
	ASTC_4x4_UNorm_Srgb,
	ASTC_5x4_UNorm_Srgb,
	ASTC_5x5_UNorm_Srgb,
	ASTC_6x5_UNorm_Srgb,
	ASTC_6x6_UNorm_Srgb,
	ASTC_8x5_UNorm_Srgb,
	ASTC_8x6_UNorm_Srgb,
	ASTC_8x8_UNorm_Srgb,
	ASTC_10x5_UNorm_Srgb,
	ASTC_10x6_UNorm_Srgb,
	ASTC_10x8_UNorm_Srgb,
	ASTC_10x10_UNorm_Srgb,
	ASTC_12x10_UNorm_Srgb,
	ASTC_12x12_UNorm_Srgb,
	/* Compressed ASTC Signed Float Color Formats*/
	ASTC_4x4_Float,
	ASTC_5x4_Float,
	ASTC_5x5_Float,
	ASTC_6x5_Float,
	ASTC_6x6_Float,
	ASTC_8x5_Float,
	ASTC_8x6_Float,
	ASTC_8x8_Float,
	ASTC_10x5_Float,
	ASTC_10x6_Float,
	ASTC_10x8_Float,
	ASTC_10x10_Float,
	ASTC_12x10_Float,
	ASTC_12x12_Float,
}

Texture_Usage_Flags :: distinct bit_set[Texture_Usage_Flag;u32]
Texture_Usage_Flag :: enum u32 {
	Sampler                                 = 0, /**< Texture supports sampling. */
	Color_Target                            = 1, /**< Texture is a color render target. */
	Depth_Stencil_Target                    = 2, /**< Texture is a depth stencil target. */
	Graphics_Storage_Read                   = 3, /**< Texture supports storage reads in graphics stages. */
	Compute_Storage_Read                    = 4, /**< Texture supports storage reads in the compute stage. */
	Compute_Storage_Write                   = 5, /**< Texture supports storage writes in the compute stage. */
	Compute_Storage_Simultaneous_Read_Write = 6, /**< Texture supports reads and writes in the same compute shader. This is NOT equivalent to Read | Write. */
}

Texture_Type :: enum c.int {
	D2, /**< The texture is a 2-dimensional image. */
	D2_Array, /**< The texture is a 2-dimensional array image. */
	D3, /**< The texture is a 3-dimensional image. */
	Cube, /**< The texture is a cube image. */
	Cube_Array, /**< The texture is a cube array image. */
}

Sample_Count :: enum c.int {
	_1, /**< No multisampling. */
	_2, /**< MSAA 2x */
	_4, /**< MSAA 4x */
	_8, /**< MSAA 8x */
}

Cube_Map_Face :: enum c.int {
	Positive_X,
	Negative_X,
	Positive_Y,
	Negative_Y,
	Positive_Z,
	Negative_Z,
}


Buffer_Usage_Flags :: distinct bit_set[Buffer_Usage_Flag;u32]
Buffer_Usage_Flag :: enum u32 {
	Vertex                = 0, /**< Buffer is a vertex buffer. */
	Index                 = 1, /**< Buffer is an index buffer. */
	Indirect              = 2, /**< Buffer is an indirect buffer. */
	Graphics_Storage_Read = 3, /**< Buffer supports storage reads in graphics stages. */
	Compute_Storage_Read  = 4, /**< Buffer supports storage reads in the compute stage. */
	Compute_Storage_Write = 5, /**< Buffer supports storage writes in the compute stage. */
}

Transfer_Buffer_Usage :: enum c.int {
	Upload,
	Download,
}

Shader_Stage :: enum c.int {
	Vertex,
	Fragment,
}

Shader_Format :: distinct bit_set[Shader_Format_Flag;u32]
Shader_Format_Flag :: enum u32 {
	Private  = 0, /**< Shaders for NDA'd platforms. */
	SPIRV    = 1, /**< SPIR-V shaders for Vulkan. */
	DXBC     = 2, /**< DXBC SM5_1 shaders for D3D12. */
	DXIL     = 3, /**< DXIL SM6_0 shaders for D3D12. */
	MSL      = 4, /**< MSL shaders for Metal. */
	METALLIB = 5, /**< Precompiled metallib shaders for Metal. */
}
GPU_SHADERFORMAT_INVALID :: Shader_Format{}

Vertex_Element_Format :: enum c.int {
	Invalid,

	/* 32-bit Signed Integers */
	Int,
	Int2,
	Int3,
	Int4,

	/* 32-bit Unsigned Integers */
	UInt,
	UInt2,
	UInt3,
	UInt4,

	/* 32-bit Floats */
	Float,
	Float2,
	Float3,
	Float4,

	/* 8-bit Signed Integers */
	Byte2,
	Byte4,

	/* 8-bit Unsigned Integers */
	UByte2,
	UByte4,

	/* 8-bit Signed Normalized */
	Byte2_Norm,
	Byte4_Norm,

	/* 8-bit Unsigned Normalized */
	UByte2_Norm,
	UByte4_Norm,

	/* 16-bit Signed Integers */
	Short2,
	Short4,

	/* 16-bit Unsigned Integers */
	UShort2,
	UShort4,

	/* 16-bit Signed Normalized */
	Short2_Norm,
	Short4_Norm,

	/* 16-bit Unsigned Normalized */
	UShort2_Norm,
	UShort4_Norm,

	/* 16-bit Floats */
	Half2,
	Half4,
}

Vertex_Input_Rate :: enum c.int {
	Vertex, /**< Attribute addressing is a function of the vertex index. */
	Instance, /**< Attribute addressing is a function of the instance index. */
}


Fill_Mode :: enum c.int {
	Fill, /**< Polygons will be rendered via rasterization. */
	Line, /**< Polygon edges will be drawn as line segments. */
}

Cull_Mode :: enum c.int {
	None, /**< No triangles are culled. */
	Front, /**< Front-facing triangles are culled. */
	Back, /**< Back-facing triangles are culled. */
}

Front_Face :: enum c.int {
	Counter_Clockwise,
	/**< A triangle with counter-clockwise vertex winding will be considered front-facing. */
	Clockwise, /**< A triangle with clockwise vertex winding will be considered front-facing. */
}

Compare_Op :: enum c.int {
	Invalid,
	Never, /**< The comparison always evaluates false. */
	Less, /**< The comparison evaluates reference < test. */
	Equal, /**< The comparison evaluates reference == test. */
	Less_Or_Equal, /**< The comparison evaluates reference <= test. */
	Greater, /**< The comparison evaluates reference > test. */
	Not_Equal, /**< The comparison evaluates reference != test. */
	Greater_Or_Equal, /**< The comparison evalutes reference >= test. */
	Always, /**< The comparison always evaluates true. */
}

Stencil_Op :: enum c.int {
	Invalid,
	Keep, /**< Keeps the current value. */
	Zero, /**< Sets the value to 0. */
	Replace, /**< Sets the value to reference. */
	Increment_And_Clamp, /**< Increments the current value and clamps to the maximum value. */
	Decrement_And_Clamp, /**< Decrements the current value and clamps to 0. */
	Invert, /**< Bitwise-inverts the current value. */
	Increment_And_Wrap, /**< Increments the current value and wraps back to 0. */
	Decrement_And_Wrap, /**< Decrements the current value and wraps to the maximum value. */
}

Blend_Op :: enum c.int {
	Invalid,
	Add, /**< (source * source_factor) + (destination * destination_factor) */
	Subtract, /**< (source * source_factor) - (destination * destination_factor) */
	Reverse_Subtract, /**< (destination * destination_factor) - (source * source_factor) */
	Min, /**< min(source, destination) */
	Max, /**< max(source, destination) */
}

Blend_Factor :: enum c.int {
	Invalid,
	Zero, /**< 0 */
	One, /**< 1 */
	Src_Color, /**< source color */
	One_Minus_Src_Color, /**< 1 - source color */
	Dst_Color, /**< destination color */
	One_Minus_Dst_Color, /**< 1 - destination color */
	Src_Alpha, /**< source alpha */
	One_Minus_Src_Alpha, /**< 1 - source alpha */
	Dst_Alpha, /**< destination alpha */
	One_Minus_Dst_Alpha, /**< 1 - destination alpha */
	Constant_Color, /**< blend constant */
	One_Minus_Constant_Color, /**< 1 - blend constant */
	Src_Alpha_Saturate, /**< min(source alpha, 1 - destination alpha) */
}


Color_Component_Flags :: distinct bit_set[Color_Component_Flag;u8]
Color_Component_Flag :: enum u8 {
	R = 0, /**< the red component */
	G = 1, /**< the green component */
	B = 2, /**< the blue component */
	A = 3, /**< the alpha component */
}

Filter :: enum c.int {
	Nearest, /**< Point filtering. */
	Linear, /**< Linear filtering. */
}

Sampler_Mipmap_Mode :: enum c.int {
	Nearest, /**< Point filtering. */
	Linear, /**< Linear filtering. */
}

Sampler_Address_Mode :: enum c.int {
	Repeat, /**< Specifies that the coordinates will wrap around. */
	Mirrored_Repeat, /**< Specifies that the coordinates will wrap around mirrored. */
	Clamp_To_Edge, /**< Specifies that the coordinates will clamp to the 0-1 range. */
}

Present_Mode :: enum c.int {
	Vsync,
	Immediate,
	Mailbox,
}

Swapchain_Composition :: enum c.int {
	SDR,
	SDR_Linear,
	HDR_Extended_Linear,
	HDR10_ST2084,
}


Viewport :: struct {
	x:         f32, /**< The left offset of the viewport. */
	y:         f32, /**< The top offset of the viewport. */
	w:         f32, /**< The width of the viewport. */
	h:         f32, /**< The height of the viewport. */
	min_depth: f32, /**< The minimum depth of the viewport. */
	max_depth: f32, /**< The maximum depth of the viewport. */
}


Texture_Transfer_Info :: struct {
	transfer_buffer: ^Transfer_Buffer, /**< The transfer buffer used in the transfer operation. */
	offset:          u32, /**< The starting byte of the image data in the transfer buffer. */
	pixels_per_row:  u32, /**< The number of pixels from one row to the next. */
	rows_per_layer:  u32, /**< The number of rows from one layer/depth-slice to the next. */
}


Transfer_Buffer_Location :: struct {
	transfer_buffer: ^Transfer_Buffer, /**< The transfer buffer used in the transfer operation. */
	offset:          u32, /**< The starting byte of the buffer data in the transfer buffer. */
}

Texture_Location :: struct {
	texture:   ^Texture, /**< The texture used in the copy operation. */
	mip_level: u32, /**< The mip level index of the location. */
	layer:     u32, /**< The layer index of the location. */
	x:         u32, /**< The left offset of the location. */
	y:         u32, /**< The top offset of the location. */
	z:         u32, /**< The front offset of the location. */
}

Texture_Region :: struct {
	texture:   ^Texture, /**< The texture used in the copy operation. */
	mip_level: u32, /**< The mip level index to transfer. */
	layer:     u32, /**< The layer index to transfer. */
	x:         u32, /**< The left offset of the region. */
	y:         u32, /**< The top offset of the region. */
	z:         u32, /**< The front offset of the region. */
	w:         u32, /**< The width of the region. */
	h:         u32, /**< The height of the region. */
	d:         u32, /**< The depth of the region. */
}

Blit_Region :: struct {
	texture:              ^Texture, /**< The texture. */
	mip_level:            u32, /**< The mip level index of the region. */
	layer_or_depth_plane: u32, /**< The layer index or depth plane of the region. This value is treated as a layer index on 2D array and cube textures, and as a depth plane on 3D textures. */
	x:                    u32, /**< The left offset of the region. */
	y:                    u32, /**< The top offset of the region.  */
	w:                    u32, /**< The width of the region. */
	h:                    u32, /**< The height of the region. */
}

Buffer_Location :: struct {
	buffer: ^Buffer, /**< The buffer. */
	offset: u32, /**< The starting byte within the buffer. */
}


Buffer_Region :: struct {
	buffer: ^Buffer, /**< The buffer. */
	offset: u32, /**< The starting byte within the buffer. */
	size:   u32, /**< The size in bytes of the region. */
}


Indirect_Draw_Command :: struct {
	num_vertices:   u32, /**< The number of vertices to draw. */
	num_instances:  u32, /**< The number of instances to draw. */
	first_vertex:   u32, /**< The index of the first vertex to draw. */
	first_instance: u32, /**< The ID of the first instance to draw. */
}

Indexed_Indirect_Draw_Command :: struct {
	num_indices:    u32, /**< The number of indices to draw per instance. */
	num_instances:  u32, /**< The number of instances to draw. */
	first_index:    u32, /**< The base index within the index buffer. */
	vertex_offset:  Sint32, /**< The value added to the vertex index before indexing into the vertex buffer. */
	first_instance: u32, /**< The ID of the first instance to draw. */
}

Indirect_Dispatch_Command :: struct {
	groupcount_x: u32, /**< The number of local workgroups to dispatch in the X dimension. */
	groupcount_y: u32, /**< The number of local workgroups to dispatch in the Y dimension. */
	groupcount_z: u32, /**< The number of local workgroups to dispatch in the Z dimension. */
}


Sampler_Create_Info :: struct {
	min_filter:        Filter, /**< The minification filter to apply to lookups. */
	mag_filter:        Filter, /**< The magnification filter to apply to lookups. */
	mipmap_mode:       Sampler_Mipmap_Mode, /**< The mipmap filter to apply to lookups. */
	address_mode_u:    Sampler_Address_Mode, /**< The addressing mode for U coordinates outside [0, 1). */
	address_mode_v:    Sampler_Address_Mode, /**< The addressing mode for V coordinates outside [0, 1). */
	address_mode_w:    Sampler_Address_Mode, /**< The addressing mode for W coordinates outside [0, 1). */
	mip_lod_bias:      f32, /**< The bias to be added to mipmap LOD calculation. */
	max_anisotropy:    f32, /**< The anisotropy value clamp used by the sampler. If enable_anisotropy is false, this is ignored. */
	compare_op:        Compare_Op, /**< The comparison operator to apply to fetched data before filtering. */
	min_lod:           f32, /**< Clamps the minimum of the computed LOD value. */
	max_lod:           f32, /**< Clamps the maximum of the computed LOD value. */
	enable_anisotropy: bool, /**< true to enable anisotropic filtering. */
	enable_compare:    bool, /**< true to enable comparison against a reference value during lookups. */
	_:                 u8,
	_:                 u8,
	props:             PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Vertex_Buffer_Description :: struct {
	slot:               u32, /**< The binding slot of the vertex buffer. */
	pitch:              u32, /**< The byte pitch between consecutive elements of the vertex buffer. */
	input_rate:         Vertex_Input_Rate, /**< Whether attribute addressing is a function of the vertex index or instance index. */
	instance_step_rate: u32, /**< The number of instances to draw using the same per-instance data before advancing in the instance buffer by one element. Ignored unless input_rate is GPU_VERTEXINPUTRATE_INSTANCE */
}

Vertex_Attribute :: struct {
	location:    u32, /**< The shader input location index. */
	buffer_slot: u32, /**< The binding slot of the associated vertex buffer. */
	format:      Vertex_Element_Format, /**< The size and type of the attribute data. */
	offset:      u32, /**< The byte offset of this attribute relative to the start of the vertex element. */
}

Vertex_Input_State :: struct {
	vertex_buffer_descriptions: [^]Vertex_Buffer_Description `fmt:"v,num_vertex_buffers"`, /**< A pointer to an array of vertex buffer descriptions. */
	num_vertex_buffers:         u32, /**< The number of vertex buffer descriptions in the above array. */
	vertex_attributes:          [^]Vertex_Attribute `fmt:"v,num_vertex_attributes"`, /**< A pointer to an array of vertex attribute descriptions. */
	num_vertex_attributes:      u32, /**< The number of vertex attribute descriptions in the above array. */
}

Stencil_Op_State :: struct {
	fail_op:       Stencil_Op, /**< The action performed on samples that fail the stencil test. */
	pass_op:       Stencil_Op, /**< The action performed on samples that pass the depth and stencil tests. */
	depth_fail_op: Stencil_Op, /**< The action performed on samples that pass the stencil test and fail the depth test. */
	compare_op:    Compare_Op, /**< The comparison operator used in the stencil test. */
}

Color_Target_Blend_State :: struct {
	src_color_blendfactor:   Blend_Factor, /**< The value to be multiplied by the source RGB value. */
	dst_color_blendfactor:   Blend_Factor, /**< The value to be multiplied by the destination RGB value. */
	color_blend_op:          Blend_Op, /**< The blend operation for the RGB components. */
	src_alpha_blendfactor:   Blend_Factor, /**< The value to be multiplied by the source alpha. */
	dst_alpha_blendfactor:   Blend_Factor, /**< The value to be multiplied by the destination alpha. */
	alpha_blend_op:          Blend_Op, /**< The blend operation for the alpha component. */
	color_write_mask:        Color_Component_Flags, /**< A bitmask specifying which of the RGBA components are enabled for writing. Writes to all channels if enable_color_write_mask is false. */
	enable_blend:            bool, /**< Whether blending is enabled for the color target. */
	enable_color_write_mask: bool, /**< Whether the color write mask is enabled. */
	_:                       u8,
	_:                       u8,
}

Shader_Create_Info :: struct {
	code_size:            uint, /**< The size in bytes of the code pointed to. */
	code:                 [^]u8, /**< A pointer to shader code. */
	entrypoint:           cstring, /**< A pointer to a null-terminated UTF-8 string specifying the entry point function name for the shader. */
	format:               Shader_Format, /**< The format of the shader code. */
	stage:                Shader_Stage, /**< The stage the shader program corresponds to. */
	num_samplers:         u32, /**< The number of samplers defined in the shader. */
	num_storage_textures: u32, /**< The number of storage textures defined in the shader. */
	num_storage_buffers:  u32, /**< The number of storage buffers defined in the shader. */
	num_uniform_buffers:  u32, /**< The number of uniform buffers defined in the shader. */
	props:                PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Texture_Create_Info :: struct {
	type:                 Texture_Type, /**< The base dimensionality of the texture. */
	format:               Texture_Format, /**< The pixel format of the texture. */
	usage:                Texture_Usage_Flags, /**< How the texture is intended to be used by the client. */
	width:                u32, /**< The width of the texture. */
	height:               u32, /**< The height of the texture. */
	layer_count_or_depth: u32, /**< The layer count or depth of the texture. This value is treated as a layer count on 2D array textures, and as a depth value on 3D textures. */
	num_levels:           u32, /**< The number of mip levels in the texture. */
	sample_count:         Sample_Count, /**< The number of samples per texel. Only applies if the texture is used as a render target. */
	props:                PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Buffer_Create_Info :: struct {
	usage: Buffer_Usage_Flags, /**< How the buffer is intended to be used by the client. */
	size:  u32, /**< The size in bytes of the buffer. */
	props: PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Transfer_Buffer_Create_Info :: struct {
	usage: Transfer_Buffer_Usage, /**< How the transfer buffer is intended to be used by the client. */
	size:  u32, /**< The size in bytes of the transfer buffer. */
	props: PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Rasterizer_State :: struct {
	fill_mode:                  Fill_Mode, /**< Whether polygons will be filled in or drawn as lines. */
	cull_mode:                  Cull_Mode, /**< The facing direction in which triangles will be culled. */
	front_face:                 Front_Face, /**< The vertex winding that will cause a triangle to be determined as front-facing. */
	depth_bias_constant_factor: f32, /**< A scalar factor controlling the depth value added to each fragment. */
	depth_bias_clamp:           f32, /**< The maximum depth bias of a fragment. */
	depth_bias_slope_factor:    f32, /**< A scalar factor applied to a fragment's slope in depth calculations. */
	enable_depth_bias:          bool, /**< true to bias fragment depth values. */
	enable_depth_clip:          bool, /**< true to enable depth clip, false to enable depth clamp. */
	_:                          u8,
	_:                          u8,
}


Multisample_State :: struct {
	sample_count: Sample_Count, /**< The number of samples to be used in rasterization. */
	sample_mask:  u32, /**< Determines which samples get updated in the render targets. Treated as 0xFFFFFFFF if enable_mask is false. */
	enable_mask:  bool, /**< Enables sample masking. */
	_:            u8,
	_:            u8,
	_:            u8,
}


Depth_Stencil_State :: struct {
	compare_op:          Compare_Op, /**< The comparison operator used for depth testing. */
	back_stencil_state:  Stencil_Op_State, /**< The stencil op state for back-facing triangles. */
	front_stencil_state: Stencil_Op_State, /**< The stencil op state for front-facing triangles. */
	compare_mask:        u8, /**< Selects the bits of the stencil values participating in the stencil test. */
	write_mask:          u8, /**< Selects the bits of the stencil values updated by the stencil test. */
	enable_depth_test:   bool, /**< true enables the depth test. */
	enable_depth_write:  bool, /**< true enables depth writes. Depth writes are always disabled when enable_depth_test is false. */
	enable_stencil_test: bool, /**< true enables the stencil test. */
	_:                   u8,
	_:                   u8,
	_:                   u8,
}

Color_Target_Description :: struct {
	format:      Texture_Format, /**< The pixel format of the texture to be used as a color target. */
	blend_state: Color_Target_Blend_State, /**< The blend state to be used for the color target. */
}

Graphics_Pipeline_Target_Info :: struct {
	color_target_descriptions: [^]Color_Target_Description `fmt:"v,num_color_targets"`, /**< A pointer to an array of color target descriptions. */
	num_color_targets:         u32, /**< The number of color target descriptions in the above array. */
	depth_stencil_format:      Texture_Format, /**< The pixel format of the depth-stencil target. Ignored if has_depth_stencil_target is false. */
	has_depth_stencil_target:  bool, /**< true specifies that the pipeline uses a depth-stencil target. */
	_:                         u8,
	_:                         u8,
	_:                         u8,
}

Graphics_Pipeline_Create_Info :: struct {
	vertex_shader:       ^Shader, /**< The vertex shader used by the graphics pipeline. */
	fragment_shader:     ^Shader, /**< The fragment shader used by the graphics pipeline. */
	vertex_input_state:  Vertex_Input_State, /**< The vertex layout of the graphics pipeline. */
	primitive_type:      Primitive_Type, /**< The primitive topology of the graphics pipeline. */
	rasterizer_state:    Rasterizer_State, /**< The rasterizer state of the graphics pipeline. */
	multisample_state:   Multisample_State, /**< The multisample state of the graphics pipeline. */
	depth_stencil_state: Depth_Stencil_State, /**< The depth-stencil state of the graphics pipeline. */
	target_info:         Graphics_Pipeline_Target_Info, /**< Formats and blend modes for the render targets of the graphics pipeline. */
	props:               PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Compute_Pipeline_Create_Info :: struct {
	code_size:                      uint, /**< The size in bytes of the compute shader code pointed to. */
	code:                           [^]u8, /**< A pointer to compute shader code. */
	entrypoint:                     cstring, /**< A pointer to a null-terminated UTF-8 string specifying the entry point function name for the shader. */
	format:                         Shader_Format, /**< The format of the compute shader code. */
	num_samplers:                   u32, /**< The number of samplers defined in the shader. */
	num_readonly_storage_textures:  u32, /**< The number of readonly storage textures defined in the shader. */
	num_readonly_storage_buffers:   u32, /**< The number of readonly storage buffers defined in the shader. */
	num_readwrite_storage_textures: u32, /**< The number of read-write storage textures defined in the shader. */
	num_readwrite_storage_buffers:  u32, /**< The number of read-write storage buffers defined in the shader. */
	num_uniform_buffers:            u32, /**< The number of uniform buffers defined in the shader. */
	threadcount_x:                  u32, /**< The number of threads in the X dimension. This should match the value in the shader. */
	threadcount_y:                  u32, /**< The number of threads in the Y dimension. This should match the value in the shader. */
	threadcount_z:                  u32, /**< The number of threads in the Z dimension. This should match the value in the shader. */
	props:                          PropertiesID, /**< A properties ID for extensions. Should be 0 if no extensions are needed. */
}

Color_Target_Info :: struct {
	texture:               ^Texture, /**< The texture that will be used as a color target by a render pass. */
	mip_level:             u32, /**< The mip level to use as a color target. */
	layer_or_depth_plane:  u32, /**< The layer index or depth plane to use as a color target. This value is treated as a layer index on 2D array and cube textures, and as a depth plane on 3D textures. */
	clear_color:           FColor, /**< The color to clear the color target to at the start of the render pass. Ignored if GPU_LOADOP_CLEAR is not used. */
	load_op:               Load_Op, /**< What is done with the contents of the color target at the beginning of the render pass. */
	store_op:              Store_Op, /**< What is done with the results of the render pass. */
	resolve_texture:       ^Texture, /**< The texture that will receive the results of a multisample resolve operation. Ignored if a RESOLVE* store_op is not used. */
	resolve_mip_level:     u32, /**< The mip level of the resolve texture to use for the resolve operation. Ignored if a RESOLVE* store_op is not used. */
	resolve_layer:         u32, /**< The layer index of the resolve texture to use for the resolve operation. Ignored if a RESOLVE* store_op is not used. */
	cycle:                 bool, /**< true cycles the texture if the texture is bound and load_op is not LOAD */
	cycle_resolve_texture: bool, /**< true cycles the resolve texture if the resolve texture is bound. Ignored if a RESOLVE* store_op is not used. */
	_:                     u8,
	_:                     u8,
}

Depth_Stencil_Target_Info :: struct {
	texture:          ^Texture, /**< The texture that will be used as the depth stencil target by the render pass. */
	clear_depth:      f32, /**< The value to clear the depth component to at the beginning of the render pass. Ignored if GPU_LOADOP_CLEAR is not used. */
	load_op:          Load_Op, /**< What is done with the depth contents at the beginning of the render pass. */
	store_op:         Store_Op, /**< What is done with the depth results of the render pass. */
	stencil_load_op:  Load_Op, /**< What is done with the stencil contents at the beginning of the render pass. */
	stencil_store_op: Store_Op, /**< What is done with the stencil results of the render pass. */
	cycle:            bool, /**< true cycles the texture if the texture is bound and any load ops are not LOAD */
	clear_stencil:    u8, /**< The value to clear the stencil component to at the beginning of the render pass. Ignored if GPU_LOADOP_CLEAR is not used. */
	_:                u8,
	_:                u8,
}


Blit_Info :: struct {
	source:      Blit_Region, /**< The source region for the blit. */
	destination: Blit_Region, /**< The destination region for the blit. */
	load_op:     Load_Op, /**< What is done with the contents of the destination before the blit. */
	clear_color: FColor, /**< The color to clear the destination region to before the blit. Ignored if load_op is not GPU_LOADOP_CLEAR. */
	flip_mode:   FlipMode, /**< The flip mode for the source region. */
	filter:      Filter, /**< The filter mode used when blitting. */
	cycle:       bool, /**< true cycles the destination texture if it is already bound. */
	_:           u8,
	_:           u8,
	_:           u8,
}

Buffer_Binding :: struct {
	buffer: ^Buffer, /**< The buffer to bind. Must have been created with GPU_Buffer_Usage_VERTEX for BindGPUVertexBuffers, or GPU_Buffer_Usage_INDEX for BindGPUIndexBuffer. */
	offset: u32, /**< The starting byte of the data to bind in the buffer. */
}

Texture_Sampler_Binding :: struct {
	texture: ^Texture, /**< The texture to bind. Must have been created with GPU_TEXTUREUSAGE_SAMPLER. */
	sampler: ^Sampler, /**< The sampler to bind. */
}

Storage_Buffer_Read_Write_Binding :: struct {
	buffer: ^Buffer, /**< The buffer to bind. Must have been created with GPU_Buffer_Usage_COMPUTE_STORAGE_WRITE. */
	cycle:  bool, /**< true cycles the buffer if it is already bound. */
	_:      u8,
	_:      u8,
	_:      u8,
}

Storage_Texture_Read_Write_Binding :: struct {
	texture:   ^Texture, /**< The texture to bind. Must have been created with GPU_TEXTUREUSAGE_COMPUTE_STORAGE_WRITE or GPU_TEXTUREUSAGE_COMPUTE_STORAGE_SIMULTANEOUS_READ_WRITE. */
	mip_level: u32, /**< The mip level index to bind. */
	layer:     u32, /**< The layer index to bind. */
	cycle:     bool, /**< true cycles the texture if it is already bound. */
	_:         u8,
	_:         u8,
	_:         u8,
}


PROP_GPU_DEVICE_CREATE_DEBUGMODE_BOOLEAN :: "SDL.gpu.device.create.debugmode"
PROP_GPU_DEVICE_CREATE_PREFERLOWPOWER_BOOLEAN :: "SDL.gpu.device.create.preferlowpower"
PROP_GPU_DEVICE_CREATE_NAME_STRING :: "SDL.gpu.device.create.name"
PROP_GPU_DEVICE_CREATE_SHADERS_PRIVATE_BOOLEAN :: "SDL.gpu.device.create.shaders.private"
PROP_GPU_DEVICE_CREATE_SHADERS_SPIRV_BOOLEAN :: "SDL.gpu.device.create.shaders.spirv"
PROP_GPU_DEVICE_CREATE_SHADERS_DXBC_BOOLEAN :: "SDL.gpu.device.create.shaders.dxbc"
PROP_GPU_DEVICE_CREATE_SHADERS_DXIL_BOOLEAN :: "SDL.gpu.device.create.shaders.dxil"
PROP_GPU_DEVICE_CREATE_SHADERS_MSL_BOOLEAN :: "SDL.gpu.device.create.shaders.msl"
PROP_GPU_DEVICE_CREATE_SHADERS_METALLIB_BOOLEAN :: "SDL.gpu.device.create.shaders.metallib"
PROP_GPU_DEVICE_CREATE_D3D12_SEMANTIC_NAME_STRING :: "SDL.gpu.device.create.d3d12.semantic"

PROP_GPU_COMPUTEPIPELINE_CREATE_NAME_STRING :: "SDL.gpu.computepipeline.create.name"
PROP_GPU_GRAPHICSPIPELINE_CREATE_NAME_STRING :: "SDL.gpu.graphicspipeline.create.name"
PROP_GPU_SAMPLER_CREATE_NAME_STRING :: "SDL.gpu.sampler.create.name"
PROP_GPU_SHADER_CREATE_NAME_STRING :: "SDL.gpu.shader.create.name"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_R_FLOAT :: "SDL.gpu.texture.create.d3d12.clear.r"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_G_FLOAT :: "SDL.gpu.texture.create.d3d12.clear.g"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_B_FLOAT :: "SDL.gpu.texture.create.d3d12.clear.b"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_A_FLOAT :: "SDL.gpu.texture.create.d3d12.clear.a"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_DEPTH_FLOAT :: "SDL.gpu.texture.create.d3d12.clear.depth"
PROP_GPU_TEXTURE_CREATE_D3D12_CLEAR_STENCIL_UINT8 :: "SDL.gpu.texture.create.d3d12.clear.stencil"
PROP_GPU_TEXTURE_CREATE_NAME_STRING :: "SDL.gpu.texture.create.name"
PROP_GPU_BUFFER_CREATE_NAME_STRING :: "SDL.gpu.buffer.create.name"
PROP_GPU_TRANSFERBUFFER_CREATE_NAME_STRING :: "SDL.gpu.transferbuffer.create.name"

@(default_calling_convention = "c", require_results)
foreign lib {
	@(link_name = "SDL_GPUSupportsShaderFormats")
	supports_shader_formats :: proc(format_flags: Shader_Format, name: cstring) -> bool ---
	@(link_name = "SDL_GPUSupportsProperties")
	supports_properties :: proc(props: PropertiesID) -> bool ---
	@(link_name = "SDL_CreateGPUDevice")
	create_device :: proc(format_flags: Shader_Format, debug_mode: bool, name: cstring) -> ^Device ---
	@(link_name = "SDL_CreateGPUDeviceWithProperties")
	create_device_with_properties :: proc(props: PropertiesID) -> ^Device ---
	@(link_name = "SDL_DestroyGPUDevice")
	destroy_device :: proc(device: ^Device) ---
	@(link_name = "SDL_GetNumGPUDrivers")
	get_num_drivers :: proc() -> c.int ---
	@(link_name = "SDL_GetGPUDriver")
	get_driver :: proc(index: c.int) -> cstring ---
	@(link_name = "SDL_GetGPUDeviceDriver")
	get_device_driver :: proc(device: ^Device) -> cstring ---
	@(link_name = "SDL_GetGPUShaderFormats")
	get_shader_formats :: proc(device: ^Device) -> Shader_Format ---
	@(link_name = "SDL_CreateGPUComputePipeline")
	create_compute_Pipeline :: proc(device: ^Device, #by_ptr createinfo: Compute_Pipeline_Create_Info) -> ^Compute_Pipeline ---
	@(link_name = "SDL_CreateGPUGraphicsPipeline")
	create_graphics_Pipeline :: proc(device: ^Device, #by_ptr createinfo: Graphics_Pipeline_Create_Info) -> ^Graphics_Pipeline ---
	@(link_name = "SDL_CreateGPUSampler")
	create_sampler :: proc(device: ^Device, #by_ptr createinfo: Sampler_Create_Info) -> ^Sampler ---
	@(link_name = "SDL_CreateGPUShader")
	create_shader :: proc(device: ^Device, #by_ptr createinfo: Shader_Create_Info) -> ^Shader ---
	@(link_name = "SDL_CreateGPUTexture")
	create_texture :: proc(device: ^Device, #by_ptr createinfo: Texture_Create_Info) -> ^Texture ---
	@(link_name = "SDL_CreateGPUBuffer")
	create_buffer :: proc(device: ^Device, #by_ptr createinfo: Buffer_Create_Info) -> ^Buffer ---
	@(link_name = "SDL_CreateGPUTransferBuffer")
	create_transfer_Buffer :: proc(device: ^Device, #by_ptr createinfo: Transfer_Buffer_Create_Info) -> ^Transfer_Buffer ---
	@(link_name = "SDL_SetGPUBufferName")
	set_buffer_name :: proc(device: ^Device, buffer: ^Buffer, text: cstring) ---
	@(link_name = "SDL_SetGPUTextureName")
	set_texture_name :: proc(device: ^Device, texture: ^Texture, text: cstring) ---
	@(link_name = "SDL_InsertGPUDebugLabel")
	insert_debug_label :: proc(command_buffer: ^Command_Buffer, text: cstring) ---
	@(link_name = "SDL_PushGPUDebugGroup")
	push_debug_group :: proc(command_buffer: ^Command_Buffer, name: cstring) ---
	@(link_name = "SDL_PopGPUDebugGroup")
	pop_debug_group :: proc(command_buffer: ^Command_Buffer) ---
	@(link_name = "SDL_ReleaseGPUTexture")
	release_texture :: proc(device: ^Device, texture: ^Texture) ---
	@(link_name = "SDL_ReleaseGPUSampler")
	release_sampler :: proc(device: ^Device, sampler: ^Sampler) ---
	@(link_name = "SDL_ReleaseGPUBuffer")
	release_buffer :: proc(device: ^Device, buffer: ^Buffer) ---
	@(link_name = "SDL_ReleaseGPUTransferBuffer")
	release_transfer_buffer :: proc(device: ^Device, transfer_buffer: ^Transfer_Buffer) ---
	@(link_name = "SDL_ReleaseGPUComputePipeline")
	release_compute_pipeline :: proc(device: ^Device, compute_pipeline: ^Compute_Pipeline) ---
	@(link_name = "SDL_ReleaseGPUShader")
	release_shader :: proc(device: ^Device, shader: ^Shader) ---
	@(link_name = "SDL_ReleaseGPUGraphicsPipeline")
	release_graphics_pipeline :: proc(device: ^Device, graphics_pipeline: ^Graphics_Pipeline) ---
	@(link_name = "SDL_AcquireGPUCommandBuffer")
	acquire_command_buffer :: proc(device: ^Device) -> ^Command_Buffer ---
	@(link_name = "SDL_PushGPUVertexUniformData")
	push_vertex_uniform_data :: proc(command_buffer: ^Command_Buffer, slot_index: u32, data: rawptr, length: u32) ---
	@(link_name = "SDL_PushGPUFragmentUniformData")
	push_fragment_uniform_data :: proc(command_buffer: ^Command_Buffer, slot_index: u32, data: rawptr, length: u32) ---
	@(link_name = "SDL_PushGPUComputeUniformData")
	push_compute_uniform_data :: proc(command_buffer: ^Command_Buffer, slot_index: u32, data: rawptr, length: u32) ---
	@(link_name = "SDL_BeginGPURenderPass")
	begin_render_pass :: proc(command_buffer: ^Command_Buffer, color_target_infos: [^]Color_Target_Info, num_color_targets: u32, depth_stencil_target_info: Maybe(^Depth_Stencil_Target_Info)) -> ^Render_Pass ---
	@(link_name = "SDL_BindGPUGraphicsPipeline")
	bind_graphics_pipeline :: proc(render_pass: ^Render_Pass, graphics_pipeline: ^Graphics_Pipeline) ---
	@(link_name = "SDL_SetGPUViewport")
	set_viewport :: proc(render_pass: ^Render_Pass, #by_ptr viewport: Viewport) ---
	@(link_name = "SDL_SetGPUScissor")
	set_scissor :: proc(render_pass: ^Render_Pass, #by_ptr scissor: Rect) ---
	@(link_name = "SDL_SetGPUBlendConstants")
	set_blend_constants :: proc(render_pass: ^Render_Pass, blend_constants: FColor) ---
	@(link_name = "SDL_SetGPUStencilReference")
	set_stencil_reference :: proc(render_pass: ^Render_Pass, reference: u8) ---
	@(link_name = "SDL_BindGPUVertexBuffers")
	bind_vertex_buffers :: proc(render_pass: ^Render_Pass, first_slot: u32, bindings: [^]Buffer_Binding, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUIndexBuffer")
	bind_index_buffer :: proc(render_pass: ^Render_Pass, #by_ptr binding: Buffer_Binding, index_element_size: Index_Element_Size) ---
	@(link_name = "SDL_BindGPUVertexSamplers")
	bind_vertex_samplers :: proc(render_pass: ^Render_Pass, first_slot: u32, texture_sampler_bindings: [^]Texture_Sampler_Binding, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUVertexStorageTextures")
	bind_vertex_storage_textures :: proc(render_pass: ^Render_Pass, first_slot: u32, storage_textures: [^]^Texture, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUVertexStorageBuffers")
	bind_vertex_storage_buffers :: proc(render_pass: ^Render_Pass, first_slot: u32, storage_buffers: [^]^Buffer, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUFragmentSamplers")
	bind_fragment_samplers :: proc(render_pass: ^Render_Pass, first_slot: u32, texture_sampler_bindings: [^]Texture_Sampler_Binding, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUFragmentStorageTextures")
	bind_fragment_storage_textures :: proc(render_pass: ^Render_Pass, first_slot: u32, storage_textures: [^]^Texture, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUFragmentStorageBuffers")
	bind_fragment_storage_buffers :: proc(render_pass: ^Render_Pass, first_slot: u32, storage_buffers: [^]^Buffer, num_bindings: u32) ---
	@(link_name = "SDL_DrawGPUIndexedPrimitives")
	draw_indexed_primitives :: proc(render_pass: ^Render_Pass, num_indices: u32, num_instances: u32, first_index: u32, vertex_offset: Sint32, first_instance: u32) ---
	@(link_name = "SDL_DrawGPUPrimitives")
	draw_primitives :: proc(render_pass: ^Render_Pass, num_vertices: u32, num_instances: u32, first_vertex: u32, first_instance: u32) ---
	@(link_name = "SDL_DrawGPUPrimitivesIndirect")
	draw_primitives_indirect :: proc(render_pass: ^Render_Pass, buffer: ^Buffer, offset: u32, draw_count: u32) ---
	@(link_name = "SDL_DrawGPUIndexedPrimitivesIndirect")
	draw_indexed_primitives_indirect :: proc(render_pass: ^Render_Pass, buffer: ^Buffer, offset: u32, draw_count: u32) ---
	@(link_name = "SDL_EndGPURenderPass")
	end_render_pass :: proc(render_pass: ^Render_Pass) ---
	@(link_name = "SDL_BeginGPUComputePass")
	begin_compute_pass :: proc(command_buffer: ^Command_Buffer, storage_texture_bindings: [^]Storage_Texture_Read_Write_Binding, num_storage_texture_bindings: u32, storage_buffer_bindings: [^]Storage_Buffer_Read_Write_Binding, num_storage_buffer_bindings: u32) -> ^Compute_Pass ---
	@(link_name = "SDL_BindGPUComputePipeline")
	bind_compute_pipeline :: proc(compute_pass: ^Compute_Pass, compute_pipeline: ^Compute_Pipeline) ---
	@(link_name = "SDL_BindGPUComputeSamplers")
	bind_compute_samplers :: proc(compute_pass: ^Compute_Pass, first_slot: u32, texture_sampler_bindings: [^]Texture_Sampler_Binding, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUComputeStorageTextures")
	bind_compute_storage_textures :: proc(compute_pass: ^Compute_Pass, first_slot: u32, storage_textures: [^]^Texture, num_bindings: u32) ---
	@(link_name = "SDL_BindGPUComputeStorageBuffers")
	bind_compute_storage_buffers :: proc(compute_pass: ^Compute_Pass, first_slot: u32, storage_buffers: [^]^Buffer, num_bindings: u32) ---
	@(link_name = "SDL_DispatchGPUCompute")
	dispatch_compute :: proc(compute_pass: ^Compute_Pass, groupcount_x, groupcount_y, groupcount_z: u32) ---
	@(link_name = "SDL_DispatchGPUComputeIndirect")
	dispatch_compute_indirect :: proc(compute_pass: ^Compute_Pass, buffer: ^Buffer, offset: u32) ---
	@(link_name = "SDL_EndGPUComputePass")
	end_compute_pass :: proc(compute_pass: ^Compute_Pass) ---
	@(link_name = "SDL_MapGPUTransferBuffer")
	map_transfer_buffer :: proc(device: ^Device, transfer_buffer: ^Transfer_Buffer, cycle: bool) -> rawptr ---
	@(link_name = "SDL_UnmapGPUTransferBuffer")
	unmap_transfer_buffer :: proc(device: ^Device, transfer_buffer: ^Transfer_Buffer) ---
	@(link_name = "SDL_BeginGPUCopyPass")
	begin_copy_pass :: proc(command_buffer: ^Command_Buffer) -> ^Copy_Pass ---
	@(link_name = "SDL_UploadToGPUTexture")
	upload_to_texture :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Texture_Transfer_Info, #by_ptr destination: Texture_Region, cycle: bool) ---
	@(link_name = "SDL_UploadToGPUBuffer")
	upload_to_buffer :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Transfer_Buffer_Location, #by_ptr destination: Buffer_Region, cycle: bool) ---
	@(link_name = "SDL_CopyGPUTextureToTexture")
	copy_texture_to_texture :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Texture_Location, #by_ptr destination: Texture_Location, w, h, d: u32, cycle: bool) ---
	@(link_name = "SDL_CopyGPUBufferToBuffer")
	copy_buffer_to_buffer :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Buffer_Location, #by_ptr destination: Buffer_Location, size: u32, cycle: bool) ---
	@(link_name = "SDL_DownloadFromGPUTexture")
	download_from_texture :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Texture_Region, #by_ptr destination: Texture_Transfer_Info) ---
	@(link_name = "SDL_DownloadFromGPUBuffer")
	download_from_buffer :: proc(copy_pass: ^Copy_Pass, #by_ptr source: Buffer_Region, #by_ptr destination: Transfer_Buffer_Location) ---
	@(link_name = "SDL_EndGPUCopyPass")
	end_copy_pass :: proc(copy_pass: ^Copy_Pass) ---
	@(link_name = "SDL_GenerateMipmapsForGPUTexture")
	generate_mipmaps_for_texture :: proc(command_buffer: ^Command_Buffer, texture: ^Texture) ---
	@(link_name = "SDL_BlitGPUTexture")
	blit_texture :: proc(command_buffer: ^Command_Buffer, #by_ptr info: Blit_Info) ---
	@(link_name = "SDL_WindowSupportsGPUSwapchainComposition")
	window_supports_swapchain_composition :: proc(device: ^Device, window: ^Window, swapchain_composition: Swapchain_Composition) -> bool ---
	@(link_name = "SDL_WindowSupportsGPUPresentMode")
	window_supports_present_mode :: proc(device: ^Device, window: ^Window, present_mode: Present_Mode) -> bool ---
	@(link_name = "SDL_ClaimWindowForGPUDevice")
	claim_window_for_device :: proc(device: ^Device, window: ^Window) -> bool ---
	@(link_name = "SDL_ReleaseWindowFromGPUDevice")
	release_window_from_device :: proc(device: ^Device, window: ^Window) ---
	@(link_name = "SDL_SetGPUSwapchainParameters")
	set_swapchain_parameters :: proc(device: ^Device, window: ^Window, swapchain_composition: Swapchain_Composition, present_mode: Present_Mode) -> bool ---
	@(link_name = "SDL_SetGPUAllowedFramesInFlight")
	set_allowed_frames_in_flight :: proc(device: ^Device, allowed_frames_in_flight: u32) -> bool ---
	@(link_name = "SDL_GetGPUSwapchainTextureFormat")
	get_swapchain_texture_format :: proc(device: ^Device, window: ^Window) -> Texture_Format ---
	@(link_name = "SDL_AcquireGPUSwapchainTexture")
	acquire_swapchain_texture :: proc(command_buffer: ^Command_Buffer, window: ^Window, swapchain_texture: ^^Texture, swapchain_texture_width, swapchain_texture_height: ^u32) -> bool ---
	@(link_name = "SDL_WaitForGPUSwapchain")
	wait_for_swapchain :: proc(device: ^Device, window: ^Window) -> bool ---
	@(link_name = "SDL_WaitAndAcquireGPUSwapchainTexture")
	wait_and_acquire_swapchain_texture :: proc(command_buffer: ^Command_Buffer, window: ^Window, swapchain_texture: ^^Texture, swapchain_texture_width, swapchain_texture_height: ^u32) -> bool ---
	@(link_name = "SDL_SubmitGPUCommandBuffer")
	submit_command_buffer :: proc(command_buffer: ^Command_Buffer) -> bool ---
	@(link_name = "SDL_SubmitGPUCommandBufferAndAcquireFence")
	submit_command_buffer_and_acquire_fence :: proc(command_buffer: ^Command_Buffer) -> ^Fence ---
	@(link_name = "SDL_CancelGPUCommandBuffer")
	cancel_command_buffer :: proc(command_buffer: ^Command_Buffer) -> bool ---
	@(link_name = "SDL_WaitForGPUIdle")
	wait_for_idle :: proc(device: ^Device) -> bool ---
	@(link_name = "SDL_WaitForGPUFences")
	wait_for_fences :: proc(device: ^Device, wait_all: bool, fences: [^]^Fence, num_fences: u32) -> bool ---
	@(link_name = "SDL_QueryGPUFence")
	query_fence :: proc(device: ^Device, fence: ^Fence) -> bool ---
	@(link_name = "SDL_ReleaseGPUFence")
	release_fence :: proc(device: ^Device, fence: ^Fence) ---
	@(link_name = "SDL_GPUTextureFormatTexelBlockSize")
	texture_format_texel_block_size :: proc(format: Texture_Format) -> u32 ---
	@(link_name = "SDL_GPUTextureSupportsFormat")
	texture_supports_format :: proc(device: ^Device, format: Texture_Format, type: Texture_Type, usage: Texture_Usage_Flags) -> bool ---
	@(link_name = "SDL_GPUTextureSupportsSampleCount")
	texture_supports_sample_count :: proc(device: ^Device, format: Texture_Format, sample_count: Sample_Count) -> bool ---
	@(link_name = "SDL_CalculateGPUTextureFormatSize")
	calculate_texture_format_size :: proc(format: Texture_Format, width, height: u32, depth_or_layer_count: u32) -> u32 ---
}


// GDK
@(default_calling_convention = "c", link_prefix = "SDL_")
foreign lib {
	GDKSuspendGPU :: proc(device: ^Device) ---
	GDKResumeGPU :: proc(device: ^Device) ---
}
