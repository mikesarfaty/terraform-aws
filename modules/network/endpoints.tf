# We need endpoints for private subnets, only

resource "aws_vpc_endpoint" "ec2" {
  count             = var.private_subnet_ct > 0 ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ec2"
  vpc_endpoint_type = "Interface"

  tags = var.tags
}

resource "aws_vpc_endpoint_subnet_association" "ec2_vpce" {
  count           = var.private_subnet_ct
  vpc_endpoint_id = aws_vpc_endpoint.ec2[0].id
  subnet_id       = aws_subnet.private[count.index].id
}

resource "aws_vpc_endpoint" "ecr_api" {
  count             = var.private_subnet_ct > 0 ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"

  tags = var.tags
}

resource "aws_vpc_endpoint_subnet_association" "ecr_api_vpce" {
  count           = var.private_subnet_ct
  vpc_endpoint_id = aws_vpc_endpoint.ecr_api[0].id
  subnet_id       = aws_subnet.private[count.index].id
}


resource "aws_vpc_endpoint" "ecr_dkr" {
  count             = var.private_subnet_ct > 0 ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"

  tags = var.tags
}

resource "aws_vpc_endpoint_subnet_association" "ecr_dkr_vpce" {
  count           = var.private_subnet_ct
  vpc_endpoint_id = aws_vpc_endpoint.ecr_dkr[0].id
  subnet_id       = aws_subnet.private[count.index].id
}

resource "aws_vpc_endpoint" "sts" {
  count             = var.private_subnet_ct > 0 ? 1 : 0
  vpc_id            = aws_vpc.main.id
  service_name      = "com.amazonaws.us-east-1.sts"
  vpc_endpoint_type = "Interface"

  tags = var.tags
}

resource "aws_vpc_endpoint_subnet_association" "sts_vpce" {
  count           = var.private_subnet_ct
  vpc_endpoint_id = aws_vpc_endpoint.sts[0].id
  subnet_id       = aws_subnet.private[count.index].id
}

resource "aws_vpc_endpoint" "s3" {
  count        = var.private_subnet_ct > 0 ? 1 : 0
  vpc_id       = aws_vpc.main.id
  service_name = "com.amazonaws.us-east-1.s3"

  tags = var.tags
}
