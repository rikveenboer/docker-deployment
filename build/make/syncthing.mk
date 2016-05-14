syncthing: base
	$(call script,$@)
	$(call runit,$@)
	$(call boot,02,$@)
    