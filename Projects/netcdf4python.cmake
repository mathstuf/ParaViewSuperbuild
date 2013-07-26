set (_install_location "<INSTALL_DIR>")
if (WIN32)
  # netcdf4python build has issues with paths containing "C:". So we set the prefix as a
  # relative path.
  set (_install_location "../../../install")
endif()

add_external_project(netcdf4python
  DEPENDS python numpy
  CONFIGURE_COMMAND ""
  INSTALL_COMMAND ""
  BUILD_IN_SOURCE 1
  BUILD_COMMAND
    ${pv_python_executable} setup.py install --prefix=${_install_location}
)
