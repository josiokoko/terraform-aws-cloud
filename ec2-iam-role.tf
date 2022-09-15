data "template_file" "s3_web_policy" {
  template = file("scripts/iam/ec2-iam-policy.json")
  vars = {
    s3_bucket_arn = "arn:aws:s3:::${var.s3_bucket}/*"
  }
}



resource "aws_iam_role" "s3_ec2_role" {
  name               = "s3_ec2_role"
  assume_role_policy = file("scripts/iam/ec2-iam-assume-role.json")
}



resource "aws_iam_role_policy" "s3_ec2_policy" {
  name   = "s3_ec2_policy"
  role   = aws_iam_role.s3_ec2_role.id
  policy = data.template_file.s3_web_policy.rendered
}



resource "aws_iam_instance_profile" "s3_ec2_rofile" {
  name = "s3_ec2_profile"
  role = aws_iam_role.s3_ec2_role.name
}
