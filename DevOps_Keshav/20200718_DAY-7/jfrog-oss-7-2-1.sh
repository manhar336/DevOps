#!/bin/bash

echo "STEP-1 : Update the Repository" >> /tmp/execution-output.txt 

# Update the Repository on Ubuntu 18.04
sudo apt-get update 

echo "STEP-2 : Installing of Utility Softwares i.e. vim curl elinks unzip wget tree git" >> /tmp/execution-output.txt 

# Install required utility softwares 
sudo apt-get install vim curl elinks unzip wget tree git -y 

echo "`vim --version`" >> /tmp/execution-output.txt 
echo "`curl --version`" >> /tmp/execution-output.txt 
echo "`elinks --version`" >> /tmp/execution-output.txt 
echo "`unzip --version`" >> /tmp/execution-output.txt 
echo "`wget --version`" >> /tmp/execution-output.txt
echo "`tree --version`" >> /tmp/execution-output.txt
echo "`git --version`" >> /tmp/execution-output.txt 

echo "STEP-3 : Download, & Install OpenJDK i.e. Java 1.8" >> /tmp/execution-output.txt

# Download, Install Java 1.8 
sudo apt-get install openjdk-8-jdk -y 

echo "STEP-4 : Validating the Java Version" >> /tmp/execution-output.txt

# Capture command output 
echo "`java -version`" >> /tmp/execution-output.txt 

echo "STEP-5 : Configure Envionment Variable for Java for All Users" >> /tmp/execution-output.txt

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /etc/environment 

echo "Compile the Configuration" >> /tmp/execution-output.txt

# Compile the Configuration 
source /etc/environment

echo "Calling/Accessing Environment Variables" >> /tmp/execution-output.txt

# Call Environment Variable
echo $JAVA_HOME >> /tmp/execution-output.txt 

# Install Maven 
sudo apt-get install maven -y

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables 
echo "MAVEN_HOME=/usr/share/maven" >> /etc/environment 

# Compile the Configuration 
source /etc/environment

# Capture command output 
echo $MAVEN_HOME >> /tmp/execution-output.txt 

echo "`mvn --version`" >> /tmp/execution-output.txt

echo "STEP-8 : Download Jfrog Artifactory" >> /tmp/jfrog-output.txt.txt

# Download the Jfrog Artifactory 
wget https://keshavkummari-dev.s3.us-east-2.amazonaws.com/jfrog-artifactory-oss-7.2.1.deb

# Install manually using dpkg command 
dpkg -i jfrog-artifactory-oss-7.2.1.deb

# Enable the Daemon at Boot Level
systemctl enable artifactory.service 

# Start the Daemon 
systemctl start artifactory.service

# Check the Status of the Daemon
systemctl status artifactory.service


# Jfrog Default UserName & PassWord 

# admin
# password 



wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | apt-key add -;
#echo "deb https://jfrog.bintray.com/artifactory-pro-debs {distribution} main" | sudo tee -a /etc/apt/sources.list;
echo "deb https://jfrog.bintray.com/artifactory-pro-debs {lsb_release} main" | sudo tee -a /etc/apt/sources.list;

# To determine your distribution, run lsb_release -c or cat /etc/os-release
# Example: echo "deb https://jfrog.bintray.com/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list;
apt-get update;
sudo apt-get install jfrog-artifactory-oss
