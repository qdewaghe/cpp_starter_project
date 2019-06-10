cwd             = os.getcwd()
project_name    = path.rebase("./", cwd, path.getdirectory(cwd))
project_lib     = (project_name .. "_lib")

include(cwd .. "/conan/conanbuildinfo.premake.lua")

workspace (project_name)
    conan_basic_setup()

    language        "C++"
    cppdialect      "C++17"
    objdir          "obj/"
    warnings        "Extra"
    includedirs     "include"
	
    filter { "configurations:debug" }
        defines { "DEBUG" }
        symbols "On"
	optimize "Off"

    filter { "configurations:release" }
        defines { "NDEBUG" }
        optimize "Full"

    filter { "system:windows" }
        systemversion "latest"
        entrypoint "mainCRTStartup"

project  (project_lib)
    kind      "StaticLib"
    location  "src/"
    targetdir "bin/%{cfg.buildcfg}/lib"
    files     "src/**.cpp"
    
project  (project_name)
    kind      "ConsoleApp"
    location  "src/"
    targetdir "bin/%{cfg.buildcfg}"
    links     (project_lib)
    files     "src/**.cxx"
    
project "tests"
    kind      "ConsoleApp"
    location  "tests/"
    targetdir "bin/%{cfg.buildcfg}"
    links     (project_lib)
    files     { "tests/**.cxx", "tests/**.cpp" }

    postbuildcommands {
       "../bin/%{cfg.buildcfg}/tests"
    }
