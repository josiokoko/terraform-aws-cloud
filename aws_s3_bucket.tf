terraform {
  backend "s3" {
    bucket = "joe-terraform-09-09"
    key    = "terraform.tfstate"
    region = var.region
  }
}