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
  <title>My Portfolio</title>
  <style>
    /* Add animation and styling for the text */
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
  <p>Welcome to CloudChamp's Channel</p>
  
</body>
</html>
EOF

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2
