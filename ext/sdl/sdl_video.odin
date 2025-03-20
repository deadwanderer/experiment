package sdl

import "core:c"

Display_ID :: distinct u32
Window_ID :: distinct u32

Window :: struct {}

Window_Flags :: distinct bit_set[Window_Flag;u64]
Window_Flag :: enum u64 {
	Fullscreen          = 0,
	OpenGL              = 1,
	Occluded            = 2,
	Hidden              = 3,
	Borderless          = 4,
	Resizable           = 5,
	Minimized           = 6,
	Maximized           = 7,
	Mouse_Grabbed       = 8,
	Input_Focus         = 9,
	Mouse_Focus         = 10,
	External            = 11,
	Modal               = 12,
	High_Pixel_Density  = 13,
	Mouse_Capture       = 14,
	Mouse_Relative_Mode = 15,
	Always_On_Top       = 16,
	Utility             = 17,
	Tooltip             = 18,
	Popup_Menu          = 19,
	Keyboard_Grabbed    = 20,
	Vulkan              = 28,
	Metal               = 29,
	Transparent         = 30,
	Not_Focusable       = 31,
}

@(default_calling_convention = "c")
foreign lib {
	@(link_name = "SDL_CreateWindow")
	create_window :: proc(title: cstring, w, h: c.int, flags: Window_Flags) -> ^Window ---
	@(link_name = "SDL_DestroyWindow")
	destroy_window :: proc(window: ^Window) ---
}
