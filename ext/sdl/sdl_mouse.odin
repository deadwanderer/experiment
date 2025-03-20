package sdl

import "core:c"

Mouse_ID :: distinct u32

Mouse_Wheel_Direction :: enum c.int {
	Normal, /**< The scroll direction is normal */
	Flipped, /**< The scroll direction is flipped / natural */
}

Mouse_Button_Flags :: distinct bit_set[Mouse_Button_Flag;u32]
Mouse_Button_Flag :: enum u32 {
	Left   = 1 - 1,
	Middle = 2 - 1,
	Right  = 3 - 1,
	X1     = 4 - 1,
	X2     = 5 - 1,
}
