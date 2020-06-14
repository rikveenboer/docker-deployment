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

apt_install_temporary -y collectd-dev
git clone https://github.com/n-st/collectd-plugin-intel_cpu_energy.git collectd-energy
cd collectd-energy
sed -i 's/ssnprintf/vsnprintf/' intel_cpu_energy.c
make
make install

export_env LD_LIBRARY_PATH /usr/local/lib
