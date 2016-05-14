## Pulseaudio
apt_install_permanent pulseaudio

## Configuration
sed -i "1iexport PULSE_SERVER=host" /root/.profile