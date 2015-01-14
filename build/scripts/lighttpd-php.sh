#!/bin/bash
set -e
source /build/config
set -x

## Environment
export_env PHP_CGI_PORT 5555
export_env PHP_CONFIG /host/etc/php.ini

## Enable configuration of PHP in Lighttpd
ln -s /etc/lighttpd/conf-available/10-fastcgi.conf /etc/lighttpd/conf-enabled/
cat << EOF > /etc/lighttpd/conf-enabled/15-fastcgi-php.conf
fastcgi.server += (
    ".php" => (
        "localhost" =>(
            "host" => "127.0.0.1",
            "port" => $PHP_CGI_PORT
        )
    )
)
EOF

## Workaround for PHP socket
# sed -i "s,\(\"socket\"\s*=>\s*\"\).*$,\1/tmp/php.socket\"\,," /etc/lighttpd/conf-enabled/15-fastcgi-php.conf