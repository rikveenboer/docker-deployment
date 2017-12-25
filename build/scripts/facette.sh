## Configuration
export_env FACETTE_VERSION 0.4.0

## Dependencies
apt_install_permanent librrd4 mime-support wget

## Facette
wget https://github.com/facette/facette/releases/download/$FACETTE_VERSION/facette_$FACETTE_VERSION-1.$DEBIAN_amd64.deb
dpkg -i facette_$FACETTE_VERSION-1.$DEBIAN_amd64.deb
mkdir -p /var/run/facette
ln -s /usr/share/facette /usr/local/share/
