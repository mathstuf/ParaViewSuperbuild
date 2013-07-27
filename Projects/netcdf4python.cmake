set (_install_location "<INSTALL_DIR>")
if (WIN32)
  set (_install_location "../../../install")
endif()

# BUILD_COMMAND can't handle spaces in the executable name. Worse, for
# Makefile builds, it writes out a cmake script where ${CMAKE_COMMAND} can
# be expanded, while on ninja builds it just adds a new build rule to
# the build.ninja file, where ${CMAKE_COMMAND} cannot be interpreted. This
# should work if either (a) A Makefile generator is used with or without
# spaces in the CMake command path, or (b) Ninja is used with no spaces
# in the path.
set(SAFE_CMAKE_COMMAND "\\\${CMAKE_COMMAND}")
if(${CMAKE_GENERATOR} STREQUAL "Ninja")
  set(SAFE_CMAKE_COMMAND "${CMAKE_COMMAND}")
endif()

add_external_project(netcdf4python
  DEPENDS python numpy hdf5 zlib netcdf4
  CONFIGURE_COMMAND ""
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  BUILD_COMMAND
    "${SAFE_CMAKE_COMMAND}" -DPYTHON_EXECUTABLE:PATH=${pv_python_executable}
                            -DNETCDF4PYTHON_SOURCE_DIR:PATH=<SOURCE_DIR>
                            -DNETCDF4PYTHON_INSTALL_DIR:PATH=${_install_location}
                            -DNUMPY_INSTALL_DIR:PATH=<INSTALL_DIR>
                            -P ${SuperBuild_PROJECTS_DIR}/netcdf4python.build.cmake
)
