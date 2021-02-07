cmake_minimum_required(VERSION 3.17)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(utils)

get_dir_name(project_name ${CMAKE_CURRENT_SOURCE_DIR})
set(project_lib ${project_name}_lib)
set(unit_tests ${project_name}_unit_tests)
set(integration_tests ${project_name}_integration_tests)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(${project_name}
  VERSION 0.0.1
  LANGUAGES CXX)

include(CTest)

force_colored_output()
build_type_if_not_set("Debug")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  code_coverage_mode()
  append_coverage_compiler_flags()
endif()

download_include_conan_module()

conan_cmake_run(
  REQUIRES
  fmt/7.1.3
  doctest/2.4.4
  BASIC_SETUP CMAKE_TARGETS
  BUILD missing)

message(STATUS "Compiler id: " ${CMAKE_CXX_COMPILER_ID})


add_library(compile_options INTERFACE)
add_library(main::compile_options ALIAS compile_options)

target_compile_options(compile_options
  INTERFACE
  $<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
  $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>)

target_compile_features(
  compile_options
  INTERFACE
  cxx_std_20)

force_standard_cpp()

add_subdirectory(src)
add_subdirectory(tests)

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  setup_target_for_coverage_lcov(
    NAME coverage
    LCOV_ARGS "--no-external"
    EXECUTABLE ${unit_tests}
    EXCLUDE "src/main.cpp")
endif()
