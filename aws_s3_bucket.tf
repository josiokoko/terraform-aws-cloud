terraform {
  backend "s3" {
    bucket = "joe-terraform-09-09"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}