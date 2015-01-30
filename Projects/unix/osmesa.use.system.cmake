find_path(OPENGL_INCLUDE_DIR GL/gl.h)
find_library(OPENGL_glu_LIBRARY GLU)
find_path(OSMESA_INCLUDE_DIR GL/osmesa.h)
find_library(OSMESA_LIBRARY OSMesa)

add_extra_cmake_args(
  -DOPENGL_INCLUDE_DIR:PATH=${OPENGL_INCLUDE_DIR}
  -DOPENGL_gl_LIBRARY:FILEPATH=
  -DOPENGL_glu_LIBRARY:FILEPATH=${OPENGL_glu_LIBRARY}
  -DOSMESA_INCLUDE_DIR:PATH=${OSMESA_INCLUDE_DIR}
  -DOSMESA_LIBRARY:FILEPATH=${OSMESA_LIBRARY}
)
