# Need at least 3.12 for globbing
cmake_minimum_required(VERSION 3.17)

# Renames the project based on the root folder's name 
get_filename_component(project_name
  ${CMAKE_CURRENT_SOURCE_DIR} NAME)

string(REPLACE " " "_" project_name ${project_name})
set(project_lib ${project_name}_lib)
set(unit_tests ${project_name}_unit_tests)
set(ntegration_tests ${project_name}_integration_tests)

# Generates compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(${project_name}
  VERSION 0.0.1
  LANGUAGES CXX)

#if build type isn't specify default to Debug
if (NOT EXISTS ${CMAKE_BINARY_DIR}/CMakeCache.txt)
  if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Debug" CACHE STRING "" FORCE)
  endif()
endif()

# Import a module to handle clang format
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

#Download conan cmake module and include it
if(NOT EXISTS "${CMAKE_SOURCE_DIR}/cmake/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
    "${CMAKE_SOURCE_DIR}/cmake/conan.cmake")
endif()
include(${CMAKE_SOURCE_DIR}/cmake/conan.cmake)

conan_cmake_run(
  REQUIRES
  fmt/7.0.3
  boost/1.74.0
  doctest/2.4.0
  BASIC_SETUP
  BUILD missing)

message(STATUS "Compiler id : " ${CMAKE_CXX_COMPILER_ID})

add_library(warning_options INTERFACE)
target_compile_options(warning_options
  INTERFACE
  $<$<CXX_COMPILER_ID:MSVC>:/W4 /WX>
  $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -pedantic>)

add_subdirectory(src)
add_subdirectory(tests)

set_target_properties(
  ${project_name}
  ${project_lib}
  ${unit_tests}
  ${integration_tests}
  PROPERTIES
  CXX_STANDARD 17
  CXX_STANDARD_REQUIRED ON)