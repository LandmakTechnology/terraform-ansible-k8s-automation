#!/usr/bin/env bash
sudo useradd ansible
echo "ansible  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
sudo sed -re 's/^(PasswordAuthentication)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config
sudo service sshd restart
