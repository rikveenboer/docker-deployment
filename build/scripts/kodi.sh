## Configuration
export_env KODI_ROOT /opt/kodi-server
export_env KODI_VERSION 16.0
export_env KODI_BRANCH Jarvis

## Build dependencies
apt_install_permanent uuid-dev swig openjdk-7-jre-headless libboost-dev python-dev libglew-dev libmysqlclient-dev libass-dev libmpeg2-4-dev libjpeg-dev libvorbis-dev libcurl4-gnutls-dev libbz2-dev libtiff-dev liblzo2-dev libssl-dev libtinyxml-dev libyajl-dev libxml2-dev libxslt1-dev libsqlite3-dev libpcre3-dev libtag1-dev libjasper-dev libmicrohttpd-dev libxrandr-dev libssh-dev libsmbclient-dev libnfs-dev libavcodec-dev libavfilter-dev libavformat-dev libavutil-dev libpostproc-dev libswscale-dev libiso9660-dev libasound2-dev

## Clone Kodi source
cd /opt
git clone https://github.com/xbmc/xbmc.git -b $KODI_VERSION-$KODI_BRANCH --depth=1

## Patch Kodi source
cd /opt/xbmc
mv /headless.patch .
git apply --reject --whitespace=fix headless.patch

## Compile Kodi
cd /opt/xbmc
./bootstrap
make -C tools/depends/target/crossguid PREFIX=/usr/local
make -C tools/depends/target/libdcadec PREFIX=/usr/local
./configure --prefix=$KODI_ROOT --enable-nfs --enable-nfs --enable-upnp --enable-ssh --with-ffmpeg=shared --disable-libbluray --disable-debug --disable-vdpau --disable-vaapi --disable-vtbdecoder --disable-openmax --disable-joystick --disable-rtmp --disable-airplay --disable-airtunes --disable-dvdcss --disable-optical-drive --disable-libusb --disable-libcec --disable-libcap --disable-asap-codec  --disable-texturepacker --disable-udev --disable-libvorbisenc --disable-dbus  --disable-hal --prefix=$KODI_ROOT # --disable-avahi --disable-alsa --disable-libmp3lame --disable-pulse
make $JOBS
make install
mkdir -p $KODI_ROOT/share/kodi/portable_data/

## Runtime dependencies
apt_install_permanent libssh-4 libmicrohttpd10 libjasper1 libmysqlclient18 liblzo2-2 libtiff5 libglu1-mesa libglew1.10 libpython2.7 libtinyxml2.6.2 libyajl2 libxml2 libxslt1.1 libfribidi0 libpcrecpp0 libfreetype6 libtag1c2a libXrandr2 libsmbclient libx264-146 libvorbisenc2 libtheora0

## Remove unnecessary files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -r xbmc
    apt_remove autotools-dev binutils ca-certificates-java cmake-data cpp fakeroot geoip-database icu-devtools ifupdown iproute2 isc-dhcp-client isc-dhcp-common java-common less libalgorithm-diff-perl libalgorithm-diff-xs-perl libalgorithm-merge-perl libarchive13 libass-dev libasyncns0 libatm1 libatomic1 libavcodec-dev libavfilter-dev libavformat-dev libavresample-dev libavutil-dev libboost-dev libbz2-dev libc-dev-bin libc6-dev libcdio-dev libcdio13 libcilkrts5 libcurl3 libcurl4-gnutls-dev libdpkg-perl libdrm-dev liberror-perl libexpat1-dev libfakeroot libfile-fcntllock-perl libflac8 libfontconfig1-dev libfreetype6-dev libfribidi-dev libgcrypt20-dev libgdbm3 libgeoip1 libgl1-mesa-dev libglew-dev libglu1-mesa-dev  libgnutls-openssl27 libgnutls28-dev  libgnutlsxx28 libgpg-error-dev libharfbuzz-dev libharfbuzz-gobject0 libharfbuzz-icu0 libicu-dev libidn11-dev  libiso9660-8 libiso9660-dev libitm1 libjasper-dev libjbig-dev libjpeg-dev libjson-c2 libjsoncpp1 liblcms2-2 liblsan0 libltdl-dev libltdl7 liblzma-dev liblzo2-dev libmicrohttpd-dev libmpc3 libmpeg2-4 libmpeg2-4-dev libmpfr4 libmysqlclient-dev libnfs-dev libnspr4 libnss3 libogg-dev libp11-kit-dev libpcre3-dev libpcsclite1 libpng12-dev libpostproc-dev libpthread-stubs0-dev libpulse0 libpython-dev libpython2.7-dev libquadmath0 libsctp1 libsigsegv2 libsmbclient-dev libsndfile1 libsqlite3-dev libssh-dev libssl-dev libssl-doc libswresample-dev libswscale-dev libtag1-dev libtasn1-6-dev libtasn1-doc libtiff5-dev libtiffxx5 libtinyxml-dev libtool libtsan0 libubsan0 libvorbis-dev libvorbisfile3 libwrap0 libx11-dev libx11-doc libx11-xcb-dev libxau-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-glx0-dev libxcb-present-dev libxcb-randr0 libxcb-randr0-dev libxcb-render0 libxcb-render0-dev libxcb-shape0 libxcb-shape0-dev libxcb-sync-dev libxcb-xfixes0 libxcb-xfixes0-dev libxcb1-dev libxdamage-dev libxdmcp-dev libxext-dev libxfixes-dev libxml2-dev libxmuu1 libxrandr-dev libxrender-dev libxshmfence-dev libxslt1-dev libxxf86vm-dev libyajl-dev linux-libc-dev m4 make manpages manpages-dev mesa-common-dev netbase nettle-dev openjdk-7-jre-headless swig swig3.0 tcpd tzdata-java unzip uuid-dev x11proto-core-dev x11proto-damage-dev x11proto-dri2-dev x11proto-fixes-dev x11proto-gl-dev x11proto-input-dev x11proto-kb-dev x11proto-randr-dev x11proto-render-dev x11proto-xext-dev x11proto-xf86vidmode-dev xauth xorg-sgml-doctools xtrans-dev
fi
