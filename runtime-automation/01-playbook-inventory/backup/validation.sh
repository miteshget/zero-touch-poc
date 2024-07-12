#!/bin/bash

if [ -f "./${MODULE_DIR}/playbooks/${MODULE_STAGE}.yml" ]
  then
    /opt/app-root/bin/ansible-playbook ./${MODULE_DIR}/playbooks/${MODULE_STAGE}.yml
else
  echo "Validation doesn't exist, skipping"
fi