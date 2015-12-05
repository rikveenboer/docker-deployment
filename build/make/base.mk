base: syslog sshd hosts
	$(call script,init)
	$(call script,runit)
	$(call script,logrotate)
	$(call script,utilities)