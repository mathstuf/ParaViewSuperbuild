if (BUILD_SHARED_LIBS)
  set(shared yes)
  set(static no)
else ()
  set(shared no)
  set(static yes)
endif ()

add_external_project(
  libxml2
  CONFIGURE_COMMAND <SOURCE_DIR>/configure
                    --prefix=<INSTALL_DIR>
                    --enable-shared=${shared}
                    --enable-static=${static}
  BUILD_IN_SOURCE 1
)
