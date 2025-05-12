variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  type    = string
  default = "ami-0f88e80871fd81e91"
}

variable "key_name" {
  default = "terraform-key"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}
