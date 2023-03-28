# Not convinced I need this yet
resource "aws_internet_gateway" "main" {
  count  = 0
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "${var.network_prefix}.igw"
  }, var.tags)
}
