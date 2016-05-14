## Enable multimedia sources in APT
echo 'deb http://www.deb-multimedia.org jessie main non-free' >> /etc/apt/sources.list
echo 'deb-src http://www.deb-multimedia.org jessie main non-free' >> /etc/apt/sources.list
apt update
apt_install_permanent --force-yes deb-multimedia-keyring

## Encoders
apt_install_permanent --force-yes libmp3lame0 libavcodec-extra* libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev libopenjpeg-dev libx264-dev libfaac-dev