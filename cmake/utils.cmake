function(download_include_conan_module)
  if(NOT EXISTS "${CMAKE_MODULE_PATH}/conan.cmake")
    message(STATUS "Downloading conan.cmake")
    file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
      "${CMAKE_MODULE_PATH}/conan.cmake")
  endif()
  include(conan)
endfunction()

function(get_dir_name out dir)
  get_filename_component(tmp ${dir} NAME)
  string(REPLACE " " "_" ${tmp} ${tmp})
  set(${out} ${tmp} PARENT_SCOPE)
endfunction()

macro(code_coverage_mode)
 if(NOT EXISTS "${CMAKE_MODULE_PATH}/CodeCoverage.cmake")
    message(STATUS "Downloading CodeCoverage.cmake")
    file(DOWNLOAD "https://raw.githubusercontent.com/bilke/cmake-modules/master/CodeCoverage.cmake"
      "${CMAKE_MODULE_PATH}/CodeCoverage.cmake")
  endif()

  include(CodeCoverage)
  append_coverage_compiler_flags()

  set(GCC_COVERAGE_COMPILE_FLAGS "-O0 -coverage -fno-inline -fprofile-dir=${CMAKE_BINARY_DIR}")
  set(GCC_COVERAGE_LINK_FLAGS    "-coverage")
  set(CMAKE_C_FLAGS  "${CMAKE_C_FLAGS} ${GCC_COVERAGE_COMPILE_FLAGS}" )
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${GCC_COVERAGE_LINK_FLAGS}")
endmacro()

macro(build_type_if_not_set build_type)
  if (NOT EXISTS ${CMAKE_BINARY_DIR}/CMakeCache.txt)
    if (NOT CMAKE_BUILD_TYPE)
      set(CMAKE_BUILD_TYPE ${build_type} CACHE STRING "" FORCE)
    endif()
  endif() 
endmacro()

function(force_colored_output)
  if (CMAKE_GENERATOR STREQUAL "Ninja" AND
      ((CMAKE_CXX_COMPILER_ID STREQUAL "GNU") OR
	(CMAKE_CXX_COMPILER_ID STREQUAL "Clang" )))
    add_compile_options(-fdiagnostics-color=always)
  endif()
endfunction()

function(force_standard_cpp)
  set(CMAKE_CXX_STANDARD_REQUIRED ON) 
  set(CMAKE_CXX_EXTENSIONS OFF)
endfunction()
