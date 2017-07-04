## Environment
export_env FFMPEG_VERSION 2.8.6
export_env KODI_VERSION 16.0
export_env KODI_BRANCH Jarvis

## FFmpeg
cd /opt
wget -O ffmpeg-$FFMPEG_VERSION.tar.gz https://github.com/xbmc/FFmpeg/archive/$FFMPEG_VERSION-$KODI_BRANCH-$KODI_VERSION.tar.gz
tar xvzf ffmpeg-$FFMPEG_VERSION.tar.gz
mv FFmpeg-$FFMPEG_VERSION-$KODI_BRANCH-$KODI_VERSION ffmpeg-$FFMPEG_VERSION
cd ffmpeg-$FFMPEG_VERSION
./configure --enable-gpl --enable-postproc --enable-swscale --enable-avfilter --enable-libmp3lame --enable-libvorbis --enable-libtheora --enable-libx264 --enable-libspeex --enable-shared --enable-pthreads --enable-libfaac --enable-nonfree
make $JOBS
make install

## Enable libraries
echo "/usr/local/lib" >> /etc/ld.so.conf
ldconfig
