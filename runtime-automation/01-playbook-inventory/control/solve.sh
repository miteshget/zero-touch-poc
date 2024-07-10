#!/bin/bash

USER=rhel

# --------------------------------------------------
# Set the target directory and file
# --------------------------------------------------
target_directory="/home/rhel/ansible-files"
target_file="${target_directory}/inventory"
solve_file="/tmp/first-101/solve_10_inventory"

# --------------------------------------------------
# Make sure solvers exist
# --------------------------------------------------
/usr/bin/git clone https://github.com/leogallego/instruqt-wyfp-2024-solve.git /tmp/first-101

# Copy solved playbook
cp $solve_file $target_file
chown $USER:$USER $target_file 

# --------------------------------------------------
# Run solve playbook
# --------------------------------------------------
#su - $USER -c 'ansible-navigator run system_setup.yml -m stdout'
#cd $target_directory
#ansible-navigator run $target_file -m stdout

# --------------------------------------------------
# OLD SOLVE
# --------------------------------------------------
## Write the desired content to the 'hosts' file
su - $USER -c 'cat >/home/rhel/ansible-files/hosts <<EOL
[web]
node1
node2

EOL
cat /home/rhel/ansible-files/hosts'
