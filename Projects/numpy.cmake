set (_install_location "<INSTALL_DIR>")
if (WIN32)
  # numpy build has issues with paths containing "C:". So we set the prefix as a
  # relative path.
  set (_install_location "../../../install")
endif()

if (BUILD_SHARED_LIBS)
  add_external_project(numpy
    DEPENDS python
    CONFIGURE_COMMAND ""
    INSTALL_COMMAND
      ${pv_python_executable} setup.py install --prefix=${_install_location}
    BUILD_IN_SOURCE 1
    BUILD_COMMAND
      ${pv_python_executable} setup.py build --fcompiler=no
  )
else ()
  if (USE_SYSTEM_python)
    message(FATAL_ERROR "Static builds with NumPy require a static Python; use the superbuild's Python")
  endif ()
  add_external_project(numpy
    DEPENDS python
    CMAKE_ARGS
      -DPYTHON_EXECUTABLE:FILEPATH=${pv_python_executable}
      -DPYTHON_INCLUDE_DIR:PATH=<INSTALL_DIR>/include/python2.7)
endif ()
