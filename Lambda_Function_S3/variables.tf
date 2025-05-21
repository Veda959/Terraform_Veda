variable "region" {
  default = "us-east-1"
}

variable "source_bucket_name" {
  default = "my-source-bucket-unique-name"
}

variable "destination_bucket_name" {
  default = "my-destination-bucket-unique-name"
}

variable "lambda_function_name" {
  default = "copy_txt_lambda"
}
