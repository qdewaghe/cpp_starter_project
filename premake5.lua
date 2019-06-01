cwd             = os.getcwd()
project_name    = path.rebase("./", cwd, path.getdirectory(cwd))

include(cwd .. "/vendor/conan/conanbuildinfo.premake.lua")

workspace (project_name)
    conan_basic_setup()
    
project  (project_name)

    kind            "ConsoleApp"
    location        "src/"
    language        "C++"
    cppdialect      "C++17"
    targetdir       "build/bin/%{cfg.buildcfg}"
    objdir          "build/obj/%{cfg.buildcfg}"
    warnings        "Extra"  
    staticruntime   "On"

    files { 
        "src/**.hpp", "src/**.h", 
        "src/**.cxx", "src/**.cpp" 
    }

    filter { "configurations:debug" }
        defines { "DEBUG", conan_cppdefines }
        symbols "On"

    filter { "configurations:release" }
        defines { "NDEBUG", conan_cppdefines }
        optimize "On"

    filter {"configurations:linux64"}
	architecture "x64"
	system "linux"

    filter {"configurations:win64"}
	architecture "x64"
	system "windows"

    filter {"configurations:linux_arm"}
	architecture "arm"
	system "linux"
	
    filter "system:windows"
        systemversion "latest"
        entrypoint "mainCRTStartup"
	
project "tests"
    kind            "ConsoleApp"
    location        "tests/"
    language        "C++"
    cppdialect      "C++17"
    targetdir       "build/bin/%{cfg.buildcfg}/tests"
    objdir          "build/obj/%{cfg.buildcfg}/tests"
    warnings        "Extra"
    includedirs     { "src/", "include/"}
    
    files { 
        "tests/**.hpp", "tests/**.h", 
        "tests/**.cxx", "tests/**.cpp",
	"src/**.cpp", "src/**.hpp",
	"src/**.h"
    }

    postbuildcommands {
       "../build/bin/%{cfg.buildcfg}/tests"
    }
