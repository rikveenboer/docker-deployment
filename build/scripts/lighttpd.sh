## Environment
export_env LIGHTTPD_VERSION_MAJOR 1.4
export_env LIGHTTPD_VERSION_MINOR 45
export_env LIGHTTPD_VERSION $LIGHTTPD_VERSION_MAJOR.$LIGHTTPD_VERSION_MINOR
export_env LIGHTTPD_CONFIG /etc/lighttpd/lighttpd.conf
export_env LIGHTTPD_LOG /host/var/log/lighttpd/error.log

## Dependencies
apt_install_permanent default-libmysqlclient-dev libpcre3-dev

## Lighthttpd
apt_install_permanent lighttpd
# apt-get build-dep -y lighttpd
apt_install_temporary automake
cd /opt
wget http://download.lighttpd.net/lighttpd/releases-$LIGHTTPD_VERSION_MAJOR.x/lighttpd-$LIGHTTPD_VERSION.tar.gz
tar xzf lighttpd-$LIGHTTPD_VERSION.tar.gz && \
cd lighttpd-$LIGHTTPD_VERSION/src
sed -i "s,\(pwd->pw_uid\s==\s\)0,\1-1," server.c
sed -i "s,\(grp->gr_gid\s==\s\)0,\1-1," server.c
cd ..
./configure --with-openssl
make $JOBS
make install

## Configuration
sed -i "s,^\(server.errorlog\s*=\s*\).*$,\1\"$LIGHTTPD_LOG\"," $LIGHTTPD_CONFIG
sed -i "s,^\(server.username\s*=\s*\).*$,\1\"root\"," $LIGHTTPD_CONFIG
sed -i "s,^\(server.groupname\s*=\s*\).*$,\1\"root\"," $LIGHTTPD_CONFIG

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -r lighttpd-$LIGHTTPD_VERSION
    rm lighttpd-$LIGHTTPD_VERSION.tar.gz
fi
