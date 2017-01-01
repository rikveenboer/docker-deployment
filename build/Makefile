FROM = debian:jessie
MODE = minimal
PROXY = $(shell ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | cut -d' ' -f1)
TIMEZONE = Europe/Amsterdam
JOBS = 2
CLEANUP = true
ARGS = --rm=false --no-cache=false
include $(wildcard $(DOCKER_HOME)/build/make/*.mk)

define add
	@echo 'ADD $(1) $(2)' >> ${FILE}
endef

define aux
    $(call add,files/$(1),/$(1))
endef

define execute
	$(call add,$(1),$(2))
	@echo 'RUN $(2)' >> ${FILE}
endef

define boot
	@$(eval TARGET = '/opt/init.d/$(1)_$(2)')
	$(call add,boot/$(2).sh,$(TARGET))
	@echo 'RUN chmod +x $(TARGET)' >> ${FILE}
endef

define runit
	@$(eval TARGET = '/etc/service/$(1)/run')
	$(call add,runit/$(1),$(TARGET))
	@echo 'RUN mkdir -p /etc/service/$(1)' >> ${FILE}
	@echo 'RUN chmod +x $(TARGET)' >> ${FILE}
endef

define script
	@python3 $(DOCKER_HOME)/build/parts.py $(1) $(FILE)
endef

define arg
	@echo 'ARG $(1)' >> ${FILE}
	@$(eval ARGS += --build-arg $(1)="$(2)")
endef

build:
ifneq ($(CLEANUP),)
	$(call script,cleanup)
endif	
	@echo 'RUN chmod +x -R /opt/init.d' >> ${FILE}
	docker build -t $(NAME):$(VERSION) $(ARGS) -f $(FILE) $(DOCKER_HOME)/build
	@rm -f ${FILE}

prepare:
	@$(eval FILE = $(shell mktemp -p $(DOCKER_HOME)/build))
	@rm -f $(DOCKER_HOME)/build/tmp.*
	@echo FROM $(FROM) > ${FILE}
ifneq ($(PROXY),)
	$(call arg,PROXY,http://$(PROXY):3142)
endif
ifneq ($(TIMEZONE),)
	$(call arg,TIMEZONE,$(TIMEZONE))
endif
ifneq ($(JOBS),)
	$(call arg,JOBS,-j $(JOBS))
endif
	@echo ENV MODE $(MODE) >> ${FILE}
	$(call add,config,/build/config)
	@mkdir -p $(DOCKER_HOME)/build/parts
	$(call script,prepare)

clean:
	# @rm -rf $(DOCKER_HOME)/build/parts
	@rm -f ${FILE}
	@rm -rf build
	@rm -rf id_rsa

ssh:
	@ID=$$(docker ps | grep "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
		if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
		if ! test -s id_rsa; then \
			docker cp $$ID:/opt/id_rsa . ;\
		fi && \
		IP=$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $$ID) && \
		echo "SSHing into $$IP" && \
		ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i id_rsa root@$$IP ${CMD}
