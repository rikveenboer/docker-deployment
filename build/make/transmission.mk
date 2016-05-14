transmission: base
	$(call script,$@)
	$(call boot,02,$@)
	$(call runit,$@)