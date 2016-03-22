syncthing:
	$(call script,$@)
	$(call runit,$@)
	$(call boot,02,$@)
    