add_executable(${integration_tests} main.cpp)

target_link_libraries(
  ${integration_tests}
  PRIVATE 
  CONAN_PKG::doctest
  src::lib
  main::compile_options)

add_test(${integration_tests} COMMAND ${integration_tests})
