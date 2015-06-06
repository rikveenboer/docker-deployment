
## Introduction
This project bundles a set of scripts to simplify the deployment of docker containers.

The basic idea is adapted from the excellent [Ubuntu base image](https://github.com/phusion/baseimage-docker):

- install software using bash scripts
- use a tailored init script to ensure correct startup and shutdown behavior
- use [runit](http://smarden.org/runit/) to supervise services
- provide a preconfigured SSH server
- provide a consistent way of managing environment variables

## Installation
Make sure Docker is [installed](https://docs.docker.com/installation/) correctly, in most cases, the following command should suffice:
```
curl http://get.docker.io | sudo sh
``` 
Install [maestro](https://github.com/signalfuse/maestro-ng):
```
pip install --user --upgrade git+git://github.com/signalfuse/maestro-ng
``` 

Install nsenter
```
docker run --rm -v /usr/local/bin:/target jpetazzo/nsenter
```
Then change /etc/default/docker to read:
```
DOCKER_OPTS="-e lxc -r=false"
```

And make sure to restart the docker daemon. This enables LXC related tricks such as 
```docker attach``` and to allows to modify networking configuration using ```--lxc-conf``` in ```docker run```. It also disables the automatic restart of previously running containers.

## Utility scripts

### In $DOCKER_HOME/bin

#### build
Run build target on makefile for specified image.
#### clean
Delete all stopped containers.
#### killall
Kill all running containers.
#### make
Run specified target on makefile for specified image.
#### purge
Delete all untagged containers.
#### run-bash
Run a container and execute bash.
#### ssh
Open a ssh connection to the specified running container and executed a command.
#### stopall
Stop all running containers.
### enter
Use nsenter to execute a command in the specified running container (deprecated by docker-exec).
### enter-bash
Use nsenter to execute bash in the specified running container (deprecated by docker-exec).

Images are build using Makefiles in order to provide reusable pieces of functionality.

## Build files

### Boot
These scripts are executed by the init script before runit starts any services. Numeric prefixes are used to enforce a specific order of execution. These scripts are used to prepare the container with live parameters from the host. It is more convenient to make service specific modifications in the respective runit scripts than to create separate boot scripts.

### Script
These scripts are executed during the build and install the software. Numeric prefixes are used to enforce a specific order of execution. The following convention is recommended:

- 00_ for essential modifications to the base image without which other software might fail to install.
- 01_ for essential modifications regarding the functioning of the base image.
- 02_ for system wide modifications or the installation of very general system components.
- 03_ for the installation of image specific software.
- 99_ to clean the image from unnecessary junk.

### Runit
These scripts are executed by runit to start services. Runit requires services to run in the foreground and correct parameters must be passed to prevent the service from daemonising. These scripts are also used to initialise files and directories on host volumes.

### Make
The Makefiles link (symbolic link) the required files (installation script, boot script and runit script) for each separate component into the build directory. These files are quite general since the aforementioned scripts for each separate component are typically named after the build target. Dependencies on other component are defined here.

## Current limitations
- This approach does not benefit from the caching mechanisms used by Docker. The Dockerfile is generated at build time and installation scripts are added dynamically.
- There is no mechanism to keep track of software installed during the build. It would be desirable to have a *developer mode* that keeps useful software (e.g., vim, curl, wget) after the build or a *production mode* that removes this software to obtain as small an image as possible.

## Todo
- Make hardcoded network interface (eth0) configurable
- Update python pid to port based (kill -9 $(lsof -i udp:5353 -t))
- Option to use cache and force re-execute scripts by adding $RANDOM