apt_install_permanent libsensors5 liblzo2-2 hddtemp collectd sudo btrfs-progs

pip install requests

useradd collectd
usermod -aG sudo collectd
echo 'collectd ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/collectd
