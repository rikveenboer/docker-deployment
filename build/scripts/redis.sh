#!/bin/bash
set -e
source /build/config
set -x

## Redis
apt_install_permanent redis-server

export REDIS_CONFIG=/etc/redis/redis.conf
export REDIS_LOG=/host/var/log/redis/redis.log
export REDIS_DATA=/host/var/lib/redis

sed -i "s,^\(daemonize\s*\).*$,\1no," $REDIS_CONFIG
sed -i "s,^\(logfile\s*\).*$,\1$REDIS_LOG," $REDIS_CONFIG
sed -i "s,^\(dir\s*\).*$,\1$REDIS_DATA," $REDIS_CONFIG

## Runit script
mkdir /etc/service/redis
mv /build/runit/redis /etc/service/redis/run

## Environment variables
echo -n $REDIS_CONFIG > /etc/container_environment/REDIS_CONFIG
echo -n $REDIS_LOG > /etc/container_environment/REDIS_LOG
echo -n $REDIS_DATA > /etc/container_environment/REDIS_DATA


## TODO
# ENV REDIS_VERSION stable

# RUN cd /opt && \
    # wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz && \
    # tar xzf redis-$REDIS_VERSION.tar.gz && \
    # cd redis-$REDIS_VERSION && \
    # make

# RUN chmod +x /opt/redis-$REDIS_VERSION/src/redis-server

# ENV REDIS_CONFIG /etc/redis/redis-server.conf
# ENV REDIS_LOG /host/var/log/redis/redis-server.log
# ENV REDIS_DATA /host/var/lib/redis

# RUN mkdir -p `dirname $REDIS_CONFIG`
# RUN cp /opt/redis-$REDIS_VERSION/redis.conf $REDIS_CONFIG
# RUN sed -i "s,^\(logfile\s*\).*$,\1$REDIS_LOG," $REDIS_CONFIG
# RUN sed -i "s,^\(dir\s*\).*$,\1$REDIS_DATA," $REDIS_CONFIG