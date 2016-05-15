## Configuration
export_env CSYNC_VERSION 2.0
export_env CSYNC_CONFIG /host/etc/csync/csync2.cfg

## Dependencies
apt_install_permanent librsync-dev libsqlite3-dev libgnutls28-dev pkg-config

## Csync2
cd /opt
wget http://oss.linbit.com/csync2/csync2-$CSYNC_VERSION.tar.gz
tar xzvf csync2-$CSYNC_VERSION.tar.gz
cd csync2-$CSYNC_VERSION
./configure
make
make install
make cert

## xinetd
apt_install_permanent xinetd

## Configuration
cat << EOF > /etc/xinetd.d/csync2
service csync2
{
    disable = no
    protocol = tcp
    socket_type = stream
    wait = no
    user = root
    server = /usr/local/sbin/csync2
    server_args = -i
}
EOF
echo "csync2 30865/tcp" >> /etc/services

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -rf csync2-$CSYNC_VERSION*
fi