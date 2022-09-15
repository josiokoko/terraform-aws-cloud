
resource "aws_s3_bucket" "web_s3" {
  bucket = var.s3_bucket

  tags = {
    Name        = "joe-app-me"
    Environment = "${terraform.workspace}"
  }
}