csync: base compile
	$(call script,$@)
	$(call runit,xinetd)
	$(call boot,02,$@)