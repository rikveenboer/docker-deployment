headphones: base encoders ffmpeg
	$(call script,$@)
	$(call boot,02,$@)
	$(call runit,$@)