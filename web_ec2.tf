resource "aws_instance" "web" {
  count                  = var.web_ec2_count
  ami                    = var.web_amis[var.region]
  instance_type          = var.web_instance_type
  subnet_id              = local.public_subnets_ids[count.index]
  user_data              = file("scripts/apache.sh")
  iam_instance_profile   = aws_iam_instance_profile.s3_ec2_rofile.name
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  tags                   = local.web_tags
  key_name               = aws_key_pair.web_key_pair.key_name
}