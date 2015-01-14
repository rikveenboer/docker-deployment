webserver: phpmyadmin
	$(call script,$@)
	$(call boot,02,$@)