cmake_minimum_required(VERSION 3.20)
project(pickerPlugin LANGUAGES CXX)

add_library(modernPicker SHARED pickerPlugin.cpp)
target_compile_definitions(pickerPlugin PRIVATE UNICODE _UNICODE)
target_compile_options(pickerPlugin PRIVATE /W4 /EHsc)
target_link_libraries(pickerPlugin PRIVATE ole32 shell32 shlwapi)

set_target_properties(pickerPlugin PROPERTIES
  OUTPUT_NAME pickerPlugin
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
