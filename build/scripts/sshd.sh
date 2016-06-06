## Install OpenSSH
apt_install_permanent openssh-server
mkdir /var/run/sshd

## Install root key
cd /opt
AUTHORIZED_KEYS=/root/.ssh/authorized_keys
DIR=`dirname "$AUTHORIZED_KEYS"`
ssh-keygen -t rsa -N "" -f id_rsa
mkdir -p $DIR
chmod 700 $DIR
cp /opt/id_rsa $DIR
cat /opt/id_rsa.pub >> $AUTHORIZED_KEYS

## X11 forwarding
apt_install_permanent xauth

## Configuration
echo "ListenAddress 0.0.0.0" >> /etc/ssh/sshd_config

## Setup environment
echo "export HOME=/root" >> /root/.profile
echo "source /etc/container_environment.sh" >> /root/.profile