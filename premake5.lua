cwd             = os.getcwd()
project_name    = path.rebase("./", cwd, path.getdirectory(cwd))
project_lib     = (project_name .. "_lib")

include(cwd .. "/conan/conanbuildinfo.premake.lua")

workspace (project_name)
    conan_basic_setup()

    language    "C++"
    cppdialect  "C++17"
    objdir      "obj/"
    warnings    "Extra"
    includedirs "include"
	
    filter { "configurations:debug" }
        defines  "DEBUG"
        symbols  "On"
	optimize "Off"

    filter { "configurations:release" }
        defines  "NDEBUG"
	symbols  "Off"
        optimize "Full"

    filter { "system:windows" }
        systemversion "latest"
        entrypoint    "mainCRTStartup"

project  (project_lib)
    kind      "StaticLib"
    targetdir "bin/%{cfg.buildcfg}/lib"
    files     "src/**.cpp"
    location  "build"
    
project  (project_name)
    kind      "ConsoleApp"
    targetdir "bin/%{cfg.buildcfg}"
    links     (project_lib)
    files     "src/**.cxx"
    location  "build"
    
project "tests"
    kind      "ConsoleApp"
    targetdir "bin/%{cfg.buildcfg}"
    links     (project_lib)
    files     { "tests/**.cxx", "tests/**.cpp" }
    location  "build"

    postbuildcommands {
       "../bin/%{cfg.buildcfg}/tests"
    }
