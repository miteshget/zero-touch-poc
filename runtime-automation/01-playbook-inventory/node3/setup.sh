#!/bin/bash

dnf clean all
dnf install -y cups-filesystem
setenforce 0

# touch /etc/sudoers.d/rhel_sudoers
# echo "%rhel ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/rhel_sudoers
# cp -a /root/.ssh/* /home/rhel/.ssh/.
# chown -R rhel:rhel /home/rhel/.ssh