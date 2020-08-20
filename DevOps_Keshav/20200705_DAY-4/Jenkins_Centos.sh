#!/bin/bash
#Purpose: Install Jenkins automatically on Centos 7.8
#Created On :11-07-2020
#Created by  : Manohar Dharmala
echo "STEP-1: Update the repository in Centos 7 " >> /tmp/repositoryupdate.txt
#update repository in centos 7.8
sudo  yum install update >> /tmp/repositoryupdate.txt

echo "STEP-2: Installing of Utility Softwares i.e. vim curl elinks unzip wget tree git /n" >> /tmp/Utilitysoftwareupdateandverification.txt
#Install required Utility softwares
sudo yum install vim curl elinks unzip wget tree git -y >> /tmp/Utilitysoftwareupdateandverification.txt

#Verification of Utility software installtion 
echo "`vim --version`;`curl --version`;`elinks --version`;`unzip -v`;`wget --version`;`tree --version`;`git --version`" >> /tmp/Utilitysoftwareupdateandverification.txt

echo "STEP-3 : Download, & Install OpenJDK i.e. Java 1.8" >> /tmp/Javainstalltionandverification.txt

#Download,Install Java 1.8
sudo yum install java-1.8.0-openjdk -y  >> /tmp/Javainstalltionandverification.txt

echo "STEP-4 : Validating the Java Version" >> /tmp/Javainstalltionandverification.txt

#Verify Java version and Java installtion path
echo "`java -version`;`ls -ltr /usr/lib/jvm/java-1.8.0-openjdk`" >> /tmp/Java-environment-variableupdate.txt

echo "STEP-5 : Configure Envionment Variable for Java for All Users" >> /tmp/Java-environment-variableupdate.txt

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> /etc/environment 

echo "STEP-6 : Compile the Configuration" >> /tmp/Java-environment-variableupdate.txt

# Compile the Configuration 
source /etc/environment

echo "STEP-7 : Calling/Accessing Environment Variables" >> tmp/Java-environment-variableupdate.txt
# Capture command output 
echo $JAVA_HOME >> /tmp/Javaenvironmentvariableupdate.txt

echo "STEP-8 : Adding the Jenkins Remote Repository URL in Centos Local Repository Configuration file" >> /tmp/jenkinsrepositoryupdate.txt
# Add Jenkins Repository 
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo >> /tmp/jenkinsrepositoryupdate.txt

#Add Jenkins Repository
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key 

echo "STEP-10 : Update the Repository" >> /tmp/jenkinsinstalltionandverification.txt
sudo yum upgrade 

echo "STEP-11 : Install Jenkins on Centos 7.8" >> /tmp/jenkinsinstalltionandverification.txt
sudo yum  install jenkins -y 

echo "STEP-12 : Check the Jenkins Daemon, Enable at boot level & Start" >> /tmp/jenkinsinstalltionandverification.txt

sudo systemctl status jenkins.service 
echo "`sudo systemctl status jenkins.service`" >> /tmp/jenkinsinstalltionandverification.txt

sudo systemctl enable jenkins.service 
echo "`sudo systemctl enable jenkins.service`" >> /tmp/jenkinsinstalltionandverification.txt

sudo systemctl restart jenkins.service
echo "`sudo systemctl restart jenkins.service`" >> /tmp/jenkinsinstalltionandverification.txt
 
sudo systemctl status jenkins.service 
echo "`sudo systemctl status jenkins.service`" >> /tmp/jenkinsinstalltionandverification.txt

sudo systemctl  stop firewalld 














