apt_install_permanent libsensors5 liblzo2-2 hddtemp collectd sudo btrfs-progs libatasmart4

pip install requests

useradd collectd
usermod -aG sudo collectd
echo 'collectd ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/collectd

apt_install_temporary -y gcc python-dev make
git clone https://github.com/RRZE-HPC/likwid.git
cd likwid && make -j && make install

git clone https://github.com/RRZE-HPC/pylikwid.git
cd pylikwid
python setup.py build_ext
python setup.py install

export_env LD_LIBRARY_PATH /usr/local/lib
