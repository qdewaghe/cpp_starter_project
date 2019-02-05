premake.path    = premake.path .. ";" .. "vendor/conan"
cwd             = os.getcwd()
project_name    = path.rebase("./", cwd, path.getdirectory(cwd))

require "conanbuildinfo"

workspace (project_name)
    architecture    "x64"
    configurations { "debug", "release" }

project  (project_name)

    kind            "ConsoleApp"
    location        "src/"
    language        "C++"
    cppdialect      "C++17"
    targetdir       "build/bin/%{cfg.buildcfg}"
    objdir          "build/obj/%{cfg.buildcfg}"
    warnings        "Extra"  
    staticruntime   "On"
    

    includedirs     { conan_includedirs }
    libdirs         { conan_libdirs }
    links           { conan_libs }
    linkoptions     { conan_exelinkflags }


    files { 
        "src/**.hpp", "src/**.h", 
        "src/**.cxx", "src/**.cpp" 
    }

    filter "configurations:debug"
        defines { "DEBUG", conan_cppdefines }
        symbols "On"

    filter "configurations:release"
        defines { "NDEBUG", conan_cppdefines }
        optimize "On"  

    filter "system:windows"
        systemversion "latest"
        entrypoint "mainCRTStartup"
        defines { "_WIN32_WINNT=0x0501" }

    filter "action:vs*"
        -- disables bugged warning in vs https://github.com/chriskohlhoff/asio/issues/290#issuecomment-377727614
        defines { "_SILENCE_CXX17_ALLOCATOR_VOID_DEPRECATION_WARNING" }


project "tests"
    kind            "ConsoleApp"
    location        "tests/"
    language        "C++"
    cppdialect      "C++17"
    targetdir       "build/bin/%{cfg.buildcfg}/tests"
    objdir          "build/obj/%{cfg.buildcfg}/tests"
    warnings        "Extra"  
    staticruntime   "On"

    includedirs     { conan_includedirs_Catch2 }
    libdirs         { conan_libdirs_Catch2 }

    files { 
        "tests/**.hpp", "tests/**.h", 
        "tests/**.cxx", "tests/**.cpp" 
    }
