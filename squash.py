import sys
import os
import re

# Command line arguments
treefile = sys.argv[1]
commandfile = sys.argv[2]

# File handling
os.remove(commandfile)
treefile = open(treefile, 'r', encoding='utf-8')
commandfile = open(commandfile, 'a')

def proccess_end(name, tag):
    print('Deal with tag [{}]...'.format(tag, branches[-1]))    
    if branches[-1]:
        print('    > Use branching image [%.7s]...' % branches[-1])
        commandfile.write('docker-squash -f {} -t {}:latest {}:{}\n'.format(branches[-1], name, name, tag))
    else:
        print('    > Branching image missing!')

# Caching
previous_type = False
previous_tag = False
previous_depth = False

# Parse file
branches = []
for line in treefile:  
    # Find image id
    match = re.search('sha256:([\w]+)', line)
    id = match.group(1) if match else False

    # Find image tag
    match = re.search('Tags: ([\w/]+):([\w\.]+)', line)
    name = match.group(1) if match else False
    tag = match.group(2) if match else False

    # Count depth
    depth = line.count('│')

    # Parse tree
    match = re.search('([^s])─', line)
    type = match.group(1)
    if type == '└':        
        if depth < previous_depth and previous_tag:
            # Reached an end
            proccess_end(previous_name, previous_tag)
    elif type == '├':
        if previous_type == '└' and previous_name:
            # Reached an end
            proccess_end(previous_name, previous_tag)

        # Start new branch
        branches.append(id)

    # Return to previous branch
    if depth < previous_depth:
        branches.pop()
        branches.append(id)

    # Store current data
    previous_type = type
    previous_name = name
    previous_tag = tag
    previous_depth = depth

# Deal with very last end
if previous_tag:
    proccess_end(previous_name, previous_tag)