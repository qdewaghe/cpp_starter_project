add_executable(${project_name} main.cpp)
add_executable(src::exe ALIAS ${project_name})

add_library(${project_lib} STATIC)
add_library(src::lib ALIAS ${project_lib})


add_executable(${unit_tests} unit_test_main.cpp)
add_executable(src::tests ALIAS ${unit_tests})

target_link_libraries(
  ${project_name}
  PRIVATE
  main::compile_options
  CONAN_PKG::fmt
  src::lib)

add_test(${unit_tests} COMMAND ${unit_tests})

add_custom_command(
     TARGET ${unit_tests}
     COMMENT "Run unit tests"
     POST_BUILD
     COMMAND ${unit_tests})

add_subdirectory(example)

target_link_libraries(${unit_tests}
  PRIVATE
  main::compile_options
  CONAN_PKG::doctest
  example::tests
  gcov)

target_link_libraries(${project_lib}
  PUBLIC
  CONAN_PKG::fmt
  example::example
  PRIVATE
  main::compile_options)
