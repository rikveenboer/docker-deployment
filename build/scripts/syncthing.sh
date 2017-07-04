## Configuration
export_env SYNCTHING_CONFIG /host/etc/syncthing
export_env SYNCTHING_VERSION 0.14.30

# Syncthing
cd /opt
curl -L -o syncthing.tar.gz https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-amd64-v$SYNCTHING_VERSION.tar.gz
tar xzf syncthing.tar.gz
rm -f syncthing.tar.gz
mv syncthing-linux-amd64-v* syncthing
rm -rf syncthing/etc
rm -rf syncthing/*.pdf
mkdir -p $SYNCTHING_CONFIG
