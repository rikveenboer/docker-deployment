base: cron syslog sshd
	$(call script,utilities)
	$(call script,init)
	$(call script,runit)
	$(call script,logrotate)