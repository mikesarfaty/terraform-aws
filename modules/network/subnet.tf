data "aws_availability_zones" "current_region" {}

module "global" {
  source = "../global"
}

locals {
  ## Logic for subnet division.
  ## We want to do log(2)n_subnets, which will get us the amount of bits to 
  ## seperate each subnet by, then run that into cidrsubnet(subnet_idx, numbits, netnum)
  ## to get an individ. subnets range. We will tag/export these values, so it should
  ## not matter which divisions are private/public. For clarity sake, we will assign private
  ## CIDRs first
  n_subnets            = var.private_subnet_ct + var.public_subnet_ct
  numbits              = log(local.n_subnets, 2)
  public_subnet_offset = var.private_subnet_ct # netnum initial value for public subnets

  aws_azs = data.aws_availability_zones.current_region.names
}

resource "aws_subnet" "private" {
  count = var.private_subnet_ct

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, local.numbits, count.index)
  availability_zone = local.aws_azs[count.index % length(local.aws_azs)]

  tags = merge({
    Name = "${var.network_prefix}-private-${format("%02d", count.index + 1)}"
    },
    var.tags,
  module.global.standard_private_subnet_tags)
}

resource "aws_subnet" "public" {
  count = var.public_subnet_ct

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, local.numbits, count.index + local.public_subnet_offset)
  availability_zone = local.aws_azs[count.index % length(local.aws_azs)]

  tags = merge({
    Name = "${var.network_prefix}-public-${format("%02d", count.index + 1)}"
    },
    var.tags,
  module.global.standard_public_subnet_tags)

  map_public_ip_on_launch = true
}
