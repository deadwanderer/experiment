package main

import "base:runtime"
import "core:log"
import "core:strings"
import "ext:sdl"

DEFAULT_APP_WIDTH :: 1280
DEFAULT_APP_HEIGHT :: 720

Platform :: struct {
	window:         ^sdl.Window,
	dim:            Vec2i,
	quit_requested: bool,
}

platform_init :: proc() -> bool {
	APP.quit_requested = false
	sdl.set_log_priorities(.Verbose)
	sdl.set_log_output_function(
		proc "c" (
			userdata: rawptr,
			category: sdl.Log_Category,
			priority: sdl.Log_Priority,
			message: cstring,
		) {
			context = runtime.default_context()
			log.debugf("SDL {} [{}]: {}", category, priority, message)
		},
		nil,
	)

	if (!sdl.init({.Video})) {
		log.errorf("Failed to init SDL: %v", sdl.get_error())
		return false
	}

	return true
}

platform_create_window :: proc(
	title: string,
	width: int = DEFAULT_APP_WIDTH,
	height: int = DEFAULT_APP_HEIGHT,
) {
	APP.platform.window = sdl.create_window(
		strings.unsafe_string_to_cstring(title),
		i32(width),
		i32(height),
		{.Resizable},
	)
	assert(APP.platform.window != nil, "Failed to create SDL window!")
	APP.platform.dim = {width, height}
}

platform_shutdown :: proc() {
	sdl.destroy_window(APP.platform.window)
	sdl.quit()
}
