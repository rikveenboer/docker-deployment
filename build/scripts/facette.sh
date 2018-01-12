## Configuration
export_env FACETTE_VERSION 0.4.0
export_env FACETTE_PACKAGE facette_${FACETTE_VERSION}_$DEBIAN-amd64.deb

## Dependencies
apt_install_permanent librrd8 mime-support

## Older version
export_env FACETTE_VERSION 0.3.0
export_env FACETTE_PACKAGE facette_$FACETTE_VERSION-1.jessie_amd64.deb
echo "deb http://deb.debian.org/debian jessie main" >> /etc/apt/sources.list
apt update
apt_install_permanent librrd4

## Facette
cd /opt
wget https://github.com/facette/facette/releases/download/$FACETTE_VERSION/$FACETTE_PACKAGE
dpkg -i $FACETTE_PACKAGE
mkdir -p /var/run/facette
ln -s /usr/share/facette /usr/local/share/

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm $FACETTE_PACKAGE
fi
