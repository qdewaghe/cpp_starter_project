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
    includedirs     "include"
    
    files { 
        "src/**.hpp", "src/**.h", 
        "src/**.cxx", "src/**.cpp" 
    }

    filter { "configurations:debug" }
        defines { "DEBUG" }
        symbols "On"

    filter { "configurations:release" }
        defines { "NDEBUG" }
        optimize "On"

    filter { "system:windows" }
        systemversion "latest"
        entrypoint "mainCRTStartup"
	
project "tests"
    kind            "ConsoleApp"
    location        "tests/"
    language        "C++"
    cppdialect      "C++17"
    targetdir       "build/bin/%{cfg.buildcfg}"
    objdir          "build/obj/%{cfg.buildcfg}"
    warnings        "Extra"  
    staticruntime   "On"
    
    files { 
        "tests/**.hpp", "tests/**.h", 
        "tests/**.cxx", "tests/**.cpp",
	"src/**.cpp", "src/**.hpp",
	"src/**.h"
    }

    postbuildcommands {
       "../build/bin/%{cfg.buildcfg}/tests"
    }
