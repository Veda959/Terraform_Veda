# Main Project (AWS Cloud + Min 2, Max 5 EC2 Instances Launch with AutoScaling Groups + NLB)
# 🚀 Terraform AWS Infrastructure Project

This project automates the deployment of a basic web application infrastructure on AWS using Terraform. It includes setting up a VPC, public subnets, route tables, a launch template, an Auto Scaling Group, a Network Load Balancer, and an S3 bucket with a sample object.

# ✅ Project Objective

Provision a scalable and highly available web server infrastructure in AWS using Terraform, with the following components:

- A Virtual Private Cloud (VPC) with public subnets

- Internet access via an Internet Gateway

- Launch Template for EC2 instances running a simple web server

- Auto Scaling Group across two Availability Zones

- Network Load Balancer (NLB)

- Secure access via Security Groups

- S3 bucket to store files (e.g., demo file)

# Basic Plan:

![image](https://github.com/user-attachments/assets/0bbb62ee-b495-4237-861d-45eaf5d60668)


# 📦 Requirements

- Terraform (>= 1.0)

- AWS CLI configured with valid credentials

- Git (for version control)

- AWS account with sufficient permissions (EC2, VPC, ELB, S3, IAM)


# ✅ Architecture Diagram:

![ChatGPT Image May 8, 2025, 04_24_37 PM](https://github.com/user-attachments/assets/e9181700-e627-4ca7-9818-d27935783fb4)


# 🧾 Variables Used

You should define these in a **variables.tf** or use a **terraform.tfvars** file:
```
variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
```

# 📁 Modules and Resources Breakdown

## 1. VPC and Networking

- **aws_vpc.main**: Creates the main VPC

- **aws_subnet.subnet_a, subnet_b**: Two public subnets in different AZs

- **aws_internet_gateway.igw**: Provides internet access

- **aws_route_table.public + associations**: Routes outbound traffic through IGW

## 2. Security

- **aws_security_group.instance_sg**: Allows inbound SSH and HTTP, outbound all

## 3. Compute

- **aws_launch_template.web**: Defines EC2 launch config with user data to install Apache and serve a message

- **aws_autoscaling_group.web_asg**: Manages EC2 instances across AZs

## 4. Load Balancer

- **aws_lb.nlb**: Network Load Balancer

- **aws_lb_target_group.web**: Target group for EC2 instances

- **aws_lb_listener.web**: Forwards traffic from NLB to target group

## 5. S3

- **aws_s3_bucket.veda_bucket**: S3 bucket for demo use

- **aws_s3_object.demo_file**: Uploads a sample file to the bucket

- **random_id.bucket_suffix**: Ensures bucket name uniqueness

# 🛠️ How to Use

## 1. Clone the repository

```
git clone https://github.com/Veda959/Terraform_Veda.git
cd Terraform_Veda
```

## 2. Configure AWS credentials (if not done)

```
aws configure
```

## 3. Initialize Terraform

```
terraform init
```

## 4. Plan infrastructure

```
terraform plan
```

## 5. Apply configuration

```
terraform apply
```

## 6. To destroy infrastructure

```
terraform destroy
```

# 📌 Notes

- Make sure your region matches across all resources.

- The S3 bucket name must be globally unique; the random_id helps ensure that.

- Ensure your AWS account has quota for EC2, ASG, NLB, etc.

# 📂 Project Structure

```
Terraform_Veda/
├── main.tf              # All infrastructure resources
├── variables.tf         # Input variable declarations
├── providers.tf         # The region of the Infrastructure
├── terraform.tfvars     # Values for input variables (optional)
├── outputs.tf           # (Optional) Outputs like ALB DNS, instance IPs
└── README.md            # Project documentation
```

# 🚨 Clean Up
To avoid AWS charges, destroy infrastructure after testing:
**terraform destroy**
