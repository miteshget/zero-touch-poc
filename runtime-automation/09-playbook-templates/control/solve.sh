#!/bin/bash

USER=rhel

# Set the target directory and file
target_directory="/home/rhel/ansible-files"
target_file="${target_directory}/system_setup.yml"
templates_dir="${target_directory}/templates"
target_motd_j2="${templates_dir}/motd.j2"
solve_file="/tmp/first-101/solve_18_system_setup_motd.yml"
solve_motd_j2="/tmp/first-101/solve_18_system_setup_motd.j2"

# Make sure solvers exist
/usr/bin/git clone https://github.com/leogallego/instruqt-wyfp-2024-solve.git /tmp/first-101


#####################
###### SOLVE ########
##  EVERYTHING

## create templates dir
mkdir $target_directory/templates 

## Copy solved playbook and motd.j2 file
cp $solve_file $target_file
cp $solve_motd_j2 $target_motd_j2
chown $USER:$USER -R $target_directory

## Run solve playbook
cd $target_directory
ansible-navigator run $target_file -m stdout 

#### run solve playbook as $USER
####su - $USER -c 'cd ansible-files && ansible-navigator run system_setup.yml -m stdout'