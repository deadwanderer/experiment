package sdl

// import "core:c"

Init_Flags :: distinct bit_set[Init_Flag;u32]
Init_Flag :: enum u32 {
	Audio    = 4, /**< `SDL_INIT_AUDIO` implies `SDL_INIT_EVENTS` */
	Video    = 5, /**< `SDL_INIT_VIDEO` implies `SDL_INIT_EVENTS`, should be initialized on the main thread */
	Joystick = 9, /**< `SDL_INIT_JOYSTICK` implies `SDL_INIT_EVENTS`, should be initialized on the same thread as SDL_INIT_VIDEO on Windows if you don't set SDL_HINT_JOYSTICK_THREAD */
	Haptic   = 12,
	Gamepad  = 13, /**< `SDL_INIT_GAMEPAD` implies `SDL_INIT_JOYSTICK` */
	Events   = 14,
	Sensor   = 15, /**< `SDL_INIT_SENSOR` implies `SDL_INIT_EVENTS` */
	Camera   = 16, /**< `SDL_INIT_CAMERA` implies `SDL_INIT_EVENTS` */
}

@(default_calling_convention = "c")
foreign lib {
	@(link_name = "SDL_Init")
	init :: proc(flags: Init_Flags) -> bool ---
	@(link_name = "SDL_Quit")
	quit :: proc() ---
}
