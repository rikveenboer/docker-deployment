headphones: base encoders
	$(call script,ffmpeg)
	$(call script,$@)
	$(call boot,02,$@)
	$(call runit,$@)