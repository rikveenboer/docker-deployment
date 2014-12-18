hamachi:
	ln -f $(BASE)/scripts/*_$@.sh build/scripts
	ln -f $(BASE)/runit/$@ build/runit
	ln -f $(BASE)/boot/*_$@.sh build/boot