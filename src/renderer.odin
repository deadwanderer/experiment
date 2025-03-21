package main

import "core:log"
import "ext:sdl"

Position_Texture_Vertex :: struct {
	x, y, z: f32,
	u, v:    f32,
}


Renderer :: struct {
	gpu:           ^sdl.Device,
	pipeline:      ^sdl.Graphics_Pipeline,
	vertex_buffer: ^sdl.Buffer,
	index_buffer:  ^sdl.Buffer,
	texture:       ^sdl.Texture,
	sampler:       ^sdl.Sampler,
}

renderer_init :: proc() -> bool {
	APP.gpu = sdl.create_device({.SPIRV}, true)
	if APP.gpu == nil {
		log.errorf("Failed to create GPU device: %v", sdl.get_error())
		return false
	}
	success := sdl.claim_window_for_device(APP.gpu, APP.window)
	if !success {
		log.errorf("Failed to claim window for GPU device: %v", sdl.get_error())
		return false
	}

	vertex_shader := load_shader(APP.gpu, textured_quad_vert, 0, 0, 0, 0)
	if vertex_shader == nil {
		log.errorf("Failed to create vertex shader: %v", sdl.get_error())
		return false
	}
	fragment_shader := load_shader(APP.gpu, textured_quad_array_frag, 1, 0, 0, 0)
	if fragment_shader == nil {
		log.errorf("Failed to create fragment shader: %v", sdl.get_error())
		return false
	}

	pipeline_create_info := sdl.Graphics_Pipeline_Create_Info {
		target_info = {
			num_color_targets = 1,
			color_target_descriptions = &sdl.Color_Target_Description {
				format = sdl.get_swapchain_texture_format(APP.gpu, APP.window),
			},
		},
		vertex_input_state = {
			num_vertex_buffers = 1,
			vertex_buffer_descriptions = &sdl.Vertex_Buffer_Description {
				slot = 0,
				input_rate = .Vertex,
				instance_step_rate = 0,
				pitch = size_of(Position_Texture_Vertex),
			},
			num_vertex_attributes = 2,
			vertex_attributes = raw_data(
				[]sdl.Vertex_Attribute {
					{buffer_slot = 0, format = .Float3, location = 0, offset = 0},
					{buffer_slot = 0, format = .Float2, location = 1, offset = size_of(f32) * 3},
				},
			),
		},
		primitive_type = .Triangle_List,
		vertex_shader = vertex_shader,
		fragment_shader = fragment_shader,
	}

	APP.renderer.pipeline = sdl.create_graphics_pipeline(APP.gpu, pipeline_create_info)
	if APP.renderer.pipeline == nil {
		log.errorf("Failed to create pipeline: %v", sdl.get_error())
		return false
	}

	sdl.release_shader(APP.gpu, vertex_shader)
	sdl.release_shader(APP.gpu, fragment_shader)

	APP.renderer.texture = load_array_texture(APP.gpu, {"Dirt.png", "Grass.png", "Ground.png"})

	APP.renderer.vertex_buffer = sdl.create_buffer(
		APP.gpu,
		{usage = {.Vertex}, size = size_of(Position_Texture_Vertex) * 4},
	)

	APP.renderer.index_buffer = sdl.create_buffer(
		APP.gpu,
		{usage = {.Index}, size = size_of(u16) * 6},
	)

	APP.renderer.sampler = sdl.create_sampler(
		APP.gpu,
		{
			min_filter = .Linear,
			mag_filter = .Linear,
			mipmap_mode = .Linear,
			address_mode_u = .Clamp_To_Edge,
			address_mode_v = .Clamp_To_Edge,
			address_mode_w = .Clamp_To_Edge,
		},
	)

	buf_transfer := sdl.create_transfer_buffer(
		APP.gpu,
		{usage = .Upload, size = (size_of(Position_Texture_Vertex) * 4) + (size_of(u16) * 6)},
	)

	transfer_data := cast([^]Position_Texture_Vertex)sdl.map_transfer_buffer(
		APP.gpu,
		buf_transfer,
		false,
	)
	transfer_data[0] = {-1, 1, 0, 0, 0}
	transfer_data[1] = {1, 1, 0, 1, 0}
	transfer_data[2] = {1, -1, 0, 1, 1}
	transfer_data[3] = {-1, -1, 0, 0, 1}

	index_data := cast([^]u16)transfer_data[4:]
	index_data[0] = 0
	index_data[1] = 1
	index_data[2] = 2
	index_data[3] = 0
	index_data[4] = 2
	index_data[5] = 3

	sdl.unmap_transfer_buffer(APP.gpu, buf_transfer)

	upload_cmd := sdl.acquire_command_buffer(APP.gpu)
	copy_pass := sdl.begin_copy_pass(upload_cmd)
	sdl.upload_to_buffer(
		copy_pass,
		{transfer_buffer = buf_transfer, offset = 0},
		{
			buffer = APP.renderer.vertex_buffer,
			offset = 0,
			size = size_of(Position_Texture_Vertex) * 4,
		},
		false,
	)
	sdl.upload_to_buffer(
		copy_pass,
		{transfer_buffer = buf_transfer, offset = size_of(Position_Texture_Vertex) * 4},
		{buffer = APP.renderer.index_buffer, offset = 0, size = size_of(u16) * 6},
		false,
	)
	sdl.end_copy_pass(copy_pass)
	sdl.submit_command_buffer(upload_cmd)
	sdl.release_transfer_buffer(APP.gpu, buf_transfer)


	return true
}

