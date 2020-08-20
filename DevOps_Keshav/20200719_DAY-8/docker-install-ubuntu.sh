#!/bin/bash

echo "STEP-1 : Update the Repository" >> /tmp/execution-output.txt 

# Update the Repository on Ubuntu 18.04
sudo apt-get update 
sudo apt-get -y upgrade

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

echo "STEP-6: "

sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

echo "STEP-7: Add Docker’s official GPG key:"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

echo "STEP-8: Install Docker"
sudo apt-get install docker-ce docker-ce-cli containerd.io -y 

sonar-test :

devops-sonar-test: 0287a74b82feef6c643edfa5c177519cc06a11c9

mvn sonar:sonar \
  -Dsonar.projectKey=sonar-test \
  -Dsonar.host.url=http://18.221.91.125:9000 \
  -Dsonar.login=0287a74b82feef6c643edfa5c177519cc06a11c9

mvn sonar:sonar \
  -Dsonar.projectKey=test-sonar-devops \
  -Dsonar.host.url=http://18.221.91.125:9000 \
  -Dsonar.login=50c8df5a0ec91ed8fd9dcd10b5c31a85af6ba5cc


<properties>
  <sonar.projectKey>devopstest-kesav</sonar.projectKey>
  <sonar.organization>keshavkummari</sonar.organization>
  <sonar.host.url>https://sonarcloud.io</sonar.host.url>
  <sonar.login>74b3e9598883877fb25bb2f61167adb8eba7ca40</sonar.login>
</properties>


mvn verify sonar:sonar
