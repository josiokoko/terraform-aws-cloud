
resource "aws_subnet" "publicsubnet" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  availability_zone = local.az_names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Project = ""
    Name    = "PublicSubnet-${count.index + 1}"
  }
}



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "igw"
  }
}



resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public subnet route table"
  }
}



resource "aws_route_table_association" "public" {
  count          = length(local.az_names)
  subnet_id      = local.public_subnets_ids[count.index]
  route_table_id = aws_route_table.public_route_table.id
}