variable "source_bucket_name" {
  description = "Source S3 bucket name"
  type        = string
  default     = "devops-user-source-bucket-2025"
}

variable "destination_bucket_name" {
  description = "Destination S3 bucket name"
  type        = string
  default     = "devops-user-destination-bucket-2025"
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "copy_txt_lambda"
}
