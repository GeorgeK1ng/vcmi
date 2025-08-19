cmake_minimum_required(VERSION 3.20)
project(pickerPlugin LANGUAGES CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

add_library(pickerPlugin SHARED pickerPlugin.cpp)

# UNICODE + Vista/7+ API
target_compile_definitions(pickerPlugin PRIVATE
    UNICODE _UNICODE
    _WIN32_WINNT=0x0600 WINVER=0x0600
)

target_compile_options(pickerPlugin PRIVATE /W4 /EHsc)

target_link_libraries(pickerPlugin PRIVATE ole32 shell32 shlwapi)

if (MSVC AND CMAKE_SIZEOF_VOID_P EQUAL 4)
    target_sources(pickerPlugin PRIVATE pickerPlugin.def)
endif()

set_target_properties(pickerPlugin PROPERTIES
  OUTPUT_NAME pickerPlugin
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
