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

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables 
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/" >> /etc/environment 

echo "STEP-6 : Compile the Configuration" >> /tmp/execution-output.txt

# Compile the Configuration 
source /etc/environment

echo "STEP-7 : Calling/Accessing Environment Variables" >> /tmp/execution-output.txt
# Capture command output 
echo $JAVA_HOME >> /tmp/execution-output.txt 

echo "STEP-8 : Download Apache Tomcat" >> /tmp/tomcat-output.txt

# Go to /opt directory to download Apache Tomcat 
cd /opt/

# Add Jenkins Repository 
sudo wget https://downloads.apache.org/tomcat/tomcat-8/v8.5.57/bin/apache-tomcat-8.5.57.tar.gz

echo "STEP-9 : Extract the Tomcat File" >> /tmp/tomcat-output.txt

sudo tar xvzf apache-tomcat-8.5.57.tar.gz

echo "STEP-10 : Rename the Tomcat Folder" >> /tmp/tomcat-output.txt
sudo mv apache-tomcat-8.5.57 tomcat 

echo "STEP-11 : Go Inside the Tomcat Folder" >> /tmp/tomcat-output.txt
cd /opt/tomcat/

# Take Tomcat Configuration as backup 
sudo cp -pvr /opt/tomcat/conf/tomcat-users.xml "/opt/tomcat/conf/tomcat-users.xml_$(date +%F_%R)"

# To delete last line and which contains </tomcat-users>
sed -i '$d' /opt/tomcat/conf/tomcat-users.xml    #need to attach roles first and then need to add </tomcat-users> 
#sed "s/\<\<tomcat\-users\>//g" /opt/tomcat/conf/tomcat-users.xml     #other method for deleting </tomcat-users>

echo "STEP-12 : Add User & Attach Roles to Tomcat i.e. /opt/tomcat/conf/tomcat-users.xml" >> /tmp/tomcat-output.txt #Roles is for 
echo '<role rolename="manager-gui"/>'         >> /opt/tomcat/conf/tomcat-users.xml   #echo "<role rolename="manager-gui"/>" ," codes wont work" 
echo '<role rolename="manager-script"/>'       >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-jmx"/>'          >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="manager-status"/>'      >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-gui"/>'            >> /opt/tomcat/conf/tomcat-users.xml
echo '<role rolename="admin-script"/>'         >> /opt/tomcat/conf/tomcat-users.xml
echo '<user username="admin" password="redhat@123" roles="manager-gui,manager-script,manager-jmx,manager-status,admin-gui,admin-script"/>' >> /opt/tomcat/conf/tomcat-users.xml
echo "</tomcat-users>" >> /opt/tomcat/conf/tomcat-users.xml

echo "STEP-13 : Start Tomcat Server" >> /tmp/tomcat-output.txt
cd /opt/tomcat/bin/
./startup.sh

echo "STEP-14 : Validate Tomcat" >> /tmp/tomcat-output.txt
ps -aux | grep tomcat >> /tmp/tomcat-output.txt

#Verification in browser
#http://192.168.1.8:8080
#http://192.168.1.8:8080/manager/html
#http://192.168.1.8:8080/host-manager/html 




