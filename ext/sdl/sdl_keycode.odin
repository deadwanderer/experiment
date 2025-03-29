package sdl

Keycode :: distinct u32

Keymod :: distinct bit_set[Keymod_Flag;u16]
Keymod_Flag :: enum u16 {
	LShift = 0, /**< the left Shift key is down. */
	RShift = 1, /**< the right Shift key is down. */
	Level5 = 2, /**< the Level 5 Shift key is down. */
	LCtrl  = 6, /**< the left Ctrl (Control) key is down. */
	RCtrl  = 7, /**< the right Ctrl (Control) key is down. */
	LAlt   = 8, /**< the left Alt key is down. */
	RAlt   = 9, /**< the right Alt key is down. */
	LGui   = 10, /**< the left GUI key (often the Windows key) is down. */
	RGui   = 11, /**< the right GUI key (often the Windows key) is down. */
	Num    = 12, /**< the Num Lock key (may be located on an extended keypad) is down. */
	Caps   = 13, /**< the Caps Lock key is down. */
	Mode   = 14, /**< the !AltGr key is down. */
	Scroll = 15, /**< the Scroll Lock key is down. */
}

Mod_Ctrl :: Keymod{.LCtrl, .RCtrl}