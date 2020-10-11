file(GLOB_RECURSE tests_files
  CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/tests/*.cpp)

add_executable(${project_tests} ${tests_files})

target_link_libraries(
  ${project_tests}
  PRIVATE 
  ${CONAN_LIBS}
  ${project_lib}
  warning_options)

target_include_directories(
  ${project_tests}
  PRIVATE 
  ${CMAKE_SOURCE_DIR}/src)

add_custom_command(
  OUTPUT tests.lic
  COMMAND ${project_tests}
  COMMENT "Running unit tests")

add_custom_target(run_tests ALL DEPENDS tests.lic ${project_name})

