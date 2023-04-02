data "aws_ami" "ubuntu-22" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}


data "aws_key_pair" "main" {
  key_name = var.ssh_key_pair_name
}

locals {
  userdata_vars = {
    public_key = data.aws_key_pair.main.public_key
  }
}

resource "aws_launch_template" "main" {
  name_prefix = "${var.name}-"
  image_id    = data.aws_ami.ubuntu-22.id
  key_name    = data.aws_key_pair.main.key_name

  iam_instance_profile {
    arn = aws_iam_instance_profile.main.arn
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = var.extra_sg_ids
  }

  metadata_options {
    http_endpoint          = "enabled"
    http_tokens            = "required"
    instance_metadata_tags = "disabled"
  }

  user_data = base64encode(templatefile("${path.module}/userdata/userdata.tftpl", local.userdata_vars))

  tags = var.tags
}
