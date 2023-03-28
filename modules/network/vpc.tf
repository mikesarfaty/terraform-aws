locals {
  vpc_tags = merge({
    Name = var.network_prefix
  }, var.tags)
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_range
  tags       = local.vpc_tags

  enable_dns_hostnames = true
  enable_dns_support   = true
}
