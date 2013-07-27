set(ENV{CPPFLAGS} "-I ${INSTALL_DIR}/include")
set(ENV{LDFLAGS} "-L ${INSTALL_DIR}/lib")

execute_process(COMMAND configure
                    --prefix=${INSTALL_DIR}
                    --enable-shared=yes
                    --enable-static=no
                    --enable-netcdf-4
                WORKING_DIRECTORY ${SOURCE_DIR}
                RESULT_VARIABLE rv)
if (NOT "${rv}" STREQUAL "0")
  message(FATAL_ERROR "Failed to c netcdf4 lib")
endif()
