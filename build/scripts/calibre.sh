## Configuration
export_env CALIBRE_LIBRARY /host/calibre/library
export_env CALIBRE_LOG /host/calibre.log

## Dependencies
apt_install_permanent python-qt4 xz-utils xdg-utils imagemagick libglu1

## Calibre
cd /opt
wget https://download.calibre-ebook.com/linux-installer.py
unset http_proxy
python linux-installer.py