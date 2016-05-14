apt_install_permanent syslog-ng-core
mkdir -p /var/lib/syslog-ng
sed -i "s/^\(#SYSLOGNG_OPTS=\).*$/\1\"--no-caps --default-modules=affile,afprog,afsocket,afuser,basicfuncs,csvparser,dbparser,syslogformat\"/" /etc/default/syslog-ng