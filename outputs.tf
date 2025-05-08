output "nlb_dns_name" {
  description = "NLB DNS name"
  value       = aws_lb.nlb.dns_name
}