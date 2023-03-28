locals {
  network_prefix = "main"

  # 8 subnets in us-east-1, 4 public and 4 private
  # Must use a power of 2, we will use log math in the module
  # To determine the sizes. Sizes will be equal.
  vpc_cidr_range    = "10.0.0.0/16"
  private_subnet_ct = 4
  public_subnet_ct  = 4
}

module "network" {
  source         = "../modules/network"
  network_prefix = local.network_prefix
  environment    = var.environment

  vpc_cidr_range    = local.vpc_cidr_range
  private_subnet_ct = local.private_subnet_ct
  public_subnet_ct  = local.public_subnet_ct

  tags = local.tags
}
