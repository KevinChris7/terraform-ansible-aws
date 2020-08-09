#!/bin/bash

# This script installs and checks below requiments for Ansible Playbook execution
# First Installs Pip 
# Next Ansible Requirments are installed using Pip3
# Next Exports Ansible Inventory and Config details
# Checks the Dynamic Inventory is working or not
# To Run => ./ansible-setup.sh


install_req() {
    # Install Ansible Requirements
    echo "Ansible Requirments Installing...."   
    pip3 install -r ansible/requirements.txt
    echo "Ansible Requirements Installed Successfully"
}

ansible_exports() {
    # Exports Ansible Dynamic Inventory details
    export ANSIBLE_HOSTS=/ansible/inventory/ec2.py
    export EC2_INI_PATH=/ansible/inventory/ec2.ini

    # Exports Ansible Config details
    export ANSIBLE_CONFIG=ansible.cfg
    echo "Ansible Dynamic Inventory File Requirements completed Successfully"
}

inventory_check() {
    # Check whether Dynamic Inventory workss
    chmod 700 ansible/inventory/ec2.py
    dos2unix ansible/inventory/ec2.py --list
    echo "Inventory File Verification Success"
}

# Install Pip3
echo "Installing Pip...."
sudo apt install python3-pip

if [[ "${?}" -eq 0 ]];
then
    install_req
else
    echo "Pip Installation failed and Ansible Requirments not started"
    exit 1
fi

if [[ "${?}" -eq 0 ]];
then
    ansible_exports
else 
    echo "Ansible Exports Failed"
    exit 1
fi

# Install dos2unix for running py scripts in Virtual Box
sudo apt install dos2unix -y

if [[ "${?}" -eq 0 ]];
then
    inventory_check
else 
    echo "Inventory Check Failed"
    exit 1
fi

#pem file permissions chmod400
#ansible-playbook ansible/site.yml -vvv

exit 0