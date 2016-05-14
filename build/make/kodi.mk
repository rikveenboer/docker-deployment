kodi: base encoders
	$(call file,headless.patch)
	$(call script,$@)
	$(call runit,$@)