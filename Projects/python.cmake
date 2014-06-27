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
  set(extra_args
    -DWITH_THREAD:BOOL=OFF
    -DPYTHON_ALL_BUILTIN:BOOL=ON

    -DENABLE_AUDIOOP:BOOL=OFF
    -DENABLE_BISECT:BOOL=OFF
    -DENABLE_BSDDB:BOOL=OFF
    -DENABLE_BZ2:BOOL=OFF
    -DENABLE_CODECS_CN:BOOL=OFF
    -DENABLE_CODECS_HK:BOOL=OFF
    -DENABLE_CODECS_ISO2022:BOOL=OFF
    -DENABLE_CODECS_JP:BOOL=OFF
    -DENABLE_CODECS_KR:BOOL=OFF
    -DENABLE_CODECS_TW:BOOL=OFF
    -DENABLE_CRYPT:BOOL=OFF
    -DENABLE_CSV:BOOL=OFF
    -DENABLE_CTYPES:BOOL=OFF
    -DENABLE_CTYPES_TEST:BOOL=OFF
    -DENABLE_CURSES:BOOL=OFF
    -DENABLE_CURSES_PANEL:BOOL=OFF
    -DENABLE_DBM:BOOL=OFF
    -DENABLE_ELEMENTTREE:BOOL=OFF
    -DENABLE_FUTURE_BUILTINS:BOOL=OFF
    -DENABLE_GDBM:BOOL=OFF
    -DENABLE_GRP:BOOL=OFF
    -DENABLE_HEAPQ:BOOL=OFF
    -DENABLE_HOTSHOT:BOOL=OFF
    -DENABLE_IO:BOOL=OFF
    -DENABLE_IPV6:BOOL=OFF
    -DENABLE_LINUXAUDIODEV:BOOL=OFF
    -DENABLE_LOCALE:BOOL=OFF
    -DENABLE_LSPROF:BOOL=OFF
    -DENABLE_MMAP:BOOL=OFF
    -DENABLE_MSI:BOOL=OFF
    -DENABLE_MSVCRT:BOOL=OFF
    -DENABLE_MULTIBYTECODEC:BOOL=OFF
    -DENABLE_MULTIPROCESSING:BOOL=OFF
    -DENABLE_NIS:BOOL=OFF
    -DENABLE_NT:BOOL=OFF
    -DENABLE_OSSAUDIODEV:BOOL=OFF
    -DENABLE_PARSER:BOOL=OFF
    -DENABLE_PWD:BOOL=OFF
    -DENABLE_PYEXPAT:BOOL=OFF
    -DENABLE_READLINE:BOOL=OFF
    -DENABLE_RESOURCE:BOOL=OFF
    -DENABLE_SCPROXY:BOOL=OFF
    -DENABLE_SHA:BOOL=OFF
    -DENABLE_SHA256:BOOL=OFF
    -DENABLE_SHA512:BOOL=OFF
    -DENABLE_SOCKET:BOOL=OFF
    -DENABLE_SPWD:BOOL=OFF
    -DENABLE_SQLITE3:BOOL=OFF
    -DENABLE_SSL:BOOL=OFF
    -DENABLE_STROP:BOOL=OFF
    -DENABLE_SUBPROCESS:BOOL=OFF
    -DENABLE_SYSLOG:BOOL=OFF
    -DENABLE_TERMIOS:BOOL=OFF
    -DENABLE_TESTCAPI:BOOL=OFF
    -DENABLE_TKINTER:BOOL=OFF
    -DENABLE_WINREG:BOOL=OFF
    -DENABLE_ZLIB:BOOL=OFF

    # Required for the build.
    -DENABLE_BINASCII:BOOL=ON
    -DENABLE_COLLECTIONS:BOOL=ON
    -DENABLE_CPICKLE:BOOL=ON
    -DENABLE_CSTRINGIO:BOOL=ON
    -DENABLE_DATETIME:BOOL=ON
    -DENABLE_FCNTL:BOOL=ON
    -DENABLE_FUNCTOOLS:BOOL=ON
    -DENABLE_HASHLIB:BOOL=ON
    -DBUILTIN_HASHLIB:BOOL=OFF
    -DENABLE_ITERTOOLS:BOOL=ON
    -DENABLE_JSON:BOOL=ON
    -DENABLE_MATH:BOOL=ON
    -DENABLE_MD5:BOOL=ON
    -DENABLE_OPERATOR:BOOL=ON
    -DENABLE_POSIX:BOOL=ON
    -DENABLE_RANDOM:BOOL=ON
    -DENABLE_SELECT:BOOL=ON
    -DENABLE_STRUCT:BOOL=ON
    -DENABLE_TIME:BOOL=ON
    -DENABLE_UNICODEDATA:BOOL=ON

    # Useful modules with no dependencies.
    -DENABLE_ARRAY:BOOL=OFF
    -DENABLE_CMATH:BOOL=OFF

    )
endif ()

add_external_project_or_use_system(python
  DEPENDS bzip2 zlib png
  CMAKE_ARGS
    -DBUILD_SHARED:BOOL=${shared}
    -DBUILD_STATIC:BOOL=${static}
    -DPy_USING_UNICODE:BOOL=ON
    ${extra_args}
  )
set (pv_python_executable "${install_location}/bin/python" CACHE INTERNAL "" FORCE)
