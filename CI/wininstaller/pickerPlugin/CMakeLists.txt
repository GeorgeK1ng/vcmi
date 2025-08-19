cmake_minimum_required(VERSION 3.20)
project(pickerPlugin LANGUAGES CXX)

# Static CRT /MT a /MTd
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

add_library(pickerPlugin SHARED pickerPlugin.cpp)

# UNICODE + Vista+ API
target_compile_definitions(pickerPlugin PRIVATE
    UNICODE _UNICODE
    _WIN32_WINNT=0x0600 WINVER=0x0600
)

target_compile_options(pickerPlugin PRIVATE /W4 /EHsc)
target_link_libraries(pickerPlugin PRIVATE ole32 shell32 shlwapi)
target_link_options(pickerPlugin PRIVATE "/EXPORT:ModernPickFolder=_ModernPickFolder@20")

set_target_properties(pickerPlugin PROPERTIES
  OUTPUT_NAME pickerPlugin
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
