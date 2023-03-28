locals {
  workload_nodegroup_name = "workload"
}

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids              = data.aws_subnets.standard_instance_subnets.ids
  }

  tags = var.tags

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.vpc_resource_controller,
  ]
}

module "workload_nodegroup" {
  source             = "../nodegroup"
  cluster_name       = aws_eks_cluster.main.name
  kubernetes_version = aws_eks_cluster.main.version
  name               = local.workload_nodegroup_name
  tags               = var.tags
  key_pair_name      = var.key_pair_name
  subnet_ids         = data.aws_subnets.standard_instance_subnets.ids
}
