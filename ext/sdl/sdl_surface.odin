package sdl

import "core:c"

Flip_Mode :: enum c.int {
	None, /**< Do not flip */
	Horizontal, /**< flip horizontally */
	Vertical, /**< flip vertically */
}
