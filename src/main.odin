package main

import imgui "../ext/imgui"
import imsdl "../ext/imgui/imgui_impl_sdl3"
import imgpu "../ext/imgui/imgui_impl_sdl3gpu"
import "base:runtime"
import "core:fmt"
import sdl "ext:sdl"

pipeline: ^sdl.Graphics_Pipeline
vertex_buffer: ^sdl.Buffer
index_buffer: ^sdl.Buffer
texture: ^sdl.Texture
sampler: ^sdl.Sampler

Position_Texture_Vertex :: struct {
	x, y, z: f32,
	u, v:    f32,
}

main :: proc() {
	sdl.set_log_priorities(.Verbose)
	sdl.set_log_output_function(
		proc "c" (
			userdata: rawptr,
			category: sdl.Log_Category,
			priority: sdl.Log_Priority,
			message: cstring,
		) {
			context = runtime.default_context()
			fmt.printfln("SDL {} [{}]: {}", category, priority, message)
		},
		nil,
	)

	if (!sdl.init({.Video})) {
		fmt.eprintln("Failed to init SDL!")
		return
	}

	device := sdl.create_device({.SPIRV}, true)
	if device == nil {
		fmt.eprintln("Failed to create GPU device")
		return
	}

	window := sdl.create_window("Test", 1280, 720, {.Resizable})

	success := sdl.claim_window_for_device(device, window)
	if !success {
		fmt.eprintln("Failed to claim window for GPU device")
		return
	}

	imgui.CreateContext()
	fnt := imgui.GetIO().Fonts
	imgui.FontAtlas_AddFontFromFileTTF(fnt, "fonts/RobotoMedium.ttf", 14)

	imsdl.InitForSDLGPU(window)
	imgpu.Init(
		{
			Device = device,
			ColorTargetFormat = sdl.get_swapchain_texture_format(device, window),
			MSAASamples = ._1,
		},
	)

	vertex_shader := load_shader(device, textured_quad_vert, 0, 0, 0, 0)
	if vertex_shader == nil {
		sdl.log("Failed to create vertex shader!")
		return
	}
	fragment_shader := load_shader(device, textured_quad_array_frag, 1, 0, 0, 0)
	if fragment_shader == nil {
		sdl.log("Failed to create fragment shader!")
		return
	}

	pipeline_create_info := sdl.Graphics_Pipeline_Create_Info {
		target_info = {
			num_color_targets = 1,
			color_target_descriptions = &sdl.Color_Target_Description {
				format = sdl.get_swapchain_texture_format(device, window),
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

	pipeline = sdl.create_graphics_pipeline(device, pipeline_create_info)
	if pipeline == nil {
		sdl.log("Failed to create pipeline!")
		return
	}

	sdl.release_shader(device, vertex_shader)
	sdl.release_shader(device, fragment_shader)

	texture = load_array_texture(device, {"Dirt.png", "Grass.png", "Ground.png"})

	vertex_buffer = sdl.create_buffer(
		device,
		{usage = {.Vertex}, size = size_of(Position_Texture_Vertex) * 4},
	)

	index_buffer = sdl.create_buffer(device, {usage = {.Index}, size = size_of(u16) * 6})

	sampler = sdl.create_sampler(
		device,
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
		device,
		{usage = .Upload, size = (size_of(Position_Texture_Vertex) * 4) + (size_of(u16) * 6)},
	)

	transfer_data := cast([^]Position_Texture_Vertex)sdl.map_transfer_buffer(
		device,
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

	sdl.unmap_transfer_buffer(device, buf_transfer)

	upload_cmd := sdl.acquire_command_buffer(device)
	copy_pass := sdl.begin_copy_pass(upload_cmd)
	sdl.upload_to_buffer(
		copy_pass,
		{transfer_buffer = buf_transfer, offset = 0},
		{buffer = vertex_buffer, offset = 0, size = size_of(Position_Texture_Vertex) * 4},
		false,
	)
	sdl.upload_to_buffer(
		copy_pass,
		{transfer_buffer = buf_transfer, offset = size_of(Position_Texture_Vertex) * 4},
		{buffer = index_buffer, offset = 0, size = size_of(u16) * 6},
		false,
	)
	sdl.end_copy_pass(copy_pass)
	sdl.submit_command_buffer(upload_cmd)
	sdl.release_transfer_buffer(device, buf_transfer)

	running := true
	for running {
		ev: sdl.Event
		for sdl.poll_event(&ev) {
			imsdl.ProcessEvent(&ev)
			#partial switch ev.type {
			case .Quit:
				{
					running = false
				}
			case .Key_Down:
				{
					#partial switch ev.key.scancode {
					case .Escape:
						{
							running = false
						}
					}
				}
			}
		}

		imgpu.NewFrame()
		imsdl.NewFrame()
		imgui.NewFrame()

		imgui.ShowMetricsWindow()
		imgui.Render()

		draw_data := imgui.GetDrawData()
		is_minimized := draw_data.DisplaySize.x <= 0 || draw_data.DisplaySize.y <= 0

		cmdbuf := sdl.acquire_command_buffer(device)
		if cmdbuf != nil {
			swap_tex: ^sdl.Texture
			if sdl.wait_and_acquire_swapchain_texture(cmdbuf, window, &swap_tex, nil, nil) {
				if !is_minimized {
					imgpu.PrepareDrawData(draw_data, cmdbuf)
				}
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

				sdl.bind_graphics_pipeline(render_pass, pipeline)
				sdl.bind_vertex_buffers(
					render_pass,
					0,
					&sdl.Buffer_Binding{buffer = vertex_buffer, offset = 0},
					1,
				)
				sdl.bind_index_buffer(render_pass, {buffer = index_buffer, offset = 0}, .Sixteen)
				sdl.bind_fragment_samplers(
					render_pass,
					0,
					&sdl.Texture_Sampler_Binding{texture = texture, sampler = sampler},
					1,
				)
				sdl.draw_indexed_primitives(render_pass, 6, 1, 0, 0, 0)
				if !is_minimized {
					imgpu.RenderDrawData(imgui.GetDrawData(), cmdbuf, render_pass)
				}
				sdl.end_render_pass(render_pass)
			} else {
				fmt.eprintln("Failed to acquire swapchain texture")
			}
		} else {
			fmt.eprintln("Failed to acquire command buffer")
		}
		success = sdl.submit_command_buffer(cmdbuf)
		free_all(context.temp_allocator)
	}
	
	imgpu.Shutdown()
	imsdl.Shutdown()
	imgui.DestroyContext()
	sdl.release_buffer(device, vertex_buffer)
	sdl.release_buffer(device, index_buffer)
	sdl.release_sampler(device, sampler)
	sdl.release_texture(device, texture)
	sdl.release_graphics_pipeline(device, pipeline)
	sdl.release_window_from_device(device, window)
	sdl.destroy_window(window)
	sdl.destroy_device(device)
	sdl.quit()
}
