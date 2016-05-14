automysqlbackup: base
	$(call script,$@)
	$(call boot,02,$@)