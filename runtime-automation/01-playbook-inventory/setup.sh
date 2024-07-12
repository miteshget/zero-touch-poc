#!/bin/bash

if [ -f "./${MODULE_DIR}/playbooks/${MODULE_STAGE}.yml" ]
  then
    /opt/app-root/bin/ansible-playbook ./${MODULE_DIR}/playbooks/${MODULE_STAGE}.yml
else
  echo "Setup doesn't exist, skipping"
fi