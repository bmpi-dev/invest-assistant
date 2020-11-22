#!/usr/bin/env bash
set -euo pipefail

cd infra

echo "destroy pre-created Pulumi instances"
pulumi destroy --yes

cd ../ansible

echo "generate EC2 keypair and save private key locally (since Pulumi isn't able to do that now)"
ansible-playbook keypair.yml

cd ../infra

echo "execute Pulumi to create EC2 instances"
pulumi up --yes

# when server created, get public dns to .ec2ssh for ansible using

cd ../ansible

echo "Downloading the Ansible role 'mysql' with ansible-galaxy"
ansible-galaxy install -r requirements.yml -p roles/

echo "run Ansible role to install MySQL on Ubuntu"
ansible-playbook playbook.yml

# destroy instance by aws web console, for pulumi cannot do it