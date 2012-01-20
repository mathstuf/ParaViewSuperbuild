add_external_project(
  ffmpeg
  DEPENDS zlib
  URL "http://ffmpeg.org/releases/ffmpeg-0.6.5.tar.gz"
  URL_MD5 451054dae3b3d33a86c2c48bd12d56e7
  CONFIGURE_COMMAND <SOURCE_DIR>/configure
                    --prefix=<INSTALL_DIR>
                    --disable-avdevice
                    --disable-bzlib
                    --disable-decoders
                    --disable-doc
                    --disable-ffplay
                    --disable-ffprobe
                    --disable-ffserver
                    --disable-network
                    --disable-static
                    --enable-shared
#                    --extra-cflags=${cppflags}
#                    --extra-ldflags=${ldflags}
  BUILD_IN_SOURCE 1
)
