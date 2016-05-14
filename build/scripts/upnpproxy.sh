## Dependency
apt_install_permanent uuid-dev

## UPnP Proxy
cd /opt
git clone git://git.savannah.nongnu.org/upnpproxy.git
cd upnpproxy
autoreconf || automake --add-missing
./configure
make
make install