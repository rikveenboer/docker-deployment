kodi: encoders
	$(call add,aux/headless.patch,/headless.patch)
	$(call script,$@)
	$(call runit,$@)