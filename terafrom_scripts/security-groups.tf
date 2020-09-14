resource "aws_security_group" "kubernetes_sg" {
  name        = "Allow_All_Ports"
  description = "Allow All Ports All Protocals"
  vpc_id      = aws_vpc.kubernetes.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
