# **Vagrant-Terraform-Ansible-AWS-Project**

## **Vagrant Download and Setup**
1.Download the Vagrant package for windows

> https://www.vagrantup.com/downloads

2.Run and Install the package

3.Navigate to Workspace and run the below command for Setting up

> vagrant init

4.Check the output

> "A `Vagrantfile` has been placed in this directory. You are now
> ready to `vagrant up` your first virtual environment!"

5.Open the Vagrantfile and remove unnecessary contents

6.Configure the Vagrantfile for Ubuntu Base Image

> Box: generic/ubuntu2004

> Hostname: devbox

7.Customize the Virtual Box and VM resources

## **VirtualBox Download and Setup**

1.Download and Install the Oracle VirtualBox

> https://www.virtualbox.org/

2.Check and Enable Virtualization in Windows Bios

3.Run below command in workspace

> vagrant up

4.Open VirtualBox and DevBox should be up and running

## **Terraform and Ansible Installation in Dev Box[Ubuntu Image]**

1.Execute the provision.sh script with chmod 700 permission

> sudo ./provision.sh

2.Check and confirm Terraform Installation

> terraform --version

3.Check and confirm Ansible Installation

>ansible --version


## **Infrastructure Build Automation with Terraform**

1.Navigate to terraform directory

> cd terraform

2.Format the terraform config files

> terraform fmt

3.Validate the terraform configurations

> terraform validate

4.Check the Plan of resources to be created by config files

> terraform plan

5.Apply the terraform config files

> terraform apply

6.Approve the execution and resources will be created

# **Configuration Management Using Ansible**

1.Navigate to root directory where ansible.cfg exists

> cd..

2.Execute the ansible-setup.sh script with chmod 700 permission

3.Execute the ansible playbook

> ansible-playbook ansible/site.yml -i ansible/inventory/ec2.py --private-key="PEMFILEHERE"

4.Ansible will execute all the modules in the servers created by Terraform