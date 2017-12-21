## Configuration
export_env BTSYNC_CONFIG /host/etc/btsync/btsync.conf
export_env BTSYNC_DATA /host/var/btsync

## BTsync
cd /opt
wget -O btsync.tar.gz https://download-cdn.resilio.com/stable/linux-x64/resilio-sync_x64.tar.gz
tar xzf btsync.tar.gz rslsync
mv rslsync btsync

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm btsync.tar.gz
fi