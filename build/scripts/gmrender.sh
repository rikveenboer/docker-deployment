## GMediaRender dependencies
apt_install_permanent libupnp-dev libgstreamer0.10-dev \
            gstreamer0.10-plugins-base gstreamer0.10-plugins-good \
            gstreamer0.10-plugins-bad gstreamer0.10-plugins-ugly \
            gstreamer0.10-ffmpeg \
            gstreamer0.10-pulseaudio gstreamer0.10-alsa

## GMediaRender
cd opt
git clone https://github.com/hzeller/gmrender-resurrect.git
cd gmrender-resurrect
autoreconf || automake --add-missing
./configure
make
make install