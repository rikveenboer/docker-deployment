kodi: base encoders ffmpeg
	$(call aux,headless.patch)
	$(call script,$@)
	$(call runit,$@)