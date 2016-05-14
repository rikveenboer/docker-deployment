## Environment
export_env HAMACHI_DATA /host/var/lib/logmein-hamachi
export_env HAMACHI_VERSION 2.1.0.119

## Dependencies
apt_install_permanent lsb-core net-tools socat strace

## Hamachi
wget -P /opt -O hamachi.deb https://secure.logmein.com/labs/logmein-hamachi_$HAMACHI_VERSION-1_amd64.deb