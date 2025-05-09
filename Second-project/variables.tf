variable "cidr" {
  default = "10.0.0.0/16"
}
variable "key_name" {
  description = "Key pair name"
  type        = string
  default = "terraform-key"
}
