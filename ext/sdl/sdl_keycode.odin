package sdl

Keycode :: distinct u32

Keymod :: distinct bit_set[KeymodFlag;u16]
KeymodFlag :: enum u16 {
	LSHIFT = 0, /**< the left Shift key is down. */
	RSHIFT = 1, /**< the right Shift key is down. */
	LEVEL5 = 2, /**< the Level 5 Shift key is down. */
	LCTRL  = 6, /**< the left Ctrl (Control) key is down. */
	RCTRL  = 7, /**< the right Ctrl (Control) key is down. */
	LALT   = 8, /**< the left Alt key is down. */
	RALT   = 9, /**< the right Alt key is down. */
	LGUI   = 10, /**< the left GUI key (often the Windows key) is down. */
	RGUI   = 11, /**< the right GUI key (often the Windows key) is down. */
	NUM    = 12, /**< the Num Lock key (may be located on an extended keypad) is down. */
	CAPS   = 13, /**< the Caps Lock key is down. */
	MODE   = 14, /**< the !AltGr key is down. */
	SCROLL = 15, /**< the Scroll Lock key is down. */
}
