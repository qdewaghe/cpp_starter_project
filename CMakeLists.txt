# Need at least 3.12 for globbing
cmake_minimum_required(VERSION 3.12...3.15)

if(${CMAKE_VERSION} VERSION_LESS 3.15)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
else()
    cmake_policy(VERSION 3.15)
endif()

# Renames the project based on the root folder's name 
get_filename_component(project_name
  ${CMAKE_CURRENT_SOURCE_DIR} NAME)

string(REPLACE " " "_" project_name ${project_name})
set(project_lib ${project_name}_lib)
set(project_tests ${project_name}_tests)

# Generates compile_commands.json for LSP
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
include(clangformat)

#Download conan cmake module and include it
if(NOT EXISTS "${CMAKE_BINARY_DIR}/conan.cmake")
  message(STATUS "Downloading conan.cmake from https://github.com/conan-io/cmake-conan")
  file(DOWNLOAD "https://raw.githubusercontent.com/conan-io/cmake-conan/master/conan.cmake"
    "${CMAKE_SOURCE_DIR}/cmake/conan.cmake")
endif()
include(${CMAKE_SOURCE_DIR}/cmake/conan.cmake)

conan_cmake_run(
  REQUIRES
  fmt/5.3.0@bincrafters/stable
  boost/1.71.0@conan/stable
  doctest/2.3.1@bincrafters/stable
  BASIC_SETUP
  BUILD missing)

add_subdirectory(src)
add_subdirectory(tests)

message(STATUS "Compiler id : " ${CMAKE_CXX_COMPILER_ID})
# Warnings
if(MSVC)
  add_compile_options(/W4)
else()
  add_compile_options(-Wall -Wextra -pedantic)
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
       add_compile_options (-fdiagnostics-color=always)
    elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
       add_compile_options (-fcolor-diagnostics)
    endif ()
endif()

include(${CMAKE_SOURCE_DIR}/cmake/clang-tidy.cmake)

set_target_properties(
  ${project_name}
  ${project_lib}
  ${project_tests}
  PROPERTIES
  CXX_STANDARD 17
  CXX_STANDARD_REQUIRED ON
  CXX_CLANG_TIDY "${clang_tidy_call}")
