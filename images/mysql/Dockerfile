FROM ubuntu:precise

RUN apt-get update
RUN apt-get install -y mysql-server 

ENV VERSION stable

#RUN chmod +x /opt/redis-$VERSION/src/redis-server

ENV MYSQL_CONFIG /etc/mysql/my.cnf
ENV MYSQL_LOG /host/var/log/mysql/error.log
ENV MYSQL_DATA  /host/var/lib/mysql

RUN sed -i "s,^\(log_error\s*=\s*\).*$,\1$MYSQL_LOG," $MYSQL_CONFIG
RUN sed -i "s,^\(datadir\s*=\s*\).*$,\1$MYSQL_DATA," $MYSQL_CONFIG

VOLUME [ "/host" ]
EXPOSE 3306

ENV LD_LIBRARY_PATH /root/lib
RUN mkdir $LD_LIBRARY_PATH
RUN cp /lib/x86_64-linux-gnu/libnss_files.so.2 $LD_LIBRARY_PATH
RUN perl -pi -e 's:/etc/hosts:/tmp/hosts:g' $LD_LIBRARY_PATH/libnss_files.so.2

CMD /host/bin/run