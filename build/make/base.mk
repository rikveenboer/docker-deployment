base:
	$(call add,init,/opt/init)
	@echo 'RUN chmod +x /opt/init' >> ${FILE}
	@echo 'CMD ["/opt/init"]' >> ${FILE}
	$(call script,utilities)
	$(call script,runit)