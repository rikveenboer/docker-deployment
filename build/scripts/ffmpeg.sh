## Configuration
export_env FFMPEG_VERSION 3.3.2
export_env SDK_VERSION 8.0.14
export_env SDK_BASENAME Video_Codec_SDK_$SDK_VERSION
export_env SDK_URL https://www.dropbox.com/s/wel0xazy2c45pqe/$SDK_BASENAME.zip

## Dependencies
apt_install_permanent sudo linux-libc-dev

## FFmpeg
cd /opt
git clone https://github.com/lutris/ffmpeg-nvenc.git
sed -i "s,\(ffmpeg_version=\).*,\1\"$FFMPEG_VERSION\"," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\s*--enable-x11grab \\\s*,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\s*--enable-shared \\\s*,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\s*--extra-ldexeflags.*,," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\(sdk_url=\).*,\1\"$SDK_URL\"," /opt/ffmpeg-nvenc/build.sh
sed -i "s,\(sdk_basename=\).*,\1\"$SDK_BASENAME\"," /opt/ffmpeg-nvenc/build.sh
/opt/ffmpeg-nvenc/build.sh

## Enable libraries and binaries
mv /opt/ffmpeg-nvenc/ffmpeg-nvenc/ /opt/ffmpeg
echo "/opt/ffmpeg/lib" >> /etc/ld.so.conf
ldconfig
ln -s /opt/ffmpeg/bin/* /usr/local/bin

## Clean installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -r ffmpeg-nvenc
fi
