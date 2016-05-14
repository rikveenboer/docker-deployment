import sys
import os
import re

# Arguments
file = sys.argv[1]
docker = open(sys.argv[2], 'a')

# Parameters 
tmp = '/build/tmp'
config = '/build/config'
shell = '/bin/bash'

# Remove all normal comments
path = '{}/build/scripts/{}.sh'.format(os.environ['DOCKER_HOME'], file)
contents = ''
for line in open(path):
    line = line.strip()
    if len(line) > 0 and not line.startswith('# '):
        contents += line + '\n'

# Split on comments starting with ##
parts = re.split('## .*', contents)
first = '''\
#!{}
set -ex
source {}
'''.format(shell, config)

# Iterate over parts, except header
i = 0
for part in parts:
    if len(part) > 0:
        i += 1

        # Add reading environment variables
        extra = '' if file == 'prepare' else 'export_container_environment\n'

        # Write parts file
        contents = '{}{}{}'.format(first, extra, part)
        partfile = '{}_{}.sh'.format(file, i)
        path = '{}/build/parts/{}'.format(os.environ['DOCKER_HOME'], partfile)
        open(path, 'w').write(contents)
        os.chmod(path, 0o100)

        # Append to Dockerfile
        docker.write('ADD parts/{} {}/{}\n'.format(partfile, tmp, partfile))
        docker.write('RUN {}/{}\n'.format(tmp, partfile))