HOME = $(DOCKER_HOME)
BASE = $(HOME)/build
DIR = $(HOME)/images/$(NAME)
FILE = $(DIR)/Dockerfile
FROM = ubuntu:trusty
PORT = 8001
MODE = minimal
ARGS = --no-cache --rm=true

include $(wildcard $(HOME)/build/make/*.mk)

define download
	@echo 'RUN wget -q $(1) $$HOST_ADDR:$$HOST_PORT/$(2) $(3)' >> ${FILE}
endef

define execute
	$(call download,-O -,$(1),| bash)
endef

define script
	$(call execute,scripts/$(1).sh)
endef

define boot
	$(call download,-O /opt/init.d/$(1)_$(2),boot/$(2).sh)
endef

define runit
	@echo 'RUN mkdir -p /etc/service/$(1)' >> ${FILE}
	$(call download,-O /etc/service/$(1)/run,runit/$(1))
endef

all: build bin service clean

build: prepare
	$(call script,cleanup)
	@echo 'CMD ["/opt/init"]' >> ${FILE}
	@$(shell cd ${BASE} && python -m SimpleHTTPServer $(PORT) > /dev/null &)
	@docker build -t $(NAME):$(VERSION) $(ARGS) ${DIR}
	@kill -9 $(lsof -i tcp:8001 -t)

prepare:
	@echo FROM $(FROM) > ${FILE}
	@echo ENV MODE $(MODE) >> ${FILE}
	@$(eval HOST_ADDR := $(shell ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $$1}'))
	@echo ENV HOST_ADDR $(HOST_ADDR) >> ${FILE}
	@echo ENV HOST_PORT $(PORT) >> ${FILE}
	@echo 'RUN apt-get install -y wget' >> ${FILE}
	$(call download,-P /build,config,)
	$(call download,-P /build,init)
	$(call script,prepare)

service:
	@if test "${DEPENDS}" != ""; then \
		echo start on started docker-$(subst $(eval) $(eval), and started docker-,$(DEPENDS)) >> init.conf ;\
		echo stop on stopped docker-$(subst $(eval) $(eval), or stopped docker-,$(DEPENDS)) >> init.conf ;\
	else \
		echo start on started docker >> init.conf ;\
		echo stop on stopped docker >> init.conf ;\
	fi
	@echo exec /opt/docker/bin/run $(NAME) >> init.conf
	@echo respawn >> init.conf
	@mv init.conf /etc/init/docker-$(NAME).conf

bin:
	@rm -r bin
	@mkdir -p bin
	@ln -sf $(BASE)/bin/run bin
	@ln -sf $(BASE)/bin/ssh bin
	@ln -sf $(BASE)/bin/app bin
	@sed -i "1iARGS=\"$(RUN)\"" bin/run
	@sed -i "1iARGS=\"$(SSH)\"" bin/ssh

clean:
	@rm -f ${FILE}
	@rm -rf build
	@rm -rf id_rsa

tag_latest:
	@docker tag $(NAME):$(VERSION) $(NAME):latest

ssh:
	@ID=$$(docker ps | grep "$(NAME):$(VERSION)" | awk '{ print $$1 }') && \
        if test "$$ID" = ""; then echo "Container is not running."; exit 1; fi && \
        if ! test -s id_rsa; then \
            docker cp $$ID:/opt/id_rsa . ;\
        fi && \
        IP=$$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $$ID) && \
        echo "SSHing into $$IP" && \
        ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no -i id_rsa root@$$IP ${CMD}