output "s3_bucket_name" {
  value = aws_s3_bucket.veda_bucket.bucket
}

output "nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}
