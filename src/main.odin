package main

// import "base:runtime"
// import "core:fmt"
import sdl "ext:sdl"

Application :: struct {
	using platform: Platform,
	using renderer: Renderer,
}

APP: ^Application = nil

main :: proc() {
	APP = new(Application)

	assert(platform_init())
	platform_create_window("Experiment", 1600, 900)

	assert(renderer_init())

	debug_init()

	running := true
	for running {
		ev: sdl.Event
		for sdl.poll_event(&ev) {
			debug_handle_event(&ev)
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

		debug_begin_frame()

		renderer_draw()
		free_all(context.temp_allocator)
	}

	debug_shutdown()
	renderer_shutdown()
	platform_shutdown()
}
