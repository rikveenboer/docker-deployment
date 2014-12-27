FROM ubuntu:precise

RUN apt-get update
RUN apt-get install -y wget gcc make

RUN wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux-libc-dev_3.2.54-2_amd64.deb
RUN dpkg -i linux-libc-dev_3.2.54-2_amd64.deb

RUN apt-get install -y libxml2-dev libcurl4-openssl-dev libbz2-dev libjpeg-dev libpng12-dev libmcrypt-dev

ENV PHP_VERSION 5.5.9

RUN cd /opt && \
    wget http://uk1.php.net/get/php-$PHP_VERSION.tar.gz/from/this/mirror -O  php-$PHP_VERSION.tar.gz && \
    tar xzf php-$PHP_VERSION.tar.gz && \
    cd php-$PHP_VERSION && \
    ./configure --enable-calendar --enable-bcmath --with-bz2 --enable-ctype --without-gdbm --with-iconv --enable-exif --enable-ftp --with-gettext --enable-mbstring --enable-sockets --with-zlib --enable-soap --enable-zip --with-mhash --with-curl --with-gd --with-mysql --with-jpeg-dir --with-openssl --with-mysqli --with-mcrypt && \
    make && \
    make install

#RUN chmod +x /opt/redis-$PHP_VERSION/src/redis-server

#ENV REDIS_CONFIG /etc/redis/redis-server.conf
#ENV REDIS_LOG /host/var/log/redis/redis-server.log
#ENV REDIS_DATA /host/var/lib/redis

#RUN mkdir -p `dirname $REDIS_CONFIG`
#RUN cp /opt/redis-$PHP_VERSION/redis.conf $REDIS_CONFIG
#RUN sed -i "s,^\(logfile\s*\).*$,\1$REDIS_LOG," $REDIS_CONFIG
#RUN sed -i "s,^\(dir\s*\).*$,\1$REDIS_DATA," $REDIS_CONFIG

VOLUME [ "/host" ]
#EXPOSE 80

ENV LD_LIBRARY_PATH /root/lib
RUN mkdir $LD_LIBRARY_PATH
RUN cp /lib/x86_64-linux-gnu/libnss_files.so.2 $LD_LIBRARY_PATH
RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' $LD_LIBRARY_PATH/libnss_files.so.2

#CMD /host/bin/run
CMD top