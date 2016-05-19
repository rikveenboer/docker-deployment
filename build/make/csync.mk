csync: base sshd compile
	$(call aux,addr_aliases.c)
	$(call script,$@)
	$(call runit,xinetd)
	$(call runit,lsyncd)
	$(call boot,02,$@)
	$(call boot,02,lsync)
