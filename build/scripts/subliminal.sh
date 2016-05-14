pip install git+git://github.com/Diaoul/subliminal.git
cat << EOF > /opt/subliminal
#!/bin/bash
echo Filename to process. $1
echo Original filename... $2
echo Show TVDB id........ $3
echo Season number....... $4
echo Episode number...... $5
echo Episode air date.... $6
echo ... pass the episode info to Subliminal and fetch the subtitle
/usr/local/bin/subliminal -l en -- "$1"
EOF