## Configuration
export_env CSYNC_VERSION 2.0
export_env CSYNC_CONFIG /host/etc/csync/csync2.cfg
export_env CSYNC_DATABASE /host/var/lib/csync
export_env CSYNC_LOG /host/var/log/csync.log
export_env LSYNC_CONFIG /host/etc/lsyncd.conf
export_env LSYNC_LOG /host/var/log/lsyncd.log
export_env LSYNC_STATUS /host/var/log/lsyncd_status.log
export_env HOSTALIASES /host/etc/host_aliases

## Dependencies
apt_install_permanent librsync-dev libsqlite3-dev libgnutls28-dev pkg-config

## Csync2
cd /opt
wget http://oss.linbit.com/csync2/csync2-$CSYNC_VERSION.tar.gz
tar xzvf csync2-$CSYNC_VERSION.tar.gz
cd csync2-$CSYNC_VERSION
./configure
sed -i 's/\(verify_peername(\(const[^)]*\))\)/\1 {return 1;} int disabled(\2)/' daemon.c
make
make install
make cert

## Address aliases
cd /opt
mv /addr_aliases.c .
gcc -fPIC -shared -o addr_aliases.so addr_aliases.c -ldl
mkdir -p /host/etc/
touch /host/etc/addr_aliases
echo /opt/addr_aliases.so >> /etc/ld.so.preload

## Lsyncd dependencies
apt_install_permanent lua5.2 liblua5.2-dev bash-completion

## Lsyncd
cd /opt
git clone https://github.com/axkibe/lsyncd.git
cd lsyncd
mkdir build
cd build
cmake ..
sed -i 's,a2x,#,' CMakeFiles/manpage.dir/build.make
make
make install

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -rf csync2-$CSYNC_VERSION*
    rm -r lsyncd
fi