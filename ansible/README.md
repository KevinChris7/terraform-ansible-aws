# **Ansible-Configurations**

## **About Ansible**

Ansible is a radically simple IT automation engine that automates cloud provisioning, configuration management, application deployment, intra-service orchestration, and many other IT needs.
Ansible is Agent less and uses YAML syntax
Ansible requires to be installed only in controller machine

## **About Project**

1.Installs Apache and Python modules to the host machines

2.Uses Dynamic inventory created by Ansible to fetch the server details

3.Executes the playbook for all the hosts

## **About Project**

This version of playbooks and roles was last tested on:

Virtual Box - Ubuntu 20.04 and Ubuntu 20.04 WSL

Python 3.8

Ansible 2.9

## **Infrastructure**

AWS Cloud

## **Development Environment**

Ubuntu 20.04 Box as Ansible Controller

## **Usage**

1.Execute the below script with chmod 700 permission

> ansible-setup.sh

2.Execute the Playbook

> ansible-playbook ansible/site.yml -i ansible/inventory/ec2.py --private-key="YOURPEMFILEHERE"

## **Project Insider**

- **Role**: python: A role to install Python and other dependencies

- **Role**: apache: A role to install apache and configure the index.html

- **Playbook**: ec2-configure.yml: Configure the webservers with roles

- **Playbook**: site.yml: An entry point for ansible configuration which imports the       ec2-configure.yml playbook
