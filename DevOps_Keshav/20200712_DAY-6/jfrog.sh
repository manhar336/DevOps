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

# Go to /opt directory to download Apache Tomcat 
cd /opt/

# Add Jenkins Repository 
sudo wget https://api.bintray.com/content/jfrog/artifactory/org/artifactory/oss/jfrog-artifactory-oss/$latest/jfrog-artifactory-oss-$latest-linux.tar.gz?bt_package=jfrog-artifactory-oss


echo "STEP-9 : Extract the Jfrog Artifacgtory File" >> /tmp/jfrog-output.txt.txt

sudo tar xvzf jfrog-artifactory-oss-6.0.0.tar.gz

#echo "STEP-10 : Rename the Tomcat Folder" >> /tmp/jfrog-output.txt.txt
#sudo mv jfrog-artifactory-oss-6.0.0.tar.gz tomcat 

# Create Environment Variables 
echo "JFROG_HOME=/opt/jfrog-artifactory-oss-6.0.0/" >> /etc/environment 

#export JFROG_HOME=<full path of the jfrog directory>
export JFROG_HOME=/opt/jfrog-artifactory-oss-6.0.0/

echo "STEP-10 : Compile the Configuration" >> /tmp/execution-output.txt

# Compile the Configuration 
source /etc/environment

echo "STEP-11 : Calling/Accessing Environment Variables" >> /tmp/execution-output.txt
# Capture command output 
echo $JFROG_HOME >> /tmp/execution-output.txt 

echo "STEP-12 : Go Inside the Jfrog Folder" >> /tmp/jfrog-output.txt.txt
cd /opt/jfrog-artifactory-oss-6.0.0/


echo "STEP-13 : Start Jfrog Artifactory Server" >> /tmp/jfrog-output.txt.txt
cd /opt/jfrog-artifactory-oss-6.0.0/bin/
./artifactory.sh 

echo "STEP-14 : Validate Jfrog Artifactory" >> /tmp/jfrog-output.txt.txt
ps -aux | grep jfrog >> /tmp/jfrog-output.txt.txt


# Adding Jfrog Repo Key
wget -qO - https://api.bintray.com/orgs/jfrog/keys/gpg/public.key | apt-key add -

echo "deb https://jfrog.bintray.com/artifactory-pro-debs {distribution} main" | sudo tee -a /etc/apt/sources.list
# To determine your distribution, run lsb_release -c or cat /etc/os-release
# Example: echo "deb https://jfrog.bintray.com/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list;

echo "deb https://jfrog.bintray.com/artifactory-pro-debs xenial main" | sudo tee -a /etc/apt/sources.list

apt-get update

sudo apt-get install jfrog-artifactory-oss

wget https://bintray.com/jfrog/artifactory-rpms/rpm -O bintray-jfrog-artifactory-rpms.repo

