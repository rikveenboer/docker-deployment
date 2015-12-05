RANDOM = $(shell bash -c 'echo $$RANDOM')
HOME = $(DOCKER_HOME)
BASE = $(HOME)/build
FILE = $(BASE)/Dockerfile
TMP = /opt/tmp
FROM = ubuntu:trusty
INTERFACE = eth0
MODE = normal
ARGS = --rm=false --no-cache=false
include $(wildcard $(HOME)/build/make/*.mk)

define add
	@echo 'ADD $(1) $(2)' >> ${FILE}
endef

define execute
	$(call add,$(1),$(2))
	@echo 'RUN $(2)' >> ${FILE}
endef

define boot
	@$(eval TARGET := '/opt/init.d/$(1)_$(2)')
	$(call add,boot/$(2).sh,$(TARGET))
	@echo 'RUN chmod +x $(TARGET)' >> ${FILE}
endef

define runit
	@$(eval TARGET := '/etc/service/$(1)/run')
	$(call add,runit/$(1),$(TARGET))
	@echo 'RUN mkdir -p /etc/service/$(1)' >> ${FILE}
	@echo 'RUN chmod +x $(TARGET)' >> ${FILE}
endef

define script
	$(call execute,scripts/$(1).sh,$(TMP)/$(1).sh)
endef

all: build bin service clean

build: prepare base
	$(call script,cleanup)
	@echo 'RUN chmod +x /opt/init.d/*' >> ${FILE}
	@echo 'CMD ["/opt/init"]' >> ${FILE}
	@docker build -t $(NAME):$(VERSION) $(ARGS) ${BASE}

prepare:
	@echo FROM $(FROM) > ${FILE}
	@echo ENV MODE $(MODE) >> ${FILE}
	$(call add,config,/build/config)
	$(call add,init,/opt/init)
	@echo 'RUN chmod +x /opt/init' >> ${FILE}
	$(call script,prepare)

clean:
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
