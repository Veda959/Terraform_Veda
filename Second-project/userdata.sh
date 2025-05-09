#!/bin/bash

# Log all output for troubleshooting
exec > /var/log/userdata.log 2>&1
set -x

# Update and install packages
apt-get update -y
apt-get install -y apache2 awscli

# Get the instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Install the AWS CLI
apt install -y awscli

# Download the images from S3 bucket
#aws s3 cp s3://myterraformprojectbucket2023/project.webp /var/www/html/project.png --acl public-read

# Create the directory for the application
mkdir -p /var/www/html/app1

# Create HTML content
cat <<EOF > /var/www/html/app1/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio</title>
  <style>
    @keyframes colorChange {
      0% { color: red; }
      50% { color: green; }
      100% { color: blue; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 1</h1>
  <h2>Instance ID: <span style="color:green">$INSTANCE_ID</span></h2>
  <p>Welcome to Abhishek Veeramalla's Channel</p>
</body>
</html>
EOF

# Start and enable Apache
systemctl start apache2
systemctl enable apache2
