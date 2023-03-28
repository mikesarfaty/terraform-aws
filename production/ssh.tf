resource "aws_key_pair" "main_ssh_key" {
  key_name   = "mikesarfaty.ssh.id_rsa"
  public_key = file(var.public_key_path)
}
