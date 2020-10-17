add_executable(${integration_tests} main.cpp)

target_link_libraries(
  ${integration_tests}
  PRIVATE 
  ${CONAN_LIBS}
  ${project_lib}
  warning_options)

target_include_directories(
  ${integration_tests}
  PRIVATE 
  ${CMAKE_SOURCE_DIR}/src)

add_custom_command(
  OUTPUT integration_tests.lic
  COMMAND ${ntegration_tests}
  COMMENT "Running integration tests")

add_custom_target(run_integration_tests 
  ALL DEPENDS 
  integration_tests.lic 
  ${project_name})

