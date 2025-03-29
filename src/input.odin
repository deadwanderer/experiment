package main

import sdl "ext:sdl"

Input_System :: struct {
	action_set:           Input_Action_Set,
	input_cursor_pos:     Vec2,
	input_cursor_delta:   Vec2,
	scroll_delta:         f32,
	keys_down:            bit_set[Input_Key],
	last_source:          Input_Source_Kind,
	analog_action_states: [Input_Analog_Action]Vec2,
	key_states:           [Input_Key]Input_Digital,
	action_states:        [Input_Action]Input_Digital,
	characters:           Array(256, rune),
}

Input_Source_Kind :: enum u8 {
	Keyboard_Mouse,
	Controller,
}

Input_Icon_Style :: enum u8 {
	Default,
	Keyboard_Mouse,
	Generic_Controller,
	Xbox_Controller,
	Playstation_Controller,
}

Input_Digital_Flag :: enum u8 {
	Down,
	Changed_This_Frame,
	Multiple_Changes_This_Frame,
}

Input_Digital :: struct {
	flags: bit_set[Input_Digital_Flag],
}

Input_Action :: enum u8 {
	Menu_Up,
	Menu_Down,
	Menu_Left,
	Menu_Right,
	Menu_Select,
	Menu_Go_Back,
	Fire,
}

Input_Analog_Action :: enum u8 {
	Camera,
}

Input_Action_Set :: enum {
	Game,
	Menu,
}

_input_action_set_analog_actions := [Input_Action_Set]bit_set[Input_Analog_Action] {
	.Game = {.Camera},
	.Menu = {},
}

_input_action_set_actions := [Input_Action_Set]bit_set[Input_Action] {
	.Game = {.Fire},
	.Menu = {.Menu_Up, .Menu_Down, .Menu_Left, .Menu_Right, .Menu_Select, .Menu_Go_Back},
}

Input_Bindings :: struct {
	actions: [Input_Action][2]Input_Key,
}

INPUT_DEFAULT_BINDINGS :: Input_Bindings {
	actions = {
		.Menu_Up = {.Up, .W},
		.Menu_Down = {.Down, .S},
		.Menu_Left = {.Left, .A},
		.Menu_Right = {.Right, .D},
		.Menu_Select = {.Enter, .Space},
		.Menu_Go_Back = {.Escape, .Invalid},
		.Fire = {.Space, .Invalid},
	},
}

input_init :: proc(input: ^Input_System) {
	input^ = {
		action_set = .Menu,
	}
}

Input_Controllers_State :: struct {
	actions_down:         bit_set[Input_Action],
	analog_action_states: [Input_Analog_Action]Vec2,
	any_input_received:   bool,
}

input_update :: proc(input: ^Input_System) {
	ev: sdl.Event
	for sdl.poll_event(&ev) {
		debug_handle_event(&ev)
		#partial switch ev.type {
		case .Quit:
			{
				APP.quit_requested = true
			}
		case .Key_Down:
			{
				input.keys_down += {_input_key_from_sdl_scancode(ev.key.scancode)}
			}
		case .Key_Up:
			{
				input.keys_down -= {_input_key_from_sdl_scancode(ev.key.scancode)}
			}
		case .Mouse_Button_Down:
			{
				input.keys_down += {_input_key_from_sdl_mousebutton(ev.button.button)}
			}
		case .Mouse_Button_Up:
			{
				input.keys_down -= {_input_key_from_sdl_mousebutton(ev.button.button)}
			}
		case .Mouse_Motion:
			{
				_input_event_input_cursor_delta(
					input,
					{ev.motion.x, ev.motion.y},
					{ev.motion.xrel, ev.motion.yrel},
				)
			}
		case .Mouse_Wheel:
			{
				_input_event_cursor_wheel(input, ev.wheel.y)
			}
		case .Text_Input:
			{
				inp_str := string(ev.text.text)
				if len(inp_str) > 0 {
					if !((sdl.Mod_Ctrl & sdl.get_mod_state() != nil) &&
						   (inp_str[0] == 'c' || inp_str[0] == 'v')) {
						for ch in inp_str {
							arr_append(&input.characters, ch)
						}
					}
				}
			}
		}
	}
}

_input_event_input_cursor_delta :: proc(input: ^Input_System, pos: Vec2, move: Vec2) {
	input.input_cursor_pos = pos
	input.input_cursor_delta = move
}

_input_event_cursor_wheel :: proc(input: ^Input_System, scroll: f32) {
	input.scroll_delta += scroll
}

Input_Key :: enum u8 {
	Invalid = 0,
	Space,
	Apostrophe,
	Comma,
	Minus,
	Period,
	Slash,
	Num_0,
	Num_1,
	Num_2,
	Num_3,
	Num_4,
	Num_5,
	Num_6,
	Num_7,
	Num_8,
	Num_9,
	Semicolon,
	Equal,
	A,
	B,
	C,
	D,
	E,
	F,
	G,
	H,
	I,
	J,
	K,
	L,
	M,
	N,
	O,
	P,
	Q,
	R,
	S,
	T,
	U,
	V,
	W,
	X,
	Y,
	Z,
	Left_Bracket,
	Backslash,
	Right_Bracket,
	Grave_Accent,
	World_1,
	World_2,
	Escape,
	Enter,
	Tab,
	Backspace,
	Insert,
	Delete,
	Right,
	Left,
	Down,
	Up,
	Page_Up,
	Page_Down,
	Home,
	End,
	Caps_Lock,
	Scroll_Lock,
	Num_Lock,
	Print_Screen,
	Pause,
	F1,
	F2,
	F3,
	F4,
	F5,
	F6,
	F7,
	F8,
	F9,
	F10,
	F11,
	F12,
	F13,
	F14,
	F15,
	F16,
	F17,
	F18,
	F19,
	F20,
	F21,
	F22,
	F23,
	F24,
	F25,
	Kp_0,
	Kp_1,
	Kp_2,
	Kp_3,
	Kp_4,
	Kp_5,
	Kp_6,
	Kp_7,
	Kp_8,
	Kp_9,
	Kp_Decimal,
	Kp_Divide,
	Kp_Multiply,
	Kp_Subtract,
	Kp_Add,
	Kp_Enter,
	Kp_Equal,
	Left_Shift,
	Left_Control,
	Left_Alt,
	Left_Super,
	Right_Shift,
	Right_Control,
	Right_Alt,
	Right_Super,
	Menu,
	Mouse_Left,
	Mouse_Right,
	Mouse_Middle,
}

_input_key_from_sdl_mousebutton :: proc(mousebutton: u8) -> Input_Key {
	switch mousebutton {
	case sdl.Button_Left:
		return .Mouse_Left
	case sdl.Button_Right:
		return .Mouse_Right
	case sdl.Button_Middle:
		return .Mouse_Middle
	case:
		return .Invalid
	}
}

_input_key_from_sdl_scancode :: proc(scancode: sdl.Scancode) -> Input_Key {
	#partial switch scancode {
	case .A:
		return .A
	case .B:
		return .B
	case .C:
		return .C
	case .D:
		return .D
	case .E:
		return .E
	case .F:
		return .F
	case .G:
		return .G
	case .H:
		return .H
	case .I:
		return .I
	case .J:
		return .J
	case .K:
		return .K
	case .L:
		return .L
	case .M:
		return .M
	case .N:
		return .N
	case .O:
		return .O
	case .P:
		return .P
	case .Q:
		return .Q
	case .R:
		return .R
	case .S:
		return .S
	case .T:
		return .T
	case .U:
		return .U
	case .V:
		return .V
	case .W:
		return .W
	case .X:
		return .X
	case .Y:
		return .Y
	case .Z:
		return .Z
	case ._1:
		return .Num_1
	case ._2:
		return .Num_2
	case ._3:
		return .Num_3
	case ._4:
		return .Num_4
	case ._5:
		return .Num_5
	case ._6:
		return .Num_6
	case ._7:
		return .Num_7
	case ._8:
		return .Num_8
	case ._9:
		return .Num_9
	case ._0:
		return .Num_0
	case .Return:
		return .Enter
	case .Escape:
		return .Escape
	case .Backspace:
		return .Backspace
	case .Tab:
		return .Tab
	case .Space:
		return .Space
	case .Minus:
		return .Minus
	case .Equals:
		return .Equal
	case .Left_Bracket:
		return .Left_Bracket
	case .Right_Bracket:
		return .Right_Bracket
	case .Backslash:
		return .Backslash
	case .Semicolon:
		return .Semicolon
	case .Apostrophe:
		return .Apostrophe
	case .Grave:
		return .Grave_Accent
	case .Comma:
		return .Comma
	case .Period:
		return .Period
	case .Slash:
		return .Slash
	case .Caps_Lock:
		return .Caps_Lock
	case .F1:
		return .F1
	case .F2:
		return .F2
	case .F3:
		return .F3
	case .F4:
		return .F4
	case .F5:
		return .F5
	case .F6:
		return .F6
	case .F7:
		return .F7
	case .F8:
		return .F8
	case .F9:
		return .F9
	case .F10:
		return .F10
	case .F11:
		return .F11
	case .F12:
		return .F12
	case .Print_Screen:
		return .Print_Screen
	case .Scroll_Lock:
		return .Scroll_Lock
	case .Pause:
		return .Pause
	case .Insert:
		return .Insert
	case .Home:
		return .Home
	case .Page_Up:
		return .Page_Up
	case .Delete:
		return .Delete
	case .End:
		return .End
	case .Page_Down:
		return .Page_Down
	case .Right:
		return .Right
	case .Left:
		return .Left
	case .Down:
		return .Down
	case .Up:
		return .Up
	case .KP_Divide:
		return .Kp_Divide
	case .KP_Multiply:
		return .Kp_Multiply
	case .KP_Minus:
		return .Kp_Subtract
	case .KP_Plus:
		return .Kp_Add
	case .KP_Enter:
		return .Kp_Enter
	case .KP_1:
		return .Kp_1
	case .KP_2:
		return .Kp_2
	case .KP_3:
		return .Kp_3
	case .KP_4:
		return .Kp_4
	case .KP_5:
		return .Kp_5
	case .KP_6:
		return .Kp_6
	case .KP_7:
		return .Kp_7
	case .KP_8:
		return .Kp_8
	case .KP_9:
		return .Kp_9
	case .KP_0:
		return .Kp_0
	case .KP_Equals:
		return .Kp_Equal
	case .KP_Period:
		return .Kp_Decimal
	case .LCtrl:
		return .Left_Control
	case .LShift:
		return .Left_Shift
	case .LAlt:
		return .Left_Alt
	case .LGui:
		return .Left_Super
	case .RCtrl:
		return .Right_Control
	case .RShift:
		return .Right_Shift
	case .RAlt:
		return .Right_Alt
	case .RGui:
		return .Right_Super
	}
	return .Invalid
}
