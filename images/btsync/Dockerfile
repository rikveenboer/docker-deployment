FROM ubuntu:precise

ADD build /build

RUN for s in /build/scripts/*.sh; do [ -x $s ] && $s || : ; done