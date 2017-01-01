kodi: base compile transcoder ffmpeg-kodi
	$(call aux,headless.patch)
	$(call script,$@)
	$(call runit,$@)
