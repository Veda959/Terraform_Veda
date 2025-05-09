#!/bin/bash

# Log all output for troubleshooting
exec > /var/log/userdata.log 2>&1
set -x

# Update and install packages
sudo apt-get update -y
sudo apt-get install -y apache2 awscli

# Get the instance ID
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)

# Create the directory for the application
sudo mkdir -p /var/www/html/app2

# Create HTML content
cat <<EOF > /var/www/html/app2/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My Portfolio - App2</title>
  <style>
    @keyframes colorChange {
      0% { color: blue; }
      50% { color: orange; }
      100% { color: purple; }
    }
    h1 {
      animation: colorChange 2s infinite;
    }
  </style>
</head>
<body>
  <h1>Terraform Project Server 2</h1>
  <h2>Instance ID: <span style="color:blue">$INSTANCE_ID</span></h2>
  <p>This is App2, served by Abhishek Veeramalla's Channel</p>
</body>
</html>
EOF

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2
