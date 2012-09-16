# script to "bundle" paraview.

#------------------------------------------------------------------------------
# include common stuff.

# setting PARAVIEW_INSTALL_MANUAL_PDF ensures that paraview.bundle.common
# will download and install the manual pdf.
set (PARAVIEW_INSTALL_MANUAL_PDF TRUE)
include(paraview.bundle.common)

# set NSIS install specific stuff.

# URL to website providing assistance in installing your application.
set (CPACK_NSIS_HELP_LINK "http://paraview.org/Wiki/ParaView")
set (CPACK_NSIS_MENU_LINKS
  "doc/ParaViewUsersGuide.v${pv_version}.pdf" "ParaView User's Guide"
  "bin/paraview.exe" "ParaView"
  "bin/pvserver.exe" "pvserver (Server)"
  "bin/pvdataserver.exe" "pvdataserver (Data-Server)"
  "bin/pvrenderserver.exe" "pvrenderserver (Render-Server)")
if (python_ENABLED)
  set (CPACK_NSIS_MENU_LINKS ${CPACK_NSIS_MENU_LINKS}
    "bin/pvpython.exe" "pvpython (Python Shell)")
endif()

#FIXME: need a pretty icon.
#set (CPACK_NSIS_MUI_ICON "${CMAKE_CURRENT_LIST_DIR}/paraview.ico")
set (CPACK_NSIS_MUI_FINISHPAGE_RUN "bin/paraview.exe")

include(CPack)
#------------------------------------------------------------------------------

# install paraview executables to bin.
foreach(executable
  paraview pvbatch pvdataserver pvpython pvrenderserver pvserver)
  install(PROGRAMS "${install_location}/bin/${executable}.exe"
    DESTINATION "bin"
    COMPONENT ParaView)
endforeach()

# install all dlls to bin. This will install all VTK/ParaView dlls plus any
# other tool dlls that were placed in bin.
install(DIRECTORY "${install_location}/bin/"
        DESTINATION "bin"
        USE_SOURCE_PERMISSIONS
        COMPONENT ParaView
        FILES_MATCHING PATTERN "*.dll")

# install the .plugins file
install(FILES "${install_location}/bin/.plugins"
        DESTINATION "bin"
        COMPONENT ParaView)

# install python since (since python dlls are not in the install location)
if (python_ENABLED AND NOT USE_SYSTEM_python)
  # install the Python's modules.
  install(DIRECTORY "${ParaViewSuperBuild_BINARY_DIR}/python/src/python/Lib"
          DESTINATION "bin"
          USE_SOURCE_PERMISSIONS
          COMPONENT ParaView)

  # install python dlls.
  get_filename_component(python_bin_dir "${pv_python_executable}" PATH)
  install(DIRECTORY "${python_bin_dir}/"
          DESTINATION "bin"
          USE_SOURCE_PERMISSIONS
          COMPONENT ParaView
          FILES_MATCHING PATTERN "python*.dll")

  if (numpy_ENABLED)
    install(DIRECTORY "${install_location}/lib/site-packages/numpy"
            DESTINATION "bin/Lib/site-packages"
            USE_SOURCE_PERMISSIONS
            COMPONENT ParaView)
  endif()
endif()

if (qt_ENABLED AND NOT USE_SYSTEM_qt)
  install(DIRECTORY
    # install all qt plugins (including sqllite).
    # FIXME: we can reconfigure Qt to be built with inbuilt sqllite support to 
    # avoid the need for plugins.
    "${install_location}/plugins/"
    DESTINATION "bin"
    COMPONENT ParaView
    PATTERN "*.dll")
endif()

# install paraview python modules and others.
install(DIRECTORY "${install_location}/lib/paraview-${pv_version}"
        DESTINATION "lib"
        USE_SOURCE_PERMISSIONS
        COMPONENT ParaView
        PATTERN "*.lib" EXCLUDE)

# install system runtimes.
set(CMAKE_INSTALL_SYSTEM_RUNTIME_DESTINATION "bin")
include(InstallRequiredSystemLibraries)

#-----------------------------------------------------------------------------
#if (mpich2_ENABLED AND NOT USE_SYSTEM_mpich2)
#  install(PROGRAMS "@install_location@/bin/mpiexec.hydra"
#    DESTINATION "lib/paraview-${pv_version}"
#    COMPONENT ParaView
#    RENAME "mpiexec")
#  foreach (hydra_exe hydra_nameserver hydra_persist hydra_pmi_proxy)
#    install(PROGRAMS "@install_location@/bin/${hydra_exe}"
#      DESTINATION "lib/paraview-${pv_version}"
#      COMPONENT ParaView)
#  endforeach()
#endif()

add_test(NAME GenerateParaViewPackage
         COMMAND ${CMAKE_CPACK_COMMAND} -G NSIS -V
         WORKING_DIRECTORY ${ParaViewSuperBuild_BINARY_DIR})
set_tests_properties(GenerateParaViewPackage PROPERTIES
                     # needed so that tests are run on typical paraview
                     # dashboards
                     LABELS "PARAVIEW"
                     TIMEOUT 1200) # increase timeout to 20 mins.