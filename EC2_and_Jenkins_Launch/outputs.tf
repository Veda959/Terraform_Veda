output "vpc_id" {
  value = aws_vpc.jenkins_vpc.id
}

output "subnet_id" {
  value = aws_subnet.jenkins_subnet.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.jenkins_igw.id
}

output "route_table_id" {
  value = aws_route_table.jenkins_route_table.id
}

output "security_group_id" {
  value = aws_security_group.jenkins_sg.id
}

output "instance_public_ip" {
  value = aws_instance.jenkins_ec2.public_ip
}

output "jenkins_url" {
  value = "http://${aws_instance.jenkins_ec2.public_ip}:8080"
}

output "ssh_access" {
  value = "ssh -i ~/.ssh/terraform-key.pem ubuntu@${aws_instance.jenkins_ec2.public_ip}"
}

