#!/bin/bash

echo "STEP-1 : Update the Repository" >> /tmp/execution-output.txt 

# Update the Repository on Ubuntu 18.04
sudo apt-get update 

echo "STEP-2 : Installing of Utility Softwares i.e. vim curl elinks unzip wget tree git" >> /tmp/execution-output.txt 

# Install required utility softwares 
sudo apt-get install vim curl elinks unzip wget tree git -y 

echo "`vim --version`" >> /tmp/execution-output.txt   #validating and redirecting ,we need to run in local then only update in script
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

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /etc/environment 

echo "STEP-6 : Compile the Configuration" >> /tmp/execution-output.txt

# Compile the Configuration 
source /etc/environment

echo "STEP-7 : Calling/Accessing Environment Variables" >> /tmp/execution-output.txt

# Call the Environment Variable of Java
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

echo "STEP-8 : Add Jenkins Repository" >> /tmp/jenkins-output.txt
# Add Jenkins Repository (https://www.jenkins.io/doc/book/installing/#debianubuntu)
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

echo "STEP-9 : Adding the Jenkins Remote Repository URL in Ubuntu Local Repository Configuration file" >> /tmp/jenkins-output.txt

# Adding the Jenkins Remote Repository URL in Ubuntu Local Repository Configuration file 
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/' > /etc/apt/sources.list.d/jenkins.list

echo "STEP-10 : Update the Repository" >> /tmp/jenkins-output.txt
sudo apt-get update

echo "STEP-11 : Install Jenkins on Ubuntu 18.04" >> /tmp/jenkins-output.txt
sudo apt-get install jenkins -y 

echo "STEP-12 : Check the Jenkins Daemon, Enable at boot level & Start" >> /tmp/jenkins-output.txt

sudo systemctl status jenkins.service 
echo "`sudo systemctl status jenkins.service`" >> /tmp/jenkins-output.txt

sudo systemctl enable jenkins.service 
echo "`sudo systemctl enable jenkins.service`" >> /tmp/jenkins-output.txt

sudo systemctl restart jenkins.service
echo "`sudo systemctl restart jenkins.service`" >> /tmp/jenkins-output.txt
 
sudo systemctl status jenkins.service 
echo "`sudo systemctl status jenkins.service`" >> /tmp/jenkins-output.txt


