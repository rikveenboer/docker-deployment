#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env FFMPEG_VERSION 2.8.6

## FFmpeg
cd /opt
wget https://github.com/xbmc/FFmpeg/archive/$FFMPEG_VERSION-Jarvis-16.0.tar.gz
tar xvjf ffmpeg-$FFMPEG_VERSION.tar.bz2
cd ffmpeg-$FFMPEG_VERSION
./configure --enable-gpl --enable-postproc --enable-swscale --enable-avfilter --enable-libmp3lame --enable-libvorbis --enable-libtheora --enable-libx264 --enable-libspeex --enable-shared --enable-pthreads --enable-libopenjpeg --enable-libfaac --enable-nonfree
make $JOBS
make install