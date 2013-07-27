add_external_project(netcdf4
  DEPENDS hdf5 zlib szip
  BUILD_IN_SOURCE 0
  PATCH_COMMAND
    ${CMAKE_COMMAND} -E copy_if_different
        "${SuperBuild_PROJECTS_DIR}/patches/nc-config.in.cmake"
        "<SOURCE_DIR>/nc-config.in.cmake"
  CMAKE_ARGS
    -DENABLE_NETCDF_4:BOOL=TRUE
    -DHDF5_DIR:PATH=<INSTALL_DIR>
    -DBUILD_SHARED_LIBS:BOOL=TRUE
    -DBUILD_V2:BOOL=TRUE
    -DENABLE_DAP:BOOL=FALSE
 )
