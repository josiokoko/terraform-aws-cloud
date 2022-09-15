variable "region" {
  description = "Choose a default region"
  type        = string
  default     = "us-east-1"
}


variable "vpc_cidr_block" {
  description = "Choose cidr_block for vpc"
  type        = string
  default     = "10.30.0.0/16"
}

variable "web_ec2_count" {
  description = "Number of ec2 instances for web"
  type        = string
  default     = "3"
}


variable "web_instance_type" {
  description = "Choose ec2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "s3_bucket" {
  description = "s3 bucket name"
  type        = string
  default     = "ayeni-joe-s3-bucket-me"
}


variable "web_amis" {
  type = map(any)
  default = {
    us-east-1 = "ami-0c02fb55956c7d316"
    us-east-2 = "ami-0421decc121d5f462"
  }
}


variable "web_tags" {
  description = "Choose tags for web ec2"
  type        = map(any)
  default = {
    Name = "webserver"
  }
}
