#!/usr/bin/env bash
set -euo pipefail

echo "destroy pre-created Pulumi instances"
pulumi destroy --yes

echo "generate EC2 keypair and save private key locally (since Pulumi isn't able to do that now)"
ansible-playbook keypair.yml

echo "execute Pulumi to create EC2 instances"
pulumi up --yes

echo "Downloading the Ansible role 'mysql' with ansible-galaxy"
ansible-galaxy install -r requirements.yml -p roles/

echo "run Ansible role to install MySQL on Ubuntu"
ansible-playbook playbook.yml