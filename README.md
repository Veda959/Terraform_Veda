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
| `userdata.sh`  | Script run on EC2 launch to install Apache or Nginx |
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


## 📤 Outputs
After deployment, Terraform shows:

NLB DNS name → Access this in the browser to see if EC2 is responding.

EC2 public IPs (if needed)

## 🔐 Security
Security Group allows HTTP (80) from the internet to EC2 via NLB.

Only SSH from your IP (optional).

## 🚨 Clean Up
To avoid AWS charges, destroy infrastructure after testing:
terraform destroy

