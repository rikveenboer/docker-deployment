## Dependencies
apt_install_permanent zip sudo

## FFmpeg
cd /opt
git clone https://github.com/lutris/ffmpeg-nvenc.git
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
