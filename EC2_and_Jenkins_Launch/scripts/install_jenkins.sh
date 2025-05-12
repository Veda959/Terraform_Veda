#!/bin/bash

# Update the system
sudo dnf update -y

# Install Java (Amazon Corretto 11 for Jenkins)
sudo dnf install -y java-11-amazon-corretto

# Add the Jenkins repo
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

# Install Jenkins
sudo dnf install -y jenkins

# Start and enable Jenkins
sudo systemctl daemon-reexec
sudo systemctl enable jenkins
sudo systemctl start jenkins
