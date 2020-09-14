# Ansible Installation
``` sh
$ sudo yum install python3 -y
$ sudo alternatives --set python /usr/bin/python3
$ sudo yum -y install python3-pip -y

$ sudo useradd ansible
$ echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
$ sudo su ansible
$ pip3 install ansible --user
$ pip3 install boto3 --user
```
## Infrastructure As A Code
### Install Terraform

``` sh
$ sudo su ansible
$ sudo yum install wget unzip -y
$ wget https://releases.hashicorp.com/terraform/0.12.26/terraform_0.12.26_linux_amd64.zip
$ sudo unzip terraform_0.12.26_linux_amd64.zip -d /usr/local/bin/
# Export terraform binary path temporally
$ export PATH=$PATH:/usr/local/bin
# Add path permanently for current user.By Exporting path in .bashrc file at end of file.
$ vi .bashrc
   export PATH="$PATH:/usr/local/bin"
# Source .bashrc to reflect for current session
$ source ~/.bashrc   
```
#### Clone terraform and ansible scripts
``` sh
$ git clone https://github.com/MithunTechnologiesDevOps/Kuberentes_Cluster_Terraform_Ansible.git
$ cd Kuberentes_Cluster_Terraform_Ansible
```
###### <span style="color:orange"> Update Your Key Name in variables.tf file before executing terraform script </span>

##### Create Infrastructure As A Code Using Terraform Scripts
``` sh
# Initialise to install plugins
$ terraform init terafrom_scripts/
# Validate teffaform scripts
$ terraform validate terafrom_scripts/
# Plan terraform scripts which will list resouce which will be created
$ terraform plan terafrom_scripts/
# Apply to create resources
$ terraform apply --auto-approve terafrom_scripts/
```
# Ansible command to setup k8s cluste using DynamicInventory.

###### <span style="color:red">Replace \<Pemfile> with your pemfile path in server </span>
```sh
$ ansible-playbook -i DynamicInventory.py site.yml -u ubuntu --private-key=<PemFilePath>  --ssh-common-args "-o StrictHostKeyChecking=no"
```
##  Destroy Infrastructure  
```sh
$ terraform destroy --auto-approve terafrom_scripts/
```
