package main

import "core:mem"
import "core:strings"
import "ext:sdl"
import stbi "vendor:stb/image"

load_shader :: proc(
	device: ^sdl.Device,
	shd: Shader_Data,
	num_samplers: int,
	num_uniform_buffers: int,
	num_storage_buffers: int,
	num_storage_textures: int,
) -> ^sdl.Shader {

	stage: sdl.Shader_Stage = .Vertex
	if shd.type == .Fragment {
		stage = .Fragment
	}
	if shd.type == .Compute do panic("make_shader doesn't handle compute shaders")

	backend_formats := sdl.get_shader_formats(device)

	format: sdl.Shader_Format = {}
	shd_data: []u8 = nil
	if .SPIRV in backend_formats {
		format = {.SPIRV}
		shd_data = shd.spv
	} else if .DXIL in backend_formats {
		format = {.DXIL}
		shd_data = shd.dxil
	} else {
		assert(false, "Unsupported shader format")
	}

	res := sdl.create_shader(
		device,
		sdl.Shader_Create_Info {
			code = raw_data(shd_data),
			code_size = uint(len(shd_data)),
			entrypoint = "main",
			format = format,
			stage = stage,
			num_samplers = u32(num_samplers),
			num_uniform_buffers = u32(num_uniform_buffers),
			num_storage_buffers = u32(num_storage_buffers),
			num_storage_textures = u32(num_storage_textures),
		},
	)
	if res == nil {
		panic("Failed to create shader")
	}
	return res
}

load_array_texture :: proc(device: ^sdl.Device, texture_names: []string) -> ^sdl.Texture {
	pixel_pointers := make([][^]byte, len(texture_names))
	width: i32 = 0
	height: i32 = 0
	for tex, idx in texture_names {
		full_path := strings.concatenate({"textures/", tex}, allocator = context.temp_allocator)

		w, h, c: i32
		pixel_pointers[idx] = stbi.load(strings.unsafe_string_to_cstring(full_path), &w, &h, &c, 4)
		assert(pixel_pointers[idx] != nil, "Failed to load texture!")
		if width == 0 {
			width = w
		} else {
			assert(w == width, "Texture array widths don't match")
		}
		if height == 0 {
			height = h
		} else {
			assert(h == height, "Texture array heights don't match")
		}
	}

	tex_handle := sdl.create_texture(
		device,
		sdl.Texture_Create_Info {
			type = .D2_Array,
			format = .R8G8B8A8_UNorm,
			usage = {.Sampler, .Color_Target},
			width = u32(width),
			height = u32(height),
			layer_count_or_depth = u32(len(texture_names)),
			num_levels = 1,
		},
	)

	image_byte_size := int(width * height * 4)

	transfer := sdl.create_transfer_buffer(
		device,
		{usage = .Upload, size = u32(image_byte_size * len(texture_names))},
	)

	transfer_ptr := cast([^]u8)sdl.map_transfer_buffer(device, transfer, false)
	offset := 0
	for i in 0 ..< len(texture_names) {
		mem.copy(transfer_ptr[offset:], pixel_pointers[i], image_byte_size)
		offset += image_byte_size
	}
	sdl.unmap_transfer_buffer(device, transfer)

	cmdbuf := sdl.acquire_command_buffer(device)
	copy_pass := sdl.begin_copy_pass(cmdbuf)
	for i in 0 ..< len(texture_names) {
		sdl.upload_to_texture(
			copy_pass,
			sdl.Texture_Transfer_Info {
				transfer_buffer = transfer,
				offset = u32(i * image_byte_size),
			},
			sdl.Texture_Region {
				texture = tex_handle,
				layer = u32(i),
				w = u32(width),
				h = u32(height),
				d = 1,
			},
			false,
		)
	}
	sdl.end_copy_pass(copy_pass)
	sdl.submit_command_buffer(cmdbuf)
	sdl.release_transfer_buffer(device, transfer)

	for i in 0 ..< len(texture_names) {
		stbi.image_free(pixel_pointers[i])
	}
	return tex_handle
}
