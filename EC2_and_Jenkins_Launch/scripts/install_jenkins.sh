#!/bin/bash

# Update the system
sudo yum update -y

# Install Java (Amazon Corretto 11 is supported for Jenkins)
sudo amazon-linux-extras enable corretto11
sudo yum install -y java-11-amazon-corretto

# Add the Jenkins repo
sudo curl --silent --location https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key | sudo tee /etc/pki/rpm-gpg/jenkins.io.key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo curl --silent --location -o /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Install Jenkins
sudo yum install -y jenkins

# Start and enable Jenkins
sudo systemctl daemon-reexec
sudo systemctl enable jenkins
sudo systemctl start jenkins
