find_program(
  CLANG_TIDY_EXE
  NAMES "clang-tidy"
  DOC "Path to clang-tidy executable")

if(NOT CLANG_TIDY_EXE)
  message(STATUS "clang-tidy not found.")
else()
  message(STATUS "clang-tidy found: ${CLANG_TIDY_EXE}")
  set(clang_tidy_call "${CLANG_TIDY_EXE}" "-checks=bugprone-*,google-readability-casting,misc,modernize-*,performance-*,readability-*,cppcoreguidelines-*")
endif()
