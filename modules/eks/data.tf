locals {
  k8s_image_id_ssm_path = "/aws/service/eks/optimized-ami/${var.kubernetes_version}/amazon-linux-2/recommended/image_id"

  subnet_tag_filter = var.in_public_subnets ? module.global.standard_public_subnet_tags : module.global.standard_private_subnet_tags
}

data "aws_ssm_parameter" "kubernetes_image" {
  name = local.k8s_image_id_ssm_path
}

data "aws_subnets" "standard_instance_subnets" {
  tags = local.subnet_tag_filter
}
