package sdl

import "core:c"

Log_Category :: enum c.int {
	Application,
	Error,
	Assert,
	System,
	Audio,
	Video,
	Render,
	Input,
	Test,
	GPU,

	/* Reserved for future SDL library use */
	Reserved2,
	Reserved3,
	Reserved4,
	Reserved5,
	Reserved6,
	Reserved7,
	Reserved8,
	Reserved9,
	Reserved10,

	/* Beyond this point is reserved for application use, e.g.
		enum {
			MYAPP_CATEGORY_AWESOME1 = CUSTOM,
			MYAPP_CATEGORY_AWESOME2,
			MYAPP_CATEGORY_AWESOME3,
			...
		};
	*/
	Custom,
}

Log_Priority :: enum c.int {
	Invalid,
	Trace,
	Verbose,
	Debug,
	Info,
	Warn,
	Error,
	Critical,
}

@(default_calling_convention = "c")
foreign lib {
	@(link_name = "SDL_SetLogPriorities")
	set_log_priorities :: proc(priority: Log_Priority) ---
	@(link_name = "SDL_SetLogPriority")
	set_log_priority :: proc(category: Log_Category, priority: Log_Priority) ---
	@(link_name = "SDL_GetLogPriority")
	get_log_priority :: proc(category: Log_Category) -> Log_Priority ---
	@(link_name = "SDL_ResetLogPriorities")
	reset_log_priorities :: proc() ---
	@(link_name = "SDL_SetLogPriorityPrefix")
	set_log_priority_prefix :: proc(priority: Log_Priority, prefix: cstring) -> bool ---
	@(link_name = "SDL_Log")
	log :: proc(fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogTrace")
	log_trace :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogVerbose")
	log_verbose :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogDebug")
	log_debug :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogInfo")
	log_info :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogWarn")
	log_warn :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogError")
	log_error :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogCritical")
	log_critical :: proc(category: c.int, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogMessage")
	log_message :: proc(category: c.int, priority: Log_Priority, fmt: cstring, #c_vararg args: ..any) ---
	@(link_name = "SDL_LogMessageV")
	log_message_v :: proc(category: c.int, priority: Log_Priority, fmt: cstring, ap: c.va_list) ---
}
