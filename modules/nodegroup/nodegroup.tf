resource "aws_eks_node_group" "example" {
  cluster_name    = var.cluster_name
  node_group_name = "workload"
  node_role_arn   = aws_iam_role.main.arn
  subnet_ids      = var.subnet_ids

  remote_access {
    ec2_ssh_key = var.key_pair_name
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
  version         = var.kubernetes_version

  tags = var.tags

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks_worker,
    aws_iam_role_policy_attachment.eks_cni,
    aws_iam_role_policy_attachment.container_regristry,
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
