kodi: base compile transcoder ffmpeg
	$(call aux,headless.patch)
	$(call script,$@)
	$(call runit,$@)
