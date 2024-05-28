project "glfw3"
	kind "staticLib"
	language (engine.compiler.language)
	toolset (engine.compiler.toolset)

	targetdir (engine.lib)
	objdir (engine.intermediate)

	staticruntime "on"

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
        "src/null_*.c",
		-- building glad with glfw
		engine.dependency.glad .. "/src/glad.c",
		engine.dependency.glad .. "/include/glad/glad.h",
		engine.dependency.glad .. "/include/KHR/khrplatform.h"
	}

	includedirs {
		engine.dependency.glad .. "/include"
	}
	
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
			"src/linux_joystick.*",
			"src/egl_context.*",
			"src/glx_context.*",
			"src/osmesa_context.*",
			"src/platform.*",
			"src/posix_module.*",
            "src/posix_poll.*",
			"src/posix_thread.*",
			"src/posix_time.*",
--            "src/wl_init.*",
--            "src/wl_monitor.*",
--            "src/wl_window.*",
			"src/x11_init.*",
			"src/x11_monitor.*",
			"src/x11_platform.*",
			"src/x11_window.*",
			"src/xkb_unicode.*"
		}

		defines { 
			"_GLFW_X11",
            --"_GLFW_WAYLAND",
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
