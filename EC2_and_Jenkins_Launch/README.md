#1.Ensure that your software packages are up to date on your instance by using the following command to perform a quick software update:
sudo yum update

#2. Add the Jenkins repo using the following command:
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

#3. Import a key file from Jenkins-CI to enable installation from the package:
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

#4. Upgrade the software packages once again:
sudo yum upgrade

#5. Install Java:
sudo yum install java-17-amazon-corretto -y
