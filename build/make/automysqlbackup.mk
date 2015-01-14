automysqlbackup:
	$(call script,$@)
	$(call boot,02,$@)