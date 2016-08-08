## Configuration
export_env CALIBRE_LIBRARY /host/calibre/library
export_env CALIBRE_LOG /host/calibre.log

## Dependencies
apt_install_permanent python-qt4 xz-utils xdg-utils imagemagick

## Calibre
cd /opt
PYTHONIOENCODING="utf-8" wget -nv -O- https://raw.githubusercontent.com/kovidgoyal/calibre/master/setup/linux-installer.py | python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"