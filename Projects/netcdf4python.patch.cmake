if(WIN32)
    execute_process(COMMAND
        ${CMAKE_COMMAND} -E copy_if_different
	"${PATCHES_DIR}/netcdf4python.setup.py"
	"${SOURCE_DIR}/setup.py"
    )
endif()