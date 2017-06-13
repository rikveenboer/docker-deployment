## Environment
export_env REDIS_CONFIG /etc/redis/redis.conf
export_env REDIS_LOG /host/var/log/redis/redis.log
export_env REDIS_DATA /host/var/lib/redis
export_env REDIS_VERSION stable

## Redis (repository)
apt_install_permanent redis-server

## Reds (compile)
cd /opt
wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz
tar xzf redis-$REDIS_VERSION.tar.gz
cd redis-$REDIS_VERSION
make

## Configuration
mkdir -p `dirname $REDIS_CONFIG`
sed -i "s,^\(daemonize\s*\).*$,\1no," $REDIS_CONFIG
sed -i "s,^\(logfile\s*\).*$,\1$REDIS_LOG," $REDIS_CONFIG
sed -i "s,^\(dir\s*\).*$,\1$REDIS_DATA," $REDIS_CONFIG
