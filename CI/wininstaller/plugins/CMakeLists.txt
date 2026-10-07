cmake_minimum_required(VERSION 3.20)
project(installerPlugin LANGUAGES CXX)

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

add_library(installerPlugin SHARED installerPlugin.cpp)

target_compile_definitions(installerPlugin PRIVATE
    UNICODE _UNICODE
    _WIN32_WINNT=0x0601 WINVER=0x0601
)

target_include_directories(installerPlugin PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/../../../lib")
target_compile_features(installerPlugin PRIVATE cxx_std_17)
target_compile_options(installerPlugin PRIVATE /W4 /EHsc)
target_link_libraries(installerPlugin PRIVATE ole32 shell32)

set_target_properties(installerPlugin PROPERTIES
  OUTPUT_NAME installerPlugin
  RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
  ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib"
  LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
