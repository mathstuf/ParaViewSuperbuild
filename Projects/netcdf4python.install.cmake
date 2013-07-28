message("COMMAND == ${PREFIX}/bin/python ${SOURCE_DIR}/setup.py install")
execute_process(COMMAND ${PYTHON_EXECUTABLE} setup.py install --prefix=${NETCDF4PYTHON_INSTALL_DIR}
  WORKING_DIRECTORY ${NETCDF4PYTHON_SOURCE_DIR}
  RESULT_VARIABLE rv
)
if(NOT "${rv}" STREQUAL "0")
  message(FATAL_ERROR "netcdf4python.install failed")
endif()
