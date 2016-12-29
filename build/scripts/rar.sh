## Environment
export_env RAR_VERSION 5.4.0

## Rar
cd /opt
wget http://www.rarlab.com/rar/rarlinux-x64-$RAR_VERSION.tar.gz
tar xzf rarlinux-x64-$RAR_VERSION.tar.gz
ln -s /opt/rar/rar /usr/bin


## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm rarlinux-x64-$RAR_VERSION.tar.gz
fi