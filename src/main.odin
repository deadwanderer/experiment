package main

import "core:fmt"
import sdl "ext:sdl"

main :: proc() {
	fmt.println("Experiment time!")
	if (!sdl.init({.Video})) {
		fmt.eprintln("Failed to init SDL!")
		return
	}

	device := sdl.create_device({.SPIRV}, true, nil)
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

	running := true
	for running {
		ev: sdl.Event
		for sdl.poll_event(&ev) {
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

		cmdbuf := sdl.acquire_command_buffer(device)
		if cmdbuf != nil {
			swap_tex: ^sdl.Texture
			if sdl.wait_and_acquire_swapchain_texture(cmdbuf, window, &swap_tex, nil, nil) {
				render_pass := sdl.begin_render_pass(
					cmdbuf,
					&sdl.Color_Target_Info {
						texture = swap_tex,
						load_op = .CLEAR,
						store_op = .STORE,
						clear_color = {0.3, 0.4, 0.5, 1},
					},
					1,
					nil,
				)
				sdl.end_render_pass(render_pass)
			} else {
				fmt.eprintln("Failed to acquire swapchain texture")
			}
		} else {
			fmt.eprintln("Failed to acquire command buffer")
		}
		success = sdl.submit_command_buffer(cmdbuf)
	}

	sdl.release_window_from_device(device, window)
	sdl.destroy_window(window)
	sdl.destroy_device(device)
	sdl.quit()
}
