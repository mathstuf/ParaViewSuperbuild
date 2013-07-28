# Find the location of numpy
file(GLOB_RECURSE numpy-egg "${NUMPY_INSTALL_DIR}/lib/*.egg-info")
# message("${NUMPY_INSTALL_DIR}/lib/*.egg-info \n ${numpy-egg} --- ")
if (NOT numpy-egg)
  message(FATAL_ERROR "Failed to locate numpy-egg")
endif()

set (pythonpath $ENV{PYTHONPATH})
if (WIN32)
  set (separator ";")
else()
  set (separator ":")
endif()

# since we may find multiple eggs (or may not), just loop over all of them.
foreach(egg ${numpy-egg})
  get_filename_component(dir "${egg}" PATH)
  if (pythonpath)
    set (pythonpath "${pythonpath}${separator}${dir}")
  else()
    set (pythonpath "${dir}")
  endif()
endforeach()
set (ENV{PYTHONPATH} "${pythonpath}")
message ("PYTHONPATH : ${pythonpath}")

# Supporting netcdf 4.1.2 or higher for now
# If you are using netcdf 4.1.2 or higher,
# instead of setting all those enviroment variables defining where
# libs are installed, you can just set one environment variable, USE_NCCONFIG, to 1.
# This will tell python to run the netcdf nc-config utility to
# determine where all the dependencies live.
set(ENV{USE_NCCONFIG})
set(ENV{HDF5_INCDIR} "${HDF5_DIR}/include")
set(ENV{HDF5_LIBDIR} "${HDF5_DIR}/lib")
set(ENV{NETCDF4_DIR} "${NETCDF4_DIR}")
set(ENV{NETCDF4_INCDIR} "${NETCDF4_DIR}/include")
set(ENV{NETCDF4_LIBDIR} "${NETCDF4_DIR}/lib")

execute_process(COMMAND ${PYTHON_EXECUTABLE} setup.py install --prefix=${NETCDF4PYTHON_INSTALL_DIR}
  WORKING_DIRECTORY ${NETCDF4PYTHON_SOURCE_DIR}
  RESULT_VARIABLE rv
)
if(NOT "${rv}" STREQUAL "0")
  message(FATAL_ERROR "netcdf4python install failed")
endif()
