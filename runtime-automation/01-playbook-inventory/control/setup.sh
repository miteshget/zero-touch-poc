#!/bin/bash

USER=rhel

# --------------------------------------------------
# Directories
# --------------------------------------------------
mkdir /home/$USER/ansible # ansible home
mkdir /home/$USER/ansible-files # ansible-files dir
mkdir /home/$USER/ansible-files/.logs # logs dir

# --------------------------------------------------
# ansible.cfg
# --------------------------------------------------
su - $USER -c 'cat >/home/$USER/.ansible.cfg <<EOL
[defaults]
inventory = /home/$USER/ansible-files/inventory
host_key_checking = False
EOL
cat /home/$USER/.ansible.cfg'

# echo "[defaults]" > /home/$USER/.ansible.cfg
# echo "inventory = /home/$USER/ansible-files/inventory" >> /home/$USER/.ansible.cfg
# echo "host_key_checking = False" >> /home/$USER/.ansible.cfg

# --------------------------------------------------
## Setup git config
# --------------------------------------------------
git config --global user.email "rhel@example.com"
git config --global user.name "Red Hat"
su - $USER -c 'git config --global user.email "rhel@example.com"'
su - $USER -c 'git config --global user.name "Red Hat"'


# --------------------------------------------------
# set ansible-navigator default settings
# for the EE to work we need to pass env variables
# TODO: controller_host doesnt resolve with control and 127.0.0.1
# is interpreted within the EE
# --------------------------------------------------
su - $USER -c 'cat >/home/$USER/ansible-navigator.yml <<EOL
---
ansible-navigator:
  ansible:
    inventory:
      entries:
      - /home/rhel/ansible-files/inventory
  execution-environment:
    container-engine: podman
    enabled: true
    image: quay.io/acme_corp/servicenow-ee:latest
    pull:
      policy: missing
    environment-variables:
      pass:
        - CONTROLLER_USERNAME
        - CONTROLLER_PASSWORD
        - CONTROLLER_VERIFY_SSL
      set:
        CONTROLLER_HOST: control.${_SANDBOX_ID}.svc.cluster.local
  logging:
    level: debug
  mode: stdout
  playbook-artifact:
    save-as: /home/rhel/.logs/{playbook_name}-artifact-{time_stamp}.json

EOL
cat /home/$USER/ansible-navigator.yml'

# --------------------------------------------------
# Copy navigator settings
# --------------------------------------------------
su - $USER -c 'cp /home/$USER/ansible-navigator.yml /home/$USER/.ansible-navigator.yml'
su - $USER -c 'cp /home/$USER/ansible-navigator.yml /home/$USER/ansible-files/ansible-navigator.yml'


# --------------------------------------------------
## chown and chmod
# --------------------------------------------------
chown -R rhel:rhel /home/rhel/ansible
chmod 777 /home/rhel/ansible
chown -R rhel:rhel /home/rhel/ansible-files

# --------------------------------------------------
# ENV VARS FOR CONTROLLER
# Set controller access env variables
# --------------------------------------------------
export CONTROLLER_HOST=localhost
export CONTROLLER_USERNAME=admin
export CONTROLLER_PASSWORD='ansible123!'
export CONTROLLER_VERIFY_SSL=false

# --------------------------------------------------
# Set controller access env variables for system
# --------------------------------------------------
cat >/etc/environment <<EOL
CONTROLLER_HOST=localhost
CONTROLLER_USERNAME=admin
CONTROLLER_PASSWORD='ansible123!'
CONTROLLER_VERIFY_SSL=false

EOL
cat /etc/environment


# --------------------------------------------------
# RHEL 9 test
# --------------------------------------------------
# sudo dnf config-manager --enable ansible-automation-platform
# sudo dnf config-manager --disable google*
sudo dnf clean all
# sudo dnf install -y ansible-navigator ansible-lint nc
sudo dnf install -y ansible-lint nc
pip3 install yamllint

#Switch to correct Python version (rhel 8 workaround)
#/usr/sbin/alternatives --set python3 /usr/bin/python3.8

# --------------------------------------------------
# Get all  solve playbooks:
# --------------------------------------------------
/usr/bin/git clone https://github.com/leogallego/instruqt-wyfp-2024-solve.git /tmp/first-101


# Get playbook from repo
#/usr/bin/curl https://raw.githubusercontent.com/leogallego/instruqt-lifecycle-scripts/main/controller-101-setup-playbook.yml -o /tmp/controller-101-setup.yml


# Use playbook to setup environment
#/bin/ansible-playbook /tmp/controller-101-setup.yml --tags setup-env