#!/bin/bash

USER=rhel
# set ansible-navigator default settings
su - $USER -c 'cat >/home/$USER/ansible-navigator.yml <<EOL
---
ansible-navigator:
  ansible:
    inventory:
      entries:
      - /home/rhel/ansible-files/hosts
  execution-environment:
    container-engine: podman
    enabled: true
    image: quay.io/acme_corp/first_playbook_ee:latest
    pull:
      policy: missing
  logging:
    level: debug
  mode: stdout
  playbook-artifact:
    save-as: /home/rhel/{playbook_name}-artifact-{time_stamp}.json

EOL
cat /home/$USER/ansible-navigator.yml'


dnf clean all
dnf install -y nc
pip3 install yamllint
