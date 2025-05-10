# AWS Infrastructure with Terraform and used ALB + 2 EC2 Instances + 2 Subnets(High Availability Zones) + 2 Target Groups

# 🚀 Terraform AWS Infrastructure Deployment

This project automates the deployment of a **high-availability web application infrastructure** on AWS using **Terraform**. It provisions networking components, EC2 instances, security settings, and an **Application Load Balancer (ALB)** to serve two web applications hosted on different paths.

---

## 📂 Project Structure

```
.
├── main.tf             # Core Terraform configuration
├── provider.tf         # Provider and region definition
├── variables.tf        # Input variable for CIDR block
├── userdata.sh         # User data for Server 1 (App1)
├── userdata1.sh        # User data for Server 2 (App2)
├── .gitignore          # Git ignore file for Terraform artifacts
```

---

## 🧱 Infrastructure Overview

The project creates the following resources:

- **VPC** with 2 subnets in different AZs
- **Internet Gateway**, **Route Table**, and associations
- **Security Group** allowing HTTP and SSH
- **2 EC2 Instances** in separate subnets
- **User data scripts** to host different HTML apps
- **Application Load Balancer** with path-based routing
- **Two Target Groups** with health checks
- **Output** URLs for app access

---

## 📜 Prerequisites

- Terraform v1.5+
- AWS CLI configured (`aws configure`)
- AWS access credentials (IAM user with EC2, VPC, ALB permissions)
- A key pair in AWS named `terraform-key` (or update in `main.tf`)
- (Optional) S3 bucket if using image downloads in `userdata.sh`

---

## 🛠️ How to Use

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/terraform-aws-infra.git
cd terraform-aws-infra
```

### 2. Initialize Terraform

```bash
terraform init
```

Initializes the working directory and downloads the required provider plugins.

### 3. Preview the Resources to be Created

```bash
terraform plan
```

Shows the execution plan and the resources that will be provisioned.

### 4. Apply the Configuration

```bash
terraform apply
```

Type `yes` when prompted to confirm resource creation.

---

## 🏗️ Step-by-Step Resource Breakdown

### 🕸️ Networking

- **VPC**:
  - CIDR Block: `10.0.0.0/16`
- **Subnets**:
  - `10.0.0.0/24` in `us-east-1a`
  - `10.0.1.0/24` in `us-east-1b`
- **Internet Gateway**:
  - Provides internet access to the subnets
- **Route Table**:
  - Default route (`0.0.0.0/0`) via the IGW
- **Associations**:
  - Both subnets associated with the custom route table

### 🔐 Security

- **Security Group** (`webSg`):
  - Allows inbound HTTP (`80`) and SSH (`22`) from anywhere
  - Allows all outbound traffic

### 🖥️ EC2 Instances

- **AMI**: `ami-0261755bbcb8c4a84` (Ubuntu-based public AMI)
- **Instance Type**: `t2.micro`
- **Key Pair**: `terraform-key`
- **User Data**:
  - Server 1 hosts App1 at `/app1/`
  - Server 2 hosts App2 at `/app2/`
  - Both install Apache and display dynamic EC2 instance metadata in HTML

### 🌐 Application Load Balancer

- **ALB**:
  - Public-facing (internet-facing)
  - Listens on HTTP port 80
- **Target Groups**:
  - `tg1` → Webserver 1 → `/app1/*`
  - `tg2` → Webserver 2 → `/app2/*`
  - Both use health checks with `HTTP 200` matchers
- **Listener Rules**:
  - `/app1/*` forwarded to App1
  - `/app2/*` forwarded to App2
  - All others → `404 Not Found`

---

## 🔎 Outputs

After deployment, Terraform outputs:

- **ALB DNS Name**: Public endpoint of the load balancer
- **App URLs**:
  - `http://<ALB_DNS>/app1/`
  - `http://<ALB_DNS>/app2/`

Example:

```bash
alb_dns_name = myalb-1234567890.us-east-1.elb.amazonaws.com
app1_url     = http://myalb-1234567890.us-east-1.elb.amazonaws.com/app1/
app2_url     = http://myalb-1234567890.us-east-1.elb.amazonaws.com/app2/
```

---

## 🧹 Clean Up

To destroy all resources created by Terraform:

```bash
terraform destroy
```

---

## 📄 Notes

- Make sure the **key pair** `terraform-key` exists in your AWS account before deployment.
- You can customize the **user data** scripts to install different applications or services.
- To add HTTPS, consider using ACM + HTTPS listener on port 443.

---

## 📸 Demo Preview

Each server serves a simple animated HTML page showing:
- Server identity
- Instance metadata
- A welcome message

---