renderer_begin_frame :: proc() {

}

renderer_draw :: proc() {

	cmdbuf := sdl.acquire_command_buffer(APP.renderer.gpu)
	if cmdbuf != nil {
		swap_tex: ^sdl.Texture
		if sdl.wait_and_acquire_swapchain_texture(
			cmdbuf,
			APP.platform.window,
			&swap_tex,
			nil,
			nil,
		) {
			render_pass := sdl.begin_render_pass(
				cmdbuf,
				&sdl.Color_Target_Info {
					texture = swap_tex,
					load_op = .Clear,
					store_op = .Store,
					clear_color = {0.3, 0.4, 0.5, 1},
				},
				1,
				nil,
			)

			sdl.bind_graphics_pipeline(render_pass, APP.renderer.pipeline)
			sdl.bind_vertex_buffers(
				render_pass,
				0,
				&sdl.Buffer_Binding{buffer = APP.renderer.vertex_buffer, offset = 0},
				1,
			)
			sdl.bind_index_buffer(
				render_pass,
				{buffer = APP.renderer.index_buffer, offset = 0},
				.Sixteen,
			)
			sdl.bind_fragment_samplers(
				render_pass,
				0,
				&sdl.Texture_Sampler_Binding {
					texture = APP.renderer.texture,
					sampler = APP.renderer.sampler,
				},
				1,
			)
			sdl.draw_indexed_primitives(render_pass, 6, 1, 0, 0, 0)

			sdl.end_render_pass(render_pass)
		} else {
			log.errorf("Failed to acquire swapchain texture: %v", sdl.get_error())
		}
	} else {
		log.errorf("Failed to acquire command buffer: %v", sdl.get_error())
	}
	sdl.submit_command_buffer(cmdbuf)
}

renderer_shutdown :: proc() {
	sdl.release_buffer(APP.gpu, APP.renderer.vertex_buffer)
	sdl.release_buffer(APP.gpu, APP.renderer.index_buffer)
	sdl.release_sampler(APP.gpu, APP.renderer.sampler)
	sdl.release_texture(APP.gpu, APP.renderer.texture)
	sdl.release_graphics_pipeline(APP.gpu, APP.renderer.pipeline)
	sdl.release_window_from_device(APP.renderer.gpu, APP.platform.window)
	sdl.destroy_device(APP.renderer.gpu)
}
