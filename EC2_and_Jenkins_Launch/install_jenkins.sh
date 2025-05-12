#!/bin/bash
set -e

# Update system packages
sudo yum update -y

# Enable and install Java 11
sudo amazon-linux-extras enable corretto11 -y
sudo yum install -y java-11-amazon-corretto

# Remove any broken/old Jenkins configuration
sudo yum remove -y jenkins || true
sudo rm -f /etc/yum.repos.d/jenkins.repo
sudo rm -f /usr/lib/systemd/system/jenkins.service

# Add Jenkins repository and import the latest GPG key
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo yum install -y jenkins

# Reload daemon and enable Jenkins to start on boot
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable jenkins
sudo systemctl start jenkins
