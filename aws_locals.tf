locals {
  az_names            = data.aws_availability_zones.azs.names
  public_subnets_ids  = aws_subnet.publicsubnet.*.id
  private_subnets_ids = aws_subnet.privatesubnet.*.id

  env_tags = {
    Environment = "${terraform.workspace}"
  }

  web_tags = merge(var.web_tags, local.env_tags)
}

