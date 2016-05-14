webserver: base lighttpd-php phpmyadmin
	$(call script,$@)
	$(call boot,02,$@)