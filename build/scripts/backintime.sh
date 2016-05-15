## Configuration
export_env BACKINTIME_VERSION 1.1.12

## Dependencies
apt_install_permanent gettext python3 python3-dbus

## Back In Time
cd /opt
wget https://github.com/bit-team/backintime/releases/download/v1.1.10/backintime-$BACKINTIME_VERSION.tar.gz
tar zxvf backintime-$BACKINTIME_VERSION.tar.gz
cd backintime-$BACKINTIME_VERSION/common
./configure
make
make install
sed -i 's,^ssh-agent,,' /usr/bin/backintime

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm -rf backintime-$BACKINTIME_VERSION*
fi