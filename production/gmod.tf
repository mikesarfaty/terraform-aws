module "gmod-asg" {
  source            = "../modules/asg"
  name              = "garrysmod"
  ssh_key_pair_name = aws_key_pair.main_ssh_key.key_name
  extra_sg_ids      = [aws_security_group.allow_ssh.id]

  tags = local.tags

  depends_on = [
    module.network
  ]
}
