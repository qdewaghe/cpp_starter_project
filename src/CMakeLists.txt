file(GLOB_RECURSE lib_files
  CONFIGURE_DEPENDS ${CMAKE_SOURCE_DIR}/src/*.cpp)

set(clang_tooling
  clangAST
  clangASTMatchers
  clangAnalysis
  clangBasic
  clangDriver
  clangEdit
  clangFrontend
  clangFrontendTool
  clangLex
  clangParse
  clangSema
  clangEdit
  clangRewrite
  clangRewriteFrontend
  clangStaticAnalyzerFrontend
  clangStaticAnalyzerCheckers
  clangStaticAnalyzerCore
  clangIndex
  clangSerialization
  clangToolingCore
  clangTooling
  clangFormat
  clangCodeGen
  clangARCMigrate)

add_library(${project_lib} STATIC ${lib_files})
target_link_libraries(${project_lib} PRIVATE ${CONAN_LIBS})
target_include_directories(${project_lib} PUBLIC ${CMAKE_SOURCE_DIR}/src)

add_executable(${project_name} main.cxx)

target_link_libraries(
  ${project_name}
  PRIVATE ${CONAN_LIBS}
  PRIVATE ${project_lib}
  PRIVATE ${llvm_libs}
  PRIVATE ${clang_tooling}
  )

target_include_directories(
  ${project_name}
  PUBLIC ${CMAKE_SOURCE_DIR}/src
  PUBLIC ${LLVM_INCLUDE_DIRS})

