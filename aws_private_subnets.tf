

resource "aws_subnet" "privatesubnet" {
  count             = length(slice(local.az_names, 0, 2))
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + length(local.az_names) + 1)
  availability_zone = local.az_names[count.index]

  map_public_ip_on_launch = false

  tags = {
    Project = ""
    Name    = "PrivateSubnet-${count.index + 1}"
  }
}



resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private subnet route table"
  }
}



resource "aws_route_table_association" "b" {
  count          = length(slice(local.az_names, 0, 2))
  subnet_id      = local.private_subnets_ids[count.index]
  route_table_id = aws_route_table.private_route_table.id
}