cmake_minimum_required(VERSION 3.20)
project(modernPicker LANGUAGES CXX)

add_library(modernPicker SHARED modernPicker.cpp)
target_compile_definitions(modernPicker PRIVATE UNICODE _UNICODE)
target_compile_options(modernPicker PRIVATE /W4 /EHsc)
target_link_libraries(modernPicker PRIVATE ole32 shell32 shlwapi)

set_target_properties(modernPicker PROPERTIES
  OUTPUT_NAME modernPicker
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
