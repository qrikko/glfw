project "glfw"
	kind "staticLib"
	language "C"
	staticruntime "on"
	tool()

	targetdir (engine_root .. "/lib/" .. outputdir)
	objdir (engine_root .. "/bin-int/" .. outputdir .. "/%{prj.name}") 

	files {
		"include/GLFW/glfw3.h",
		"include/GLFW/glfw3native.h",
		"src/glfw_config.h",
		"src/context.c",
		"src/init.c",
		"src/input.c",
		"src/monitor.c",
		"src/vulkan.c",
		"src/window.c",
	}

	includedirs {
		"../glad/include/"
	}
	--links { "glad", "GL" }

	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"
	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "system:linux"
		systemversion "latest"
		-- should these be removed?
		buildoptions { "-fPIC" }

		files {
			"src/null_*",

			"src/platform.c",
			"src/posix_module.c",
			"src/x11_init.c",
			"src/linux_joystick.c",
			"src/x11_monitor.c",
			"src/posix_time.c",
			"src/posix_thread.c",
			"src/x11_window.c",
			"src/x11_platform.h",
			"src/glx_context.c",
			"src/egl_context.c",
			"src/osmesa_context.c",
			"src/xkb_unicode.c"
		}

		defines { 
			"_GLFW_X11",
			"_CRT_SECURE_NO_WARNINGS"
		}

	filter "system:windows"
		systemversion "latest"
		files {
			"src/win32_init.c",
			"src/win32_joystick.c",
			"src/win32_monitor.c",
			"src/win32_time.c",
			"src/win32_thread.c",
			"src/win32_window.c",
			"src/wgl_context.c",
			"src/egl_context.c",
			"src/osmesa_context.c"
		}

		defines {
			"_GLFW_WIN32",
			"_CRT_SECURE_NO_WARNINGS"
		}