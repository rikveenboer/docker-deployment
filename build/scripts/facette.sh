## Dependencies
apt_install_permanent librrd4 mime-support wget

## Facette
wget https://github.com/facette/facette/releases/download/0.3.0/facette_0.3.0-1.jessie_amd64.deb
dpkg -i facette_0.3.0-1.jessie_amd64.deb
mkdir -p /var/run/facette
ln -s /usr/share/facette /usr/local/share/
