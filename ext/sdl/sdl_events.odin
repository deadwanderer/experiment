package sdl

import "core:c"

Event_Type :: enum u32 {
	FIRST = 0, /**< Unused (do not remove) */

	/* Application events */
	Quit = 0x100, /**< User-requested quit */

	/* These application events have special meaning on iOS and Android, see README-ios.md and README-android.md for details */
	TERMINATING, /**< The application is being terminated by the OS. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationWillTerminate()
	                             Called on Android in onDestroy()
	                        */
	LOW_MEMORY, /**< The application is low on memory, free memory if possible. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationDidReceiveMemoryWarning()
	                             Called on Android in onTrimMemory()
	                        */
	WILL_ENTER_BACKGROUND, /**< The application is about to enter the background. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationWillResignActive()
	                             Called on Android in onPause()
	                        */
	DID_ENTER_BACKGROUND, /**< The application did enter the background and may not get CPU for some time. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationDidEnterBackground()
	                             Called on Android in onPause()
	                        */
	WILL_ENTER_FOREGROUND, /**< The application is about to enter the foreground. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationWillEnterForeground()
	                             Called on Android in onResume()
	                        */
	DID_ENTER_FOREGROUND, /**< The application is now interactive. This event must be handled in a callback set with SDL_AddEventWatch().
	                             Called on iOS in applicationDidBecomeActive()
	                             Called on Android in onResume()
	                        */
	LOCALE_CHANGED, /**< The user's locale preferences have changed. */
	SYSTEM_THEME_CHANGED, /**< The system theme changed */

	/* Display events */
	/* 0x150 was SDL_DISPLAYEVENT, reserve the number for sdl2-compat */
	DISPLAY_ORIENTATION = 0x151, /**< Display orientation has changed to data1 */
	DISPLAY_ADDED, /**< Display has been added to the system */
	DISPLAY_REMOVED, /**< Display has been removed from the system */
	DISPLAY_MOVED, /**< Display has changed position */
	DISPLAY_DESKTOP_MODE_CHANGED, /**< Display has changed desktop mode */
	DISPLAY_CURRENT_MODE_CHANGED, /**< Display has changed current mode */
	DISPLAY_CONTENT_SCALE_CHANGED, /**< Display has changed content scale */
	DISPLAY_FIRST = DISPLAY_ORIENTATION,
	DISPLAY_LAST = DISPLAY_CONTENT_SCALE_CHANGED,

	/* Window events */
	/* 0x200 was SDL_WINDOWEVENT, reserve the number for sdl2-compat */
	/* 0x201 was SYSWM, reserve the number for sdl2-compat */
	Window_Shown = 0x202, /**< Window has been shown */
	Window_Hidden, /**< Window has been hidden */
	Window_Exposed, /**< Window has been exposed and should be redrawn, and can be redrawn directly from event watchers for this event */
	Window_Moved, /**< Window has been moved to data1, data2 */
	Window_Resized, /**< Window has been resized to data1xdata2 */
	Window_Pixel_Size_Changed, /**< The pixel size of the window has changed to data1xdata2 */
	Window_Metal_View_Resized, /**< The pixel size of a Metal view associated with the window has changed */
	Window_Minimized, /**< Window has been minimized */
	Window_Maximized, /**< Window has been maximized */
	Window_Restored, /**< Window has been restored to normal size and position */
	Window_Mouse_Enter, /**< Window has gained mouse focus */
	Window_Mouse_Leave, /**< Window has lost mouse focus */
	Window_Focus_Gained, /**< Window has gained keyboard focus */
	Window_Focus_Lost, /**< Window has lost keyboard focus */
	Window_Close_Requested, /**< The window manager requests that the window be closed */
	Window_Hit_Test, /**< Window had a hit test that wasn't SDL_HITTEST_NORMAL */
	Window_Iccprof_Changed, /**< The ICC profile of the window's display has changed */
	Window_Display_Changed, /**< Window has been moved to display data1 */
	Window_Display_Scale_Changed, /**< Window display scale has been changed */
	Window_Safe_Area_Changed, /**< The window safe area has been changed */
	Window_Occluded, /**< The window has been occluded */
	Window_Enter_Fullscreen, /**< The window has entered fullscreen mode */
	Window_Leave_Fullscreen, /**< The window has left fullscreen mode */
	Window_Destroyed, /**< The window with the associated ID is being or has been destroyed. If this message is being handled
	                                     in an event watcher, the window handle is still valid and can still be used to retrieve any properties
	                                     associated with the window. Otherwise, the handle has already been destroyed and all resources
	                                     associated with it are invalid */
	WINDOW_HDR_STATE_CHANGED, /**< Window HDR properties have changed */
	WINDOW_FIRST = Window_Shown,
	WINDOW_LAST = WINDOW_HDR_STATE_CHANGED,

	/* Keyboard events */
	Key_Down = 0x300, /**< Key pressed */
	Key_Up, /**< Key released */
	Text_Editing, /**< Keyboard text editing (composition) */
	Text_Input, /**< Keyboard text input */
	KEYMAP_CHANGED, /**< Keymap changed due to a system event such as an
	                                    input language or keyboard layout change. */
	KEYBOARD_ADDED, /**< A new keyboard has been inserted into the system */
	KEYBOARD_REMOVED, /**< A keyboard has been removed */
	TEXT_EDITING_CANDIDATES, /**< Keyboard text editing candidates */

	/* Mouse events */
	Mouse_Motion = 0x400, /**< Mouse moved */
	Mouse_Button_Down, /**< Mouse button pressed */
	Mouse_Button_Up, /**< Mouse button released */
	Mouse_Wheel, /**< Mouse wheel motion */
	Mouse_Added, /**< A new mouse has been inserted into the system */
	Mouse_Removed, /**< A mouse has been removed */

	/* Joystick events */
	JOYSTICK_AXIS_MOTION = 0x600, /**< Joystick axis motion */
	JOYSTICK_BALL_MOTION, /**< Joystick trackball motion */
	JOYSTICK_HAT_MOTION, /**< Joystick hat position change */
	JOYSTICK_BUTTON_DOWN, /**< Joystick button pressed */
	JOYSTICK_BUTTON_UP, /**< Joystick button released */
	JOYSTICK_ADDED, /**< A new joystick has been inserted into the system */
	JOYSTICK_REMOVED, /**< An opened joystick has been removed */
	JOYSTICK_BATTERY_UPDATED, /**< Joystick battery level change */
	JOYSTICK_UPDATE_COMPLETE, /**< Joystick update is complete */

	/* Gamepad events */
	GAMEPAD_AXIS_MOTION = 0x650, /**< Gamepad axis motion */
	GAMEPAD_BUTTON_DOWN, /**< Gamepad button pressed */
	GAMEPAD_BUTTON_UP, /**< Gamepad button released */
	GAMEPAD_ADDED, /**< A new gamepad has been inserted into the system */
	GAMEPAD_REMOVED, /**< A gamepad has been removed */
	GAMEPAD_REMAPPED, /**< The gamepad mapping was updated */
	GAMEPAD_TOUCHPAD_DOWN, /**< Gamepad touchpad was touched */
	GAMEPAD_TOUCHPAD_MOTION, /**< Gamepad touchpad finger was moved */
	GAMEPAD_TOUCHPAD_UP, /**< Gamepad touchpad finger was lifted */
	GAMEPAD_SENSOR_UPDATE, /**< Gamepad sensor was updated */
	GAMEPAD_UPDATE_COMPLETE, /**< Gamepad update is complete */
	GAMEPAD_STEAM_HANDLE_UPDATED, /**< Gamepad Steam handle has changed */

	/* Touch events */
	FINGER_DOWN = 0x700,
	FINGER_UP,
	FINGER_MOTION,
	FINGER_CANCELED,

	/* 0x800, 0x801, and 0x802 were the Gesture events from SDL2. Do not reuse these values! sdl2-compat needs them! */

	/* Clipboard events */
	CLIPBOARD_UPDATE = 0x900, /**< The clipboard or primary selection changed */

	/* Drag and drop events */
	DROP_FILE = 0x1000, /**< The system requests a file open */
	DROP_TEXT, /**< text/plain drag-and-drop event */
	DROP_BEGIN, /**< A new set of drops is beginning (NULL filename) */
	DROP_COMPLETE, /**< Current set of drops is now complete (NULL filename) */
	DROP_POSITION, /**< Position while moving over the window */

	/* Audio hotplug events */
	AUDIO_DEVICE_ADDED = 0x1100, /**< A new audio device is available */
	AUDIO_DEVICE_REMOVED, /**< An audio device has been removed. */
	AUDIO_DEVICE_FORMAT_CHANGED, /**< An audio device's format has been changed by the system. */

	/* Sensor events */
	SENSOR_UPDATE = 0x1200, /**< A sensor was updated */

	/* Pressure-sensitive pen events */
	PEN_PROXIMITY_IN = 0x1300, /**< Pressure-sensitive pen has become available */
	PEN_PROXIMITY_OUT, /**< Pressure-sensitive pen has become unavailable */
	PEN_DOWN, /**< Pressure-sensitive pen touched drawing surface */
	PEN_UP, /**< Pressure-sensitive pen stopped touching drawing surface */
	PEN_BUTTON_DOWN, /**< Pressure-sensitive pen button pressed */
	PEN_BUTTON_UP, /**< Pressure-sensitive pen button released */
	PEN_MOTION, /**< Pressure-sensitive pen is moving on the tablet */
	PEN_AXIS, /**< Pressure-sensitive pen angle/pressure/etc changed */

	/* Camera hotplug events */
	CAMERA_DEVICE_ADDED = 0x1400, /**< A new camera device is available */
	CAMERA_DEVICE_REMOVED, /**< A camera device has been removed. */
	CAMERA_DEVICE_APPROVED, /**< A camera device has been approved for use by the user. */
	CAMERA_DEVICE_DENIED, /**< A camera device has been denied for use by the user. */

	/* Render events */
	RENDER_TARGETS_RESET = 0x2000, /**< The render targets have been reset and their contents need to be updated */
	RENDER_DEVICE_RESET, /**< The device has been reset and all textures need to be recreated */
	RENDER_DEVICE_LOST, /**< The device has been lost and can't be recovered. */

	/* Reserved events for private platforms */
	PRIVATE0 = 0x4000,
	PRIVATE1,
	PRIVATE2,
	PRIVATE3,

	/* Internal events */
	POLL_SENTINEL = 0x7F00, /**< Signals the end of an event poll cycle */

	/** Events USER through LAST are for your use,
	*  and should be allocated with SDL_RegisterEvents()
	*/
	USER = 0x8000,

	/**
	*  This last event is only for bounding internal arrays
	*/
	LAST = 0xFFFF,
}

Common_Event :: struct {
	type:      Event_Type, /**< Event type, shared with all events, u32 to cover user events which are not in the SDL_Event_Type enumeration */
	_:         u32,
	timestamp: u64, /**< In nanoseconds, populated using SDL_GetTicksNS() */
}

Display_Event :: struct {
	using commonEvent: Common_Event, /**< SDL_DISPLAYEVENT_* */
	displayID:         Display_ID, /**< The associated display */
	data1:             i32, /**< event dependent data */
	data2:             i32, /**< event dependent data */
}

WindowEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_WINDOW_* */
	windowID:          Window_ID, /**< The associated window */
	data1:             i32, /**< event dependent data */
	data2:             i32, /**< event dependent data */
}

KeyboardDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_KEYBOARD_ADDED or SDL_EVENT_KEYBOARD_REMOVED */
	which:             Keyboard_ID, /**< The keyboard instance id */
}

Keyboard_Event :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_KEY_DOWN or SDL_EVENT_KEY_UP */
	windowID:          Window_ID, /**< The window with keyboard focus, if any */
	which:             Keyboard_ID, /**< The keyboard instance id, or 0 if unknown or virtual */
	scancode:          Scancode, /**< SDL physical key code */
	key:               Keycode, /**< SDL virtual key code */
	mod:               Keymod, /**< current key modifiers */
	raw:               u16, /**< The platform dependent scancode for this event */
	down:              bool, /**< true if the key is pressed */
	repeat:            bool, /**< true if this is a key repeat */
}

TextEditingEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_TEXT_EDITING */
	windowID:          Window_ID, /**< The window with keyboard focus, if any */
	text:              cstring, /**< The editing text */
	start:             i32, /**< The start cursor of selected editing text, or -1 if not set */
	length:            i32, /**< The length of selected editing text, or -1 if not set */
}

TextEditingCandidatesEvent :: struct {
	using commonEvent:  Common_Event, /**< SDL_EVENT_TEXT_EDITING_CANDIDATES */
	windowID:           Window_ID, /**< The window with keyboard focus, if any */
	candidates:         [^]cstring `fmt:"v,num_candidates"`, /**< The list of candidates, or NULL if there are no candidates available */
	num_candidates:     i32, /**< The number of strings in `candidates` */
	selected_candidate: i32, /**< The index of the selected candidate, or -1 if no candidate is selected */
	horizontal:         bool, /**< true if the list is horizontal, false if it's vertical */
	_:                  u8,
	_:                  u8,
	_:                  u8,
}

TextInputEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_TEXT_INPUT */
	windowID:          Window_ID, /**< The window with keyboard focus, if any */
	text:              cstring, /**< The input text, UTF-8 encoded */
}

MouseDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_MOUSE_ADDED or SDL_EVENT_MOUSE_REMOVED */
	which:             Mouse_ID, /**< The mouse instance id */
}

MouseMotionEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_MOUSE_MOTION */
	windowID:          Window_ID, /**< The window with mouse focus, if any */
	which:             Mouse_ID, /**< The mouse instance id in relative mode, SDL_TOUCH_MOUSEID for touch events, or 0 */
	state:             Mouse_Button_Flags, /**< The current button state */
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
	xrel:              f32, /**< The relative motion in the X direction */
	yrel:              f32, /**< The relative motion in the Y direction */
}

MouseButtonEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_MOUSE_BUTTON_DOWN or SDL_EVENT_MOUSE_BUTTON_UP */
	windowID:          Window_ID, /**< The window with mouse focus, if any */
	which:             Mouse_ID, /**< The mouse instance id in relative mode, SDL_TOUCH_MOUSEID for touch events, or 0 */
	button:            u8, /**< The mouse button index */
	down:              bool, /**< true if the button is pressed */
	clicks:            u8, /**< 1 for single-click, 2 for double-click, etc. */
	_:                 u8,
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
}

MouseWheelEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_MOUSE_WHEEL */
	windowID:          Window_ID, /**< The window with mouse focus, if any */
	which:             Mouse_ID, /**< The mouse instance id in relative mode or 0 */
	x:                 f32, /**< The amount scrolled horizontally, positive to the right and negative to the left */
	y:                 f32, /**< The amount scrolled vertically, positive away from the user and negative toward the user */
	direction:         Mouse_Wheel_Direction, /**< Set to one of the SDL_MOUSEWHEEL_* defines. When FLIPPED the values in X and Y will be opposite. Multiply by -1 to change them back */
	mouse_x:           f32, /**< X coordinate, relative to window */
	mouse_y:           f32, /**< Y coordinate, relative to window */
}

JoyAxisEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_AXIS_MOTION */
	which:             Joystick_ID, /**< The joystick instance id */
	axis:              u8, /**< The joystick axis index */
	_:                 u8,
	_:                 u8,
	_:                 u8,
	value:             i16, /**< The axis value (range: -32768 to 32767) */
	_:                 u16,
}

JoyBallEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_BALL_MOTION */
	which:             Joystick_ID, /**< The joystick instance id */
	ball:              u8, /**< The joystick trackball index */
	_:                 u8,
	_:                 u8,
	_:                 u8,
	xrel:              i16, /**< The relative motion in the X direction */
	yrel:              i16, /**< The relative motion in the Y direction */
}

JoyHatEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_HAT_MOTION */
	which:             Joystick_ID, /**< The joystick instance id */
	hat:               u8, /**< The joystick hat index */
	value:             u8, /**< The hat position value.
	                     *   \sa SDL_HAT_LEFTUP SDL_HAT_UP SDL_HAT_RIGHTUP
	                     *   \sa SDL_HAT_LEFT SDL_HAT_CENTERED SDL_HAT_RIGHT
	                     *   \sa SDL_HAT_LEFTDOWN SDL_HAT_DOWN SDL_HAT_RIGHTDOWN
	                     *
	                     *   Note that zero means the POV is centered.
	                     */
	_:                 u8,
	_:                 u8,
}

JoyButtonEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_BUTTON_DOWN or SDL_EVENT_JOYSTICK_BUTTON_UP */
	which:             Joystick_ID, /**< The joystick instance id */
	button:            u8, /**< The joystick button index */
	down:              bool, /**< true if the button is pressed */
	_:                 u8,
	_:                 u8,
}

JoyDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_ADDED or SDL_EVENT_JOYSTICK_REMOVED or SDL_EVENT_JOYSTICK_UPDATE_COMPLETE */
	which:             Joystick_ID, /**< The joystick instance id */
}

JoyBatteryEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_JOYSTICK_BATTERY_UPDATED */
	which:             Joystick_ID, /**< The joystick instance id */
	state:             Power_State, /**< The joystick battery state */
	percent:           c.int, /**< The joystick battery percent charge remaining */
}

GamepadAxisEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_GAMEPAD_AXIS_MOTION */
	which:             Joystick_ID, /**< The joystick instance id */
	axis:              u8, /**< The gamepad axis (SDL_GamepadAxis) */
	_:                 u8,
	_:                 u8,
	_:                 u8,
	value:             i16, /**< The axis value (range: -32768 to 32767) */
	_:                 u16,
}

GamepadButtonEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_GAMEPAD_BUTTON_DOWN or SDL_EVENT_GAMEPAD_BUTTON_UP */
	which:             Joystick_ID, /**< The joystick instance id */
	button:            u8, /**< The gamepad button (SDL_GamepadButton) */
	down:              bool, /**< true if the button is pressed */
	_:                 u8,
	_:                 u8,
}

GamepadDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_GAMEPAD_ADDED, SDL_EVENT_GAMEPAD_REMOVED, or SDL_EVENT_GAMEPAD_REMAPPED, SDL_EVENT_GAMEPAD_UPDATE_COMPLETE or SDL_EVENT_GAMEPAD_STEAM_HANDLE_UPDATED */
	which:             Joystick_ID, /**< The joystick instance id */
}

GamepadTouchpadEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_GAMEPAD_TOUCHPAD_DOWN or SDL_EVENT_GAMEPAD_TOUCHPAD_MOTION or SDL_EVENT_GAMEPAD_TOUCHPAD_UP */
	which:             Joystick_ID, /**< The joystick instance id */
	touchpad:          i32, /**< The index of the touchpad */
	finger:            i32, /**< The index of the finger on the touchpad */
	x:                 f32, /**< Normalized in the range 0...1 with 0 being on the left */
	y:                 f32, /**< Normalized in the range 0...1 with 0 being at the top */
	pressure:          f32, /**< Normalized in the range 0...1 */
}

GamepadSensorEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_GAMEPAD_SENSOR_UPDATE */
	which:             Joystick_ID, /**< The joystick instance id */
	sensor:            i32, /**< The type of the sensor, one of the values of SDL_SensorType */
	data:              [3]f32, /**< Up to 3 values from the sensor, as defined in SDL_sensor.h */
	sensor_timestamp:  u64, /**< The timestamp of the sensor reading in nanoseconds, not necessarily synchronized with the system clock */
}

AudioDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_AUDIO_DEVICE_ADDED, or SDL_EVENT_AUDIO_DEVICE_REMOVED, or SDL_EVENT_AUDIO_DEVICE_FORMAT_CHANGED */
	which:             Audio_Device_ID, /**< SDL_AudioDeviceID for the device being added or removed or changing */
	recording:         bool, /**< false if a playback device, true if a recording device. */
	_:                 u8,
	_:                 u8,
	_:                 u8,
}

CameraDeviceEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_CAMERA_DEVICE_ADDED, SDL_EVENT_CAMERA_DEVICE_REMOVED, SDL_EVENT_CAMERA_DEVICE_APPROVED, SDL_EVENT_CAMERA_DEVICE_DENIED */
	which:             Camera_ID, /**< SDL_CameraID for the device being added or removed or changing */
}

RenderEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_RENDER_TARGETS_RESET, SDL_EVENT_RENDER_DEVICE_RESET, SDL_EVENT_RENDER_DEVICE_LOST */
	windowID:          Window_ID, /**< The window containing the renderer in question. */
}

TouchFingerEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_FINGER_DOWN, SDL_EVENT_FINGER_UP, SDL_EVENT_FINGER_MOTION, or SDL_EVENT_FINGER_CANCELED */
	touchID:           Touch_ID, /**< The touch device id */
	fingerID:          Finger_ID,
	x:                 f32, /**< Normalized in the range 0...1 */
	y:                 f32, /**< Normalized in the range 0...1 */
	dx:                f32, /**< Normalized in the range -1...1 */
	dy:                f32, /**< Normalized in the range -1...1 */
	pressure:          f32, /**< Normalized in the range 0...1 */
	windowID:          Window_ID, /**< The window underneath the finger, if any */
}

PenProximityEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_PEN_PROXIMITY_IN or SDL_EVENT_PEN_PROXIMITY_OUT */
	windowID:          Window_ID, /**< The window with pen focus, if any */
	which:             Pen_ID, /**< The pen instance id */
}


PenMotionEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_PEN_MOTION */
	windowID:          Window_ID, /**< The window with pen focus, if any */
	which:             Pen_ID, /**< The pen instance id */
	pen_state:         Pen_Input_Flags, /**< Complete pen input state at time of event */
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
}

PenTouchEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_PEN_DOWN or SDL_EVENT_PEN_UP */
	windowID:          Window_ID, /**< The window with pen focus, if any */
	which:             Pen_ID, /**< The pen instance id */
	pen_state:         Pen_Input_Flags, /**< Complete pen input state at time of event */
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
	eraser:            bool, /**< true if eraser end is used (not all pens support this). */
	down:              bool, /**< true if the pen is touching or false if the pen is lifted off */
}

PenButtonEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_PEN_BUTTON_DOWN or SDL_EVENT_PEN_BUTTON_UP */
	windowID:          Window_ID, /**< The window with mouse focus, if any */
	which:             Pen_ID, /**< The pen instance id */
	pen_state:         Pen_Input_Flags, /**< Complete pen input state at time of event */
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
	button:            u8, /**< The pen button index (first button is 1). */
	down:              bool, /**< true if the button is pressed */
}

PenAxisEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_PEN_AXIS */
	windowID:          Window_ID, /**< The window with pen focus, if any */
	which:             Pen_ID, /**< The pen instance id */
	pen_state:         Pen_Input_Flags, /**< Complete pen input state at time of event */
	x:                 f32, /**< X coordinate, relative to window */
	y:                 f32, /**< Y coordinate, relative to window */
	axis:              Pen_Axis, /**< Axis that has changed */
	value:             f32, /**< New value of axis */
}

DropEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_DROP_BEGIN or SDL_EVENT_DROP_FILE or SDL_EVENT_DROP_TEXT or SDL_EVENT_DROP_COMPLETE or SDL_EVENT_DROP_POSITION */
	windowID:          Window_ID, /**< The window that was dropped on, if any */
	x:                 f32, /**< X coordinate, relative to window (not on begin) */
	y:                 f32, /**< Y coordinate, relative to window (not on begin) */
	source:            cstring, /**< The source app that sent this drop event, or NULL if that isn't available */
	data:              cstring, /**< The text for SDL_EVENT_DROP_TEXT and the file name for SDL_EVENT_DROP_FILE, NULL for other events */
}

ClipboardEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_CLIPBOARD_UPDATE */
	owner:             bool, /**< are we owning the clipboard (internal update) */
	num_mime_types:    i32, /**< number of mime types */
	mime_types:        [^]cstring `fmt:"v,num_mime_types"`, /**< current mime types */
}

SensorEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_SENSOR_UPDATE */
	which:             Sensor_ID, /**< The instance ID of the sensor */
	data:              [6]f32, /**< Up to 6 values from the sensor - additional values can be queried using SDL_GetSensorData() */
	sensor_timestamp:  u64, /**< The timestamp of the sensor reading in nanoseconds, not necessarily synchronized with the system clock */
}

QuitEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_QUIT */
}

UserEvent :: struct {
	using commonEvent: Common_Event, /**< SDL_EVENT_USER through SDL_EVENT_LAST-1, u32 because these are not in the SDL_Event_Type enumeration */
	windowID:          Window_ID, /**< The associated window if any */
	code:              i32, /**< User defined event code */
	data1:             rawptr, /**< User defined data pointer */
	data2:             rawptr, /**< User defined data pointer */
}


Event :: struct #raw_union {
	type:            Event_Type, /**< Event type, shared with all events, u32 to cover user events which are not in the SDL_Event_Type enumeration */
	common:          Common_Event, /**< Common event data */
	display:         Display_Event, /**< Display event data */
	window:          WindowEvent, /**< Window event data */
	kdevice:         KeyboardDeviceEvent, /**< Keyboard device change event data */
	key:             Keyboard_Event, /**< Keyboard event data */
	edit:            TextEditingEvent, /**< Text editing event data */
	edit_candidates: TextEditingCandidatesEvent, /**< Text editing candidates event data */
	text:            TextInputEvent, /**< Text input event data */
	mdevice:         MouseDeviceEvent, /**< Mouse device change event data */
	motion:          MouseMotionEvent, /**< Mouse motion event data */
	button:          MouseButtonEvent, /**< Mouse button event data */
	wheel:           MouseWheelEvent, /**< Mouse wheel event data */
	jdevice:         JoyDeviceEvent, /**< Joystick device change event data */
	jaxis:           JoyAxisEvent, /**< Joystick axis event data */
	jball:           JoyBallEvent, /**< Joystick ball event data */
	jhat:            JoyHatEvent, /**< Joystick hat event data */
	jbutton:         JoyButtonEvent, /**< Joystick button event data */
	jbattery:        JoyBatteryEvent, /**< Joystick battery event data */
	gdevice:         GamepadDeviceEvent, /**< Gamepad device event data */
	gaxis:           GamepadAxisEvent, /**< Gamepad axis event data */
	gbutton:         GamepadButtonEvent, /**< Gamepad button event data */
	gtouchpad:       GamepadTouchpadEvent, /**< Gamepad touchpad event data */
	gsensor:         GamepadSensorEvent, /**< Gamepad sensor event data */
	adevice:         AudioDeviceEvent, /**< Audio device event data */
	cdevice:         CameraDeviceEvent, /**< Camera device event data */
	sensor:          SensorEvent, /**< Sensor event data */
	quit:            QuitEvent, /**< Quit request event data */
	user:            UserEvent, /**< Custom event data */
	tfinger:         TouchFingerEvent, /**< Touch finger event data */
	pproximity:      PenProximityEvent, /**< Pen proximity event data */
	ptouch:          PenTouchEvent, /**< Pen tip touching event data */
	pmotion:         PenMotionEvent, /**< Pen motion event data */
	pbutton:         PenButtonEvent, /**< Pen button event data */
	paxis:           PenAxisEvent, /**< Pen axis event data */
	render:          RenderEvent, /**< Render event data */
	drop:            DropEvent, /**< Drag and drop event data */
	clipboard:       ClipboardEvent, /**< Clipboard event data */

	/* This is necessary for ABI compatibility between Visual C++ and GCC.
	   Visual C++ will respect the push pack pragma and use 52 bytes (size of
	   SDL_TextEditingEvent, the largest structure for 32-bit and 64-bit
	   architectures) for this union, and GCC will use the alignment of the
	   largest datatype within the union, which is 8 bytes on 64-bit
	   architectures.

	   So... we'll add _to force the size to be the same for both.

	   On architectures where pointers are 16 bytes, this needs rounding up to
	   the next multiple of 16, 64, and on architectures where pointers are
	   even larger the size of SDL_UserEvent will dominate as being 3 pointers.
	*/
	padding:         [128]u8,
}


@(default_calling_convention = "c")
foreign lib {
	@(link_name = "SDL_PollEvent")
	poll_event :: proc(event: ^Event) -> bool ---
}
