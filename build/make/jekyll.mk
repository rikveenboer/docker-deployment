jekyll:
	sed -i "s,\(FROM\s*\).*,\1grahamc/jekyll:latest\nUSER root," ${FILE}
	$(call file,Gemfile)
	echo 'RUN bundler' >> ${FILE}
	echo 'ENTRYPOINT ["jekyll"]' >> ${FILE}