base: directory cron syslog sshd hosts
	ln -f $(BASE)/config build
	ln -f $(BASE)/init build
	ln -f $(BASE)/scripts/*_prepare.sh build/scripts
	ln -f $(BASE)/scripts/*_boot.sh build/scripts
	ln -f $(BASE)/scripts/*_init.sh build/scripts
	ln -f $(BASE)/scripts/*_runit.sh build/scripts
	ln -f $(BASE)/scripts/*_logrotate.sh build/scripts
	ln -f $(BASE)/scripts/*_utilities.sh build/scripts
	ln -f $(BASE)/scripts/*_cleanup.sh build/scripts