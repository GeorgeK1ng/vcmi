# Different executables share the output directory. Serialize both Conan copies
# and windeployqt: separate locks would still allow writes to the same DLL.
file(LOCK "${LOCK_FILE}" TIMEOUT 300)

if(DEFINED RUNTIME_LIBS_FILE)
    file(STRINGS "${RUNTIME_LIBS_FILE}" runtimeLibs)
    if(runtimeLibs)
        get_filename_component(targetDir "${TARGET_FILE}" DIRECTORY)
        execute_process(
            COMMAND "${CMAKE_COMMAND}" -E copy_if_different ${runtimeLibs} "${targetDir}"
            RESULT_VARIABLE copy_result
        )
        if(NOT copy_result STREQUAL "0")
            message(FATAL_ERROR "Runtime DLL copy failed with exit code ${copy_result}")
        endif()
    endif()
endif()

if(DEFINED WINDEPLOYQT)
    execute_process(
        COMMAND "${WINDEPLOYQT}"
            --no-compiler-runtime
            --no-translations
            "${TARGET_FILE}"
        RESULT_VARIABLE windeployqt_result
    )

    if(NOT windeployqt_result STREQUAL "0")
        message(FATAL_ERROR
            "windeployqt failed with exit code ${windeployqt_result}")
    endif()
endif()

file(LOCK "${LOCK_FILE}" RELEASE)
