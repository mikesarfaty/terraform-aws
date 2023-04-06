// For testing, we'll expose the game port instead of the nginx port
resource "aws_security_group" "gmod_port" {
  name        = "allow_gmod_connections"
  description = "Allows connection to the GMod Server from internet"
  vpc_id      = module.network.vpc_id

  ingress {
    description = "GMod Port from everywhere"
    from_port   = 27015
    to_port     = 27015
    protocol    = "tcp"
    cidr_blocks = [local.everywhere]
  }

  ingress {
    description = "GMod Port from everywhere"
    from_port   = 27036
    to_port     = 27036
    protocol    = "tcp"
    cidr_blocks = [local.everywhere]
  }

  ingress {
    description = "GMod Port from everywhere"
    from_port   = 27015
    to_port     = 27015
    protocol    = "udp"
    cidr_blocks = [local.everywhere]
  }

  ingress {
    description = "GMod Port from everywhere"
    from_port   = 27020
    to_port     = 27020
    protocol    = "udp"
    cidr_blocks = [local.everywhere]
  }

  ingress {
    description = "GMod Port from everywhere"
    from_port   = 27031
    to_port     = 27036
    protocol    = "udp"
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

module "gmod-asg" {
  source            = "../modules/asg"
  name              = "garrysmod"
  ssh_key_pair_name = aws_key_pair.main_ssh_key.key_name
  extra_sg_ids = [
    aws_security_group.allow_ssh.id,
    aws_security_group.gmod_port.id
  ]

  tags = local.tags

  depends_on = [
    module.network
  ]
}
