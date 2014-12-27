FROM ubuntu:trusty
ENV MODE minimal
ENV HOST_ADDR 10.0.2.15
ENV HOST_PORT 8001
RUN apt-get install -y wget
RUN wget -q -P /build $HOST_ADDR:$HOST_PORT/config 
RUN wget -q -P /build $HOST_ADDR:$HOST_PORT/init 
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/prepare.sh | bash
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/cron.sh | bash
RUN mkdir -p /etc/service/cron
RUN wget -q -O /etc/service/cron/run $HOST_ADDR:$HOST_PORT/runit/cron 
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/syslog.sh | bash
RUN mkdir -p /etc/service/syslog
RUN wget -q -O /etc/service/syslog/run $HOST_ADDR:$HOST_PORT/runit/syslog 
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/sshd.sh | bash
RUN mkdir -p /etc/service/sshd
RUN wget -q -O /etc/service/sshd/run $HOST_ADDR:$HOST_PORT/runit/sshd 
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/hosts.sh | bash
RUN wget -q -O /opt/init.d/01_hosts $HOST_ADDR:$HOST_PORT/boot/hosts.sh 
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/init.sh | bash
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/runit.sh | bash
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/logrotate.sh | bash
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/utilities.sh | bash
RUN wget -q -O - $HOST_ADDR:$HOST_PORT/scripts/cleanup.sh | bash
CMD ["/opt/init"]
