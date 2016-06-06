csync: base sshd compile
	$(call aux,addr_aliases.c)
	$(call script,$@)
	$(call runit,csync)
	$(call runit,lsyncd)
	$(call boot,02,$@)
	$(call boot,03,lsyncd)
