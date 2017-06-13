jenkins:
	sed -i "s,\(FROM\s*\).*,\1jenkins:2.46.3\nUSER root," ${FILE}
	echo 'ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]' >> ${FILE}
	$(call script,$@)
