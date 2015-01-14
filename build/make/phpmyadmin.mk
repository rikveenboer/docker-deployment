phpmyadmin: lighttpd-php
	$(call script,$@)
	$(call boot,02,$@)