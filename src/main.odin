package main

// import "base:runtime"
// import "core:fmt"
// import sdl "ext:sdl"

Application :: struct {
	using platform: Platform,
	using renderer: Renderer,
	input:Input_System,
}

APP: ^Application = nil

main :: proc() {
	APP = new(Application)

	assert(platform_init())
	platform_create_window("Experiment", 1600, 900)

	assert(renderer_init())

	debug_init()
	input_init(&APP.input)

	for !APP.quit_requested {
		input_update(&APP.input)

		renderer_begin_frame()
		renderer_draw()
		free_all(context.temp_allocator)
	}

	debug_shutdown()
	renderer_shutdown()
	platform_shutdown()
}
