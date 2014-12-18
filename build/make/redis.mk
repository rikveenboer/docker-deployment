redis:
	ln -f $(BASE)/scripts/*_$@.sh build/scripts
	ln -f $(BASE)/runit/$@ build/runit