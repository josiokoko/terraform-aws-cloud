resource "aws_key_pair" "web_key_pair" {
  key_name   = "web-key-pair"
  public_key = file("scripts/web.pub")
}