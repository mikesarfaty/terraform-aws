module "cluster" {
  count = 0

  source             = "../modules/eks"
  kubernetes_version = "1.25"
  cluster_name       = "main"
  key_pair_name      = aws_key_pair.main_ssh_key.key_name
  tags               = local.tags
  in_public_subnets  = true ## TODO: Move logic to node_group specific

  depends_on = [
    module.network
  ]
}
