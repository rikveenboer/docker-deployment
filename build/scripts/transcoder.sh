## Environment
export_env LIBDVDCSS_VERSION 1.2.13

## LibDVDCSS
cd /opt
wget http://download.videolan.org/pub/debian/stable/libdvdcss2_$LIBDVDCSS_VERSION-0_amd64.deb
dpkg -i libdvdcss2_$LIBDVDCSS_VERSION-0_amd64.deb

## DVD
apt_install_permanent vobcopy

## Audio
apt_install_permanent --force-yes libmp3lame0 libavcodec-extra* libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev libopenjpeg-dev libx264-* libfaac-dev 

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm libdvdcss2_$LIBDVDCSS_VERSION-0_amd64.deb
fi
