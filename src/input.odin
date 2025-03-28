package main

import sdl "ext:sdl"

input_update :: proc() {
	ev: sdl.Event
	for sdl.poll_event(&ev) {
		debug_handle_event(&ev)
		#partial switch ev.type {
		case .Quit:
			{
				APP.quit_requested = true
			}
		case .Key_Down:
			{
				#partial switch ev.key.scancode {
				case .Escape:
					{
						APP.quit_requested = true
					}
				}
			}
		}
	}
}
