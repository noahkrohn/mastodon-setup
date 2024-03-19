#!/bin/bash
echo "Running apt update..."
sudo apt update
echo "Running apt -f install -y..."
sudo apt -f install -y
echo "Running apt dist-upgrade..."
sudo DEBIAN_FRONTEND=noninteractive apt -y -o Dpkg::Options::='--force-confdef' -o Dpkg::Options::='--force-confold' dist-upgrade
sudo apt-get install python3.10-venv python3.10-dev ansible -y
mkdir -p /etc/ansible
echo 'all:' > /etc/ansible/hosts
echo '  hosts:' >> /etc/ansible/hosts
echo '    localhost:' >> /etc/ansible/hosts
echo '      ansible_connection: local' >> /etc/ansible/hosts
echo '      ansible_python_interpreter: "{{ansible_playbook_python}}"' >> /etc/ansible/hosts
echo '      allow_world_readable_tmpfiles: true' >> /etc/ansible/hosts
echo '      pipelining: true' >> /etc/ansible/hosts