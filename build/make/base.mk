base: cron syslog sshd hosts
	$(call script,utilities)
	$(call script,init)
	$(call script,runit)
	$(call script,logrotate)