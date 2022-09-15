# Create EIP for NAT GW1  
resource "aws_eip" "eip_natgw" {
  vpc = true
}



resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_natgw.id
  subnet_id     = local.public_subnets_ids[0]
  tags = {
    Name = "gw NAT"
  }
}