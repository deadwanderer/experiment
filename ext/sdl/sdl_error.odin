package sdl

@(default_calling_convention = "c")
foreign lib {
	@(require_results)
	@(link_name = "SDL_GetError")get_error :: proc() -> cstring ---
}
