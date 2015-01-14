#!/bin/bash
set -e
source /build/config
set -x

## phpMyAdmin
export_env PMA_VERSION 4.3.6
export_env PMA_CONFIG /var/www/config.inc.php
cd /opt
wget http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin/$PMA_VERSION/phpMyAdmin-$PMA_VERSION-all-languages.tar.gz -O phpMyAdmin-$PMA_VERSION.tar.gz
tar xzf phpMyAdmin-$PMA_VERSION.tar.gz
mv phpMyAdmin-$PMA_VERSION-* phpMyAdmin-$PMA_VERSION
rm -r /var/www
ln -s /opt/phpMyAdmin-$PMA_VERSION /var/www

## Remove installation files
if [ $MODE == "minimal" ]; then
    rm phpMyAdmin-$PMA_VERSION.tar.gz
fi

## Configuration
cat << EOF > $PMA_CONFIG
<?php
\$cfg['blowfish_secret'] = 'random';
\$cfg['Servers'][1]['auth_type'] = 'cookie';
\$cfg['Servers'][1]['connect_type'] = 'tcp';
\$cfg['Servers'][1]['host'] = 'mysql';
\$cfg['Servers'][1]['compress'] = false;
\$cfg['Servers'][1]['extension'] = 'mysqli';
\$cfg['Servers'][1]['AllowNoPassword'] = true;
EOF