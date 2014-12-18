include $(wildcard /opt/docker/build/make/*.mk)
BASE = /opt/docker/build

all: build bin service clean

build:
	cp $(BASE)/Dockerfile .
	docker build -t $(NAME):$(VERSION) --rm .

directory:
	@mkdir -p build/boot build/runit build/scripts

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
	@mkdir -p bin
	@ln -sf $(BASE)/bin/run bin
	@ln -sf $(BASE)/bin/ssh bin
	@ln -sf $(BASE)/bin/app bin
	@sed -i "1iARGS=\"$(RUN)\"" bin/run
	@sed -i "1iARGS=\"$(SSH)\"" bin/ssh

clean:
	@rm -f Dockerfile
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