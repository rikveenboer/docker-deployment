## Environment
export_env COUCHPOTATO_CONFIG /host/etc/couchpotato/config.ini    
export_env COUCHPOTATO_DATA /host/var/lib/couchpotato

## Dependencies
apt_install_permanent python-openssl python-lxml

## CouchPotato
cd /opt
git clone https://github.com/RuudBurger/CouchPotatoServer.git
