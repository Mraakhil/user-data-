#!/bin/bash

# Exit immediately if a command fails
set -e

echo "======================================"
echo " Updating system packages"
echo "======================================"
sudo apt update -y

echo "======================================"
echo " Installing Java 21 (required for Jenkins)"
echo "======================================"
sudo apt install -y fontconfig openjdk-21-jre

echo "======================================"
echo " Verifying Java installation"
echo "======================================"
java -version

echo "======================================"
echo " Adding Jenkins repository and key"
echo "======================================"

# Create keyrings directory if not exists
sudo mkdir -p /etc/apt/keyrings

# Download Jenkins GPG key
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

# Add Jenkins repository
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | \
sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "======================================"
echo " Installing Jenkins"
echo "======================================"
sudo apt update -y
sudo apt install -y jenkins

echo "======================================"
echo " Enabling and starting Jenkins service"
echo "======================================"
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "======================================"
echo " Jenkins service status"
echo "======================================"
sudo systemctl status jenkins --no-pager

echo "======================================"
echo " Jenkins installation completed successfully 🎉"
echo " Access Jenkins at: http://<your-server-ip>:8080"
echo " Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

