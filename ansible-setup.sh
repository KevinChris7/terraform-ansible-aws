#!/bin/bash

# Install Pip3
sudo apt install python3-pip

# Install Ansible Requirements
echo "Ansible Requirments Installing...."
pip3 install -r ansible/requirements.txt
echo "Ansible Requirements Installed Successfully"

# Exports Ansible Dynamic Inventory details
export ANSIBLE_HOSTS=/ansible/inventory/ec2.py
export EC2_INI_PATH=/ansible/inventory/ec2.ini

# Exports Ansible Config details
export ANSIBLE_CONFIG=ansible.cfg
echo "Ansible Dynamic Inventory File Requirements completed Successfully"

# Install dos2unix for running py scripts in Virtual Box
sudo apt install dos2unix -y

# Check whether Dynamic Inventory workss
chmod 700 ansible/inventory/ec2.py
dos2unix ansible/inventory/ec2.py --list
echo "Inventory File Verification Success"

#pem file permissions chmod400
#ansible-playbook ansible/site.yml -vvv