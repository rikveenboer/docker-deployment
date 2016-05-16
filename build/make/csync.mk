csync: base sshd compile
	$(call script,$@)
	$(call runit,xinetd)
	$(call boot,02,$@)