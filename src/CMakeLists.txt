file(GLOB_RECURSE lib_files
  CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/src/*.cpp)

add_library(${project_lib} STATIC ${lib_files})

target_link_libraries(${project_lib} PRIVATE ${CONAN_LIBS})

target_include_directories(${project_lib} PUBLIC ${CMAKE_SOURCE_DIR}/src)

add_executable(${project_name} main.cxx)

target_link_libraries(
  ${project_name}
  PRIVATE ${CONAN_LIBS}
  PRIVATE ${project_lib})

target_include_directories(
  ${project_name}
  PUBLIC ${CMAKE_SOURCE_DIR}/src)

#target_clangformat(${project_name})
#target_clangformat(${project_lib})

