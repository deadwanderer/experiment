package imgui_impl_sdlgpu3
import imgui "../"
import sdl "ext:sdl"

when      ODIN_OS == .Windows { foreign import lib "../imgui_windows_x64.lib" }
else when ODIN_OS == .Linux   { foreign import lib "../imgui_linux_x64.a" }
else when ODIN_OS == .Darwin  {
	when ODIN_ARCH == .amd64 { foreign import lib "../imgui_darwin_x64.a" } else { foreign import lib "../imgui_darwin_arm64.a" }
}

// imgui_impl_sdlgpu3.h
// Last checked `v1.91.8-docking` (11b3a7c)
InitInfo :: struct
{
    Device: ^sdl.Device,
    ColorTargetFormat: sdl.Texture_Format,
    MSAASamples: sdl.Sample_Count,
}

@(link_prefix="ImGui_ImplSDLGPU3_")
foreign lib {
	Init :: proc(#by_ptr info: InitInfo) -> bool ---
	Shutdown :: proc() ---
	NewFrame :: proc() ---
	RenderDrawData :: proc(draw_data: ^imgui.DrawData, command_buffer: ^sdl.Command_Buffer, render_pass: ^sdl.Render_Pass, pipeline: ^sdl.Graphics_Pipeline = nil) ---
	CreateDeviceObjects :: proc() ---
	DestroyDeviceObjects :: proc() ---
	CreateFontsTexture :: proc() ---
	DestroyFontsTexture :: proc() ---
}

@(link_prefix="Imgui_ImplSDLGPU3_") // typo in the original lib (note the small m)
foreign lib {
	PrepareDrawData :: proc(draw_data: ^imgui.DrawData, command_buffer: ^sdl.Command_Buffer) ---
}
