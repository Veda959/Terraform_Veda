variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  type = "String"
  default = "ami-0f88e80871fd81e91"
}

variable "key_name" {
  default = "terraform-key"
}
