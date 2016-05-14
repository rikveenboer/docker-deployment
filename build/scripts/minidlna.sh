## Environment
export_env MINIDLNA_VERSION 1.1.1
export_env MINIDLNA_CONFIG /host/etc/minidlna.conf
export_env MINIDLNA_LOG /host/var/log/minidlna.log
export_env MINIDLNA_DATA /host/var/lib/minidlna

## Dependencies
apt_install_permanent gettext libavutil-dev libavcodec-dev libavformat-dev libjpeg-dev libsqlite3-dev libexif-dev libid3tag0-dev libogg-dev libvorbis-dev libFLAC-dev

# MiniDLNA
cd /opt
wget http://downloads.sourceforge.net/project/minidlna/minidlna/$MINIDLNA_VERSION/minidlna-$MINIDLNA_VERSION.tar.gz
tar xzf minidlna-$MINIDLNA_VERSION.tar.gz
cd minidlna-$MINIDLNA_VERSION
./configure
make
make install