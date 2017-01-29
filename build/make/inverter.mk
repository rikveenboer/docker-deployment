inverter: base php
	$(call script,$@)
	$(call boot,02,$@)
	$(call runit,cron)
