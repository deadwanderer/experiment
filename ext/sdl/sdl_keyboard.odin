package sdl

Keyboard_ID :: distinct u32

@(default_calling_convention = "c")
foreign lib {
	@(link_name = "SDL_GetModState")
	get_mod_state :: proc() -> Keymod ---

}
