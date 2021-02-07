add_library(example OBJECT)
add_library(example::example ALIAS example)

target_sources(example
  PRIVATE
  example.cpp
  example.hpp)

target_include_directories(example
  PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR})

target_link_libraries(example
  PRIVATE
  CONAN_PKG::fmt
  main::compile_options)


add_library(example_test SHARED)
add_library(example::tests ALIAS example_test)

target_sources(example_test
  PRIVATE
  example.test.cpp)

target_link_libraries(example_test
  PRIVATE
  CONAN_PKG::doctest
  main::compile_options
  PUBLIC
  example::example)
