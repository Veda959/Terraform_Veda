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

# 📦 Requirements

- Terraform (>= 1.0)

- AWS CLI configured with valid credentials

- Git (for version control)

- AWS account with sufficient permissions (EC2, VPC, ELB, S3, IAM)

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

1. VPC and Networking
aws_vpc.main: Creates the main VPC

aws_subnet.subnet_a, subnet_b: Two public subnets in different AZs

aws_internet_gateway.igw: Provides internet access

aws_route_table.public + associations: Routes outbound traffic through IGW

2. Security
aws_security_group.instance_sg: Allows inbound SSH and HTTP, outbound all

3. Compute
aws_launch_template.web: Defines EC2 launch config with user data to install Apache and serve a message

aws_autoscaling_group.web_asg: Manages EC2 instances across AZs

4. Load Balancer
aws_lb.nlb: Network Load Balancer

aws_lb_target_group.web: Target group for EC2 instances

aws_lb_listener.web: Forwards traffic from NLB to target group

5. S3
aws_s3_bucket.veda_bucket: S3 bucket for demo use

aws_s3_object.demo_file: Uploads a sample file to the bucket

random_id.bucket_suffix: Ensures bucket name uniqueness

🛠️ How to Use
1. Clone the repository

git clone https://github.com/Veda959/Terraform_Veda.git
cd Terraform_Veda

2. Configure AWS credentials (if not done)

aws configure

3. Initialize Terraform

terraform init

4. Plan infrastructure

terraform plan

5. Apply configuration

terraform apply

6. To destroy infrastructure

terraform destroy

📌 Notes
Make sure your region matches across all resources.

The S3 bucket name must be globally unique; the random_id helps ensure that.

Ensure your AWS account has quota for EC2, ASG, NLB, etc.

📂 Project Structure

Terraform_Veda/
├── main.tf              # All infrastructure resources
├── variables.tf         # Input variable declarations
├── terraform.tfvars     # Values for input variables (optional)
├── outputs.tf           # (Optional) Outputs like ALB DNS, instance IPs
└── README.md            # Project documentation






























# Terraform NLB + ASG Project

# 📁 Suggested Project Structure
terraform-aws-autoscaling-nlb/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── terraform.tfvars
├── README.md
├── .gitignore

# 🚀 AWS Infrastructure with Terraform: Auto Scaling, NLB, EC2

This Terraform project provisions a complete AWS infrastructure including:

- **VPC**
- **Public Subnets**
- **Internet Gateway**
- **Route Tables**
- **EC2 Instances** with a user data script
- **Auto Scaling Group (ASG)**
- **Launch Template**
- **Target Group**
- **Network Load Balancer (NLB)**
- **Security Groups**

---

## 📌 Requirements

- Terraform CLI (v1.3+)
- AWS CLI configured (`aws configure`)
- AWS IAM user with required permissions
- An AWS Key Pair created (used in EC2 launch template)

---

## 🗂️ File Overview

| File           | Purpose |
|----------------|---------|
| `main.tf`      | Declares all AWS resources (VPC, subnets, IGW, ASG, NLB, EC2, Target Group, etc.) |
| `provider.tf`  | Defines AWS provider and region |
| `variables.tf` | Input variables used throughout the config |
| `outputs.tf`   | Outputs like NLB DNS or instance IPs |
| `.gitignore`   | Ignores sensitive or unnecessary files |
| `README.md`    | Documentation for the project |

---

## 🔧 How It Works

### 1. **VPC and Subnets**
- A VPC with CIDR `10.0.0.0/16` is created.
- Two public subnets across two AZs (for high availability).

### 2. **Internet Gateway**
- IGW is attached to the VPC for internet access.
- Route table allows outbound internet from public subnets.

### 3. **Launch Template**
- Defines EC2 instance type, AMI, key pair, and user data script.

### 4. **Auto Scaling Group (ASG)**
- Launches EC2 instances based on demand.
- Spans across both public subnets.
- Desired Capacity = 2; Min = 2; Max = 5

### 5. **Network Load Balancer (NLB)**
- Listens on port 80.
- Forwards traffic to a target group.

### 6. **Target Group**
- ASG instances automatically registered.
- Health checks on port 80 using HTTP.

---

## ⚙️ Commands to Deploy

```bash
# Initialize Terraform (download AWS provider)
terraform init

# (Optional) Preview what will be created
terraform plan

# Apply and create resources
terraform apply

# To destroy everything
terraform destroy

```

# 📤 Outputs
After deployment, Terraform shows:

NLB DNS name → Access this in the browser to see if EC2 is responding.
EC2 public IPs (if needed)

# 🔐 Security
Security Group allows HTTP (80) from the internet to EC2 via NLB.
Only SSH from your IP (optional).

# 🚨 Clean Up
To avoid AWS charges, destroy infrastructure after testing:
terraform destroy

