## Configuration
export_env FACETTE_VERSION 0.5.1
export_env UBUNTU bionic
export_env FACETTE_PACKAGE facette_${FACETTE_VERSION}_$UBUNTU-amd64.deb

## Dependencies
apt_install_permanent librrd8 mime-support daemon

## Facette
cd /opt
wget https://github.com/facette/facette/releases/download/$FACETTE_VERSION/$FACETTE_PACKAGE
dpkg -i $FACETTE_PACKAGE

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm $FACETTE_PACKAGE
fi
