locals {
  everywhere = "0.0.0.0/0"
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allows SSH (TCP/22) Traffic"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "SSH from Anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.everywhere]
  }

  egress {
    description = "Access Internet"
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [local.everywhere]

  }

  timeouts {
    delete = "1m" # Shorten timeout to see "Error: SG In Use" faster
  }
}
