# Generate ssh_key
resource "tls_private_key" "ansible" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Get ssh_key
resource "aws_key_pair" "ansiblesshkey" {
  public_key = tls_private_key.ansible.public_key_openssh
}

resource "aws_instance" "kubernetes_Servers" {
  count                  = 1
  ami                    = var.kubernetes_ami
  instance_type          = var.master_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  user_data              = "${file("terafrom_scripts/create_ansible_user.sh")}"

  tags = {
    Name = "Kubernetes_Servers"
    Type = "Kubernetes_Master"
  }

  # Copies the ssh_key file to new ec2.
  provisioner "file" {
    # Read ssh_key and copy to ansible
    content     = aws_key_pair.ansiblesshkey.public_key
    destination = "/home/ansible/.ssh/authorized_keys"
  }

}

resource "aws_instance" "kubernetes_Workers" {
  count                  = 2
  ami                    = var.kubernetes_ami
  instance_type          = var.worker_instance_type
  vpc_security_group_ids = [aws_security_group.kubernetes_sg.id]
  subnet_id              = element(aws_subnet.kubernetes_subnets.*.id, count.index)
  key_name               = var.key_name
  user_data              = "${file("terafrom_scripts/create_ansible_user.sh")}"

  tags = {
    Name = "Kubernetes_Servers"
    Type = "Kubernetes_Worker"
  }

  # Copies the ssh_key file to new ec2.
  provisioner "file" {
    # Read ssh_key and copy to ansible
    content     = aws_key_pair.ansiblesshkey.public_key
    destination = "/home/ansible/.ssh/authorized_keys"
  }

}
