FROM ubuntu:precise

RUN apt-get update
RUN apt-get install -y wget gcc make

ENV REDIS_VERSION stable

RUN cd /opt && \
    wget http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz && \
    tar xzf redis-$REDIS_VERSION.tar.gz && \
    cd redis-$REDIS_VERSION && \
    make

RUN chmod +x /opt/redis-$REDIS_VERSION/src/redis-server

ENV REDIS_CONFIG /etc/redis/redis-server.conf
ENV REDIS_LOG /host/var/log/redis/redis-server.log
ENV REDIS_DATA /host/var/lib/redis

RUN mkdir -p `dirname $REDIS_CONFIG`
RUN cp /opt/redis-$REDIS_VERSION/redis.conf $REDIS_CONFIG
RUN sed -i "s,^\(logfile\s*\).*$,\1$REDIS_LOG," $REDIS_CONFIG
RUN sed -i "s,^\(dir\s*\).*$,\1$REDIS_DATA," $REDIS_CONFIG

VOLUME [ "/host" ]
EXPOSE 6379

ENV LD_LIBRARY_PATH /root/lib
RUN mkdir $LD_LIBRARY_PATH
RUN cp /lib/x86_64-linux-gnu/libnss_files.so.2 $LD_LIBRARY_PATH
RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' $LD_LIBRARY_PATH/libnss_files.so.2

CMD /host/bin/run