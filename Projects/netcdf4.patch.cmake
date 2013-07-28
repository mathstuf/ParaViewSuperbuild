if(WIN32)
    execute_process(COMMAND
        ${CMAKE_COMMAND} -E copy_if_different
	"${PATCHES_DIR}/netcdf4.cmakelists.txt"
	"${SOURCE_DIR}/CMakeLists.txt"
    )
endif()

execute_process(COMMAND
    ${CMAKE_COMMAND} -E copy_if_different
        "${PATCHES_DIR}/nc-config.in.cmake"
        "${SOURCE_DIR}/nc-config.in.cmake"
)

