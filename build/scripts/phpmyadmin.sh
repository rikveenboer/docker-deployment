#!/bin/bash
set -e
source /build/config
set -x

## phpMyAdmin
export_env PMA_VERSION 4.6.0
export_env PMA_ROOT /var/www/html
export_env PMA_CONFIG $PMA_ROOT/config.inc.php
cd /opt
wget https://files.phpmyadmin.net/phpMyAdmin/$PMA_VERSION/phpMyAdmin-$PMA_VERSION-all-languages.tar.gz
tar xzf phpMyAdmin-$PMA_VERSION-all-languages.tar.gz phpMyAdmin-$PMA_VERSION-all-languages
mv phpMyAdmin-$PMA_VERSION-*/ phpMyAdmin-$PMA_VERSION/
rm -r $PMA_ROOT/../*
ln -s /opt/phpMyAdmin-$PMA_VERSION $PMA_ROOT

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

## Remove installation files
if [ $MODE == "minimal" ]; then
    cd /opt
    rm phpMyAdmin-$PMA_VERSION-all-languages.tar.gz
fi
