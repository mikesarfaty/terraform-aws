data "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  filter {
    name = "association.main"
    values = [true]
  }
}

locals {
  internet = "0.0.0.0/0"
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = local.internet
    gateway_id = aws_internet_gateway.main.id
  }
}
