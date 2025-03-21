package main

import imgui "../ext/imgui"
import imsdl "../ext/imgui/imgui_impl_sdl3"
import imgpu "../ext/imgui/imgui_impl_sdl3gpu"
import "ext:sdl"

Debug_State :: struct {
	is_minimized: bool,
}
DEBUG_STATE: Debug_State = {}

debug_init :: proc() {
	imgui.CreateContext()
	fnt := imgui.GetIO().Fonts
	imgui.FontAtlas_AddFontFromFileTTF(fnt, "fonts/RobotoMedium.ttf", 14)

	imsdl.InitForSDLGPU(APP.window)
	imgpu.Init(
		{
			Device = APP.gpu,
			ColorTargetFormat = sdl.get_swapchain_texture_format(APP.gpu, APP.window),
			MSAASamples = ._1,
		},
	)
}

debug_handle_event :: proc(e: ^sdl.Event) {
	imsdl.ProcessEvent(e)
}

debug_begin_frame :: proc() {
	imgpu.NewFrame()
	imsdl.NewFrame()
	imgui.NewFrame()

	imgui.ShowMetricsWindow()
	imgui.Render()

	draw_data := imgui.GetDrawData()
	DEBUG_STATE.is_minimized = draw_data.DisplaySize.x <= 0 || draw_data.DisplaySize.y <= 0
}

debug_draw :: proc(cmdbuf: ^sdl.Command_Buffer, render_pass: ^sdl.Render_Pass) {
	if !DEBUG_STATE.is_minimized {
		imgpu.PrepareDrawData(imgui.GetDrawData(), cmdbuf)
	}
	imgpu.RenderDrawData(imgui.GetDrawData(), cmdbuf, render_pass)
}

debug_shutdown :: proc() {

	imgpu.Shutdown()
	imsdl.Shutdown()
	imgui.DestroyContext()
}
