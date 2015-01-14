RANDOM = $(shell bash -c 'echo $$RANDOM')
HOME = $(DOCKER_HOME)
BASE = $(HOME)/build
FILE = $(BASE)/Dockerfile
FROM = ubuntu:trusty
INTERFACE = eth0
PORT = 8000
MODE = normal
ARGS = --rm=false# --no-cache
include $(wildcard $(HOME)/build/make/*.mk)

define download
	@$(eval MD5=$(shell md5sum build/$(2) | awk '{print $$1}'))
	@echo 'RUN wget -q $(1) $$HOST_ADDR:$$HOST_PORT/$(2) $(3) # $(MD5)' >> ${FILE}
endef

define execute
	$(call download,-O -,$(1),| bash)
endef

define boot
	$(call download,-O /opt/init.d/$(1)_$(2),boot/$(2).sh)
	@echo 'RUN chmod +x /opt/init.d/$(1)_$(2)' >> ${FILE}
endef

define runit
	@echo 'RUN mkdir -p /etc/service/$(1)' >> ${FILE}
	$(call download,-O /etc/service/$(1)/run,runit/$(1))
	@echo 'RUN chmod +x /etc/service/$(1)/run' >> ${FILE}
endef

define script
	$(call execute,scripts/$(1).sh)
endef

all: build bin service clean

build: prepare base
	$(call script,cleanup)
	@echo 'RUN chmod +x /opt/init.d/*' >> ${FILE}
	@echo 'CMD ["/opt/init"]' >> ${FILE}
	@$(shell cd ${BASE} && python -m SimpleHTTPServer $(PORT) > /dev/null &)
	@docker build -t $(NAME):$(VERSION) $(ARGS) ${BASE}
	@kill -9 $(lsof -i tcp:$(PORT) -t)

prepare:
	@echo FROM $(FROM) > ${FILE}
	@echo ENV MODE $(MODE) >> ${FILE}
	@$(eval HOST_ADDR := $(shell ifconfig $(INTERFACE) | grep 'inet addr:' | cut -d: -f2 | awk '{print $$1}'))
	@echo ENV HOST_ADDR $(HOST_ADDR) >> ${FILE}
	@echo ENV HOST_PORT $(PORT) >> ${FILE}
	@echo 'RUN apt-get install -y wget' >> ${FILE}
	$(call download,-P /build,config)
	$(call download,-P /opt,init)
	@echo 'RUN chmod +x /opt/init' >> ${FILE}
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