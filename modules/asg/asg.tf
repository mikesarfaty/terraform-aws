module "global" {
  source = "../global"
}

locals {
  subnet_filter_tags = var.is_public_asg ? module.global.standard_public_subnet_tags : module.global.standard_private_subnet_tags
}

data "aws_subnets" "asg_subnets" {
  tags = local.subnet_filter_tags
}

resource "aws_autoscaling_group" "main" {
  name_prefix      = "${var.name}-"
  desired_capacity = 1
  max_size         = 2
  min_size         = 0

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }

  mixed_instances_policy {
    instances_distribution {
      spot_max_price = var.spot_max_price_per_hour
    }

    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.main.id
        version            = aws_launch_template.main.latest_version
      }

      override {
        instance_requirements {
          allowed_instance_types = var.allowed_instance_types

          memory_mib {
            min = var.spot_instance_requirements.memory_mib.min
            max = var.spot_instance_requirements.memory_mib.max
          }
          vcpu_count {
            min = var.spot_instance_requirements.vcpu_count.min
            max = var.spot_instance_requirements.vcpu_count.max

          }
        }
      }
    }
  }

  vpc_zone_identifier = data.aws_subnets.asg_subnets.ids

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}
