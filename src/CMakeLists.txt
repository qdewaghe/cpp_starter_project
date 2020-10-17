add_library(${project_lib})

target_sources(${project_lib}
  PRIVATE
  example/example.cpp)

target_link_libraries(${project_lib} PRIVATE ${CONAN_LIBS})
target_include_directories(${project_lib} PUBLIC ${CMAKE_SOURCE_DIR}/src)

add_executable(${project_name} main.cpp)

target_link_libraries(
  ${project_name}
  PRIVATE 
  ${CONAN_LIBS}
  ${project_lib}
  warning_options)

add_executable(${unit_tests} unit_test_main.cpp)

target_sources(${unit_tests}
  PUBLIC
  example/example.test.cpp)

target_link_libraries(
  ${unit_tests}
  PRIVATE 
  ${CONAN_LIBS}
  ${project_lib}
  gcov)

target_include_directories(
  ${unit_tests}
  PRIVATE ${CMAKE_SOURCE_DIR}/src)

add_custom_command(
  OUTPUT unit_tests.lic
  COMMAND ${unit_tests}
  COMMENT "Running unit tests")
  
add_custom_target(
  run_unit_tests 
  ALL DEPENDS 
  unit_tests.lic 
  ${project_name})