variable "aws_region" {
  default = "ap-south-1"
}

variable "key_name" {
  default = "devops"
}
variable "vpc_cidr" {
  default = "172.0.0.0/24"
}
variable "subnets_cidr" {
  type    = list(string)
  default = ["172.0.0.0/25", "172.0.0.128/25"]
}
variable "availability_zones" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b"]
}
variable "kubernetes_ami" {
  default = "ami-0b44050b2d893d5f7"
}
variable "master_instance_type" {
  default = "t2.medium"
}
variable "worker_instance_type" {
  default = "t2.micro"
}
