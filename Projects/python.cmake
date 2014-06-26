if (APPLE)
  message(FATAL_ERROR "ABORT")
endif()

set(shared ${BUILD_SHARED_LIBS})
if (BUILD_SHARED_LIBS)
  set(static OFF)
else ()
  set(static ON)
endif ()
if (CROSS_BUILD_STAGE STREQUAL "TOOLS")
  set(shared OFF)
  set(static ON)
endif()

set(extra_args)
if (static)
  list(APPEND extra_args
    -DWITH_THREAD:BOOL=OFF
    -DPYTHON_ALL_BUILTIN:BOOL=ON
    -DENABLE_CURSES:BOOL=OFF
    -DENABLE_CURSES_PANEL:BOOL=OFF
    -DENABLE_MULTIPROCESSING:BOOL=OFF
    -DENABLE_TKINTER:BOOL=OFF
    -DBUILTIN_CRYPT:BOOL=OFF
    -DBUILTIN_CTYPES:BOOL=OFF
    -DBUILTIN_ELEMENTTREE:BOOL=OFF
    -DBUILTIN_EXPAT:BOOL=OFF
    -DBUILTIN_NIS:BOOL=OFF
    -DBUILTIN_PYEXPAT:BOOL=OFF
    -DBUILTIN_TESTCAPI:BOOL=OFF)
endif ()

if (WIN32)
  # Requires OpenSSL. Should look into how to avoid this altogether since the
  # stock build obviously used something else.
  list(APPEND extra_args
    -DENABLE_HASHLIB:BOOL=OFF
    -DENABLE_SSL:BOOL=OFF)
endif ()

add_external_project_or_use_system(python
  DEPENDS bzip2 zlib png
  CMAKE_ARGS
    -DBUILD_SHARED:BOOL=${shared}
    -DBUILD_STATIC:BOOL=${static}
    -DPy_USING_UNICODE:BOOL=ON
    ${extra_args}
  )
if (NOT CROSS_BUILD_STAGE STREQUAL "CROSS" AND NOT MSVC)
  # Pass the -rpath flag when building python to avoid issues running the
  # executable we built.
  append_flags(LDFLAGS "-Wl,-rpath,${install_location}/lib" PROJECT_ONLY)
endif()

set (pv_python_executable "${install_location}/bin/python" CACHE INTERNAL "" FORCE)

add_extra_cmake_args(
  -DVTK_PYTHON_VERSION=2.7
)
