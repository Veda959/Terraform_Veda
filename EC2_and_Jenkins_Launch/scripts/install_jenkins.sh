#!/bin/bash

# Update system
sudo yum update -y

# Install Java 11 (required for Jenkins)
sudo amazon-linux-extras enable corretto11
sudo yum install -y java-11-amazon-corretto

# Add Jenkins repo (with correct GPG key)
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
sudo yum install -y jenkins

# Enable and start Jenkins
sudo systemctl enable jenkins
sudo systemctl start jenkins
