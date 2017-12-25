## Configuration
export_env FFMPEG_VERSION 3.3.2
export_env SDK_VERSION 8.0.14
export_env SDK_BASENAME Video_Codec_SDK_$SDK_VERSION
export_env SDK_URL https://www.dropbox.com/s/wel0xazy2c45pqe/$SDK_BASENAME.zip

## Dependencies
apt_install_permanent sudo linux-libc-dev

## Cuda
echo 'deb http://deb.debian.org/debian stretch main contrib non-free' >> /etc/apt/sources.list
apt_install_permanent libcuda1 libnvidia-encode1

## FFmpeg
cd /opt
git clone https://github.com/lutris/ffmpeg-nvenc.git
sed -i "s,\(ffmpeg_version=\).*,\1\"$FFMPEG_VERSION\"," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\(-pie\)\s*\\\,\1," /opt/ffmpeg-nvenc/build.sh
sed -i "s,--enable-x11grab,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,--enable-shared,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,--enable-libvpx,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,--extra-ldexeflags\n,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\(sdk_url=\).*,\1\"$SDK_URL\"," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\(sdk_basename=\).*,\1\"$SDK_BASENAME\"," /opt/ffmpeg-nvenc/build.sh
sed -i "s, BuildVpx, ," /opt/ffmpeg-nvenc/build.sh
/opt/ffmpeg-nvenc/build.sh

## Enable libraries and binaries
mv /opt/ffmpeg-nvenc/ffmpeg-nvenc/ /opt/ffmpeg
rm -r /opt/ffmpeg/lib/pkgconfig
ln -s /opt/ffmpeg/bin/* /usr/bin
ln -s /opt/ffmpeg/lib/* /usr/lib

## Clean installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -r ffmpeg-nvenc
fi
