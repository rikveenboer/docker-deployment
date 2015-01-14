lighttpd-php: php lighttpd
	$(call script,$@)
	$(call boot,02,$@)
	$(call runit,$@)