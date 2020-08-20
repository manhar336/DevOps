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

echo  "Install and configure PostgreSQL" >> /tmp/sonarqube-output.txt

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'

wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

echo "Install the PostgreSQL database server" >> /tmp/sonarqube-output.txt
sudo apt-get -y install postgresql postgresql-contrib

echo "Start PostgreSQL server and enable it to start automatically at boot time"
sudo systemctl start postgresql
sudo systemctl enable postgresql

echo "Change the password for the default PostgreSQL user" >> /tmp/sonarqube-output.txt
sudo passwd postgres

echo "Switch to the postgres user"  >> /tmp/sonarqube-output.txt
su - postgres

echo "Create a new user by typing"  >> /tmp/sonarqube-output.txt
createuser sonar

echo  "Switch to the PostgreSQL shell"  >> /tmp/sonarqube-output.txt

psql

echo "Set a password for the newly created user for SonarQube database."  >> /tmp/sonarqube-output.txt

ALTER USER sonar WITH ENCRYPTED password 'P@ssword';

echo  "Create a new database for PostgreSQL database by running"

CREATE DATABASE sonar OWNER sonar;

echo "Exit from the psql shell"

\q

echo "Switch back to the sudo user by running the exit command"

exit

echo "Download and configure SonarQube" >> /tmp/sonarqube-output.txt
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.3.zip

echo "Unzip the archive using the following command" >> /tmp/sonarqube-output.txt 

sudo unzip sonarqube-7.3.zip -d /opt

echo "Rename the directory:" >> /tmp/sonarqube-output.txt

sudo mv /opt/sonarqube-7.3 /opt/sonarqube

echo "Assign permissions to administrator user for directory /opt/sonarqube" >> /tmp/sonarqube-output.txt

sudo chown -R root:root /opt/sonarqube/

echo "Open the SonarQube configuration file using your favorite text editor." >> /tmp/sonarqube-output.txt

sudo vi /opt/sonarqube/conf/sonar.properties

echo "Find the following lines." >> /tmp/sonarqube-output.txt

#sonar.jdbc.username=
#sonar.jdbc.password=

sonar.jdbc.username=sonar
sonar.jdbc.password=P@ssword

echo "Next, find:" >> /tmp/sonarqube-output.txt
#sonar.jdbc.url=jdbc:postgresql://localhost/sonar

echo "Finally, tell SonarQube to run in server mode :" >> /tmp/sonarqube-output.txt
sonar.web.javaAdditionalOpts=-server

echo "Configure Systemd service" >> /tmp/sonarqube-output.txt

sudo vi /etc/systemd/system/sonar.service

[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop

User=root
Group=root
Restart=always

[Install]
WantedBy=multi-user.target

echo "Start the application by running:" >> /tmp/sonarqube-output.txt
sudo systemctl start sonar

echo "Enable the SonarQube service to automatically start at boot time." >> /tmp/sonarqube-output.txt
sudo systemctl enable sonar

echo "To check if the service is running, run:" >> /tmp/sonarqube-output.txt
sudo systemctl status sonar

echo "Setup Nginx" >> /tmp/sonarqube-output.txt

echo "Now that we've got the SonarQube server running, it's time to configure Nginx. Start by creating a new Nginx configuration file for the site:" >> /tmp/sonarqube-output.txt

apt-get install nginx

sudo vi /etc/nginx/sites-enabled/sonarqube

echo "Add this configuration so that Nginx will be able to route incoming traffic to SonarQube:"  >> /tmp/sonarqube-output.txt 

server{
    listen      9000;
    server_name sonarqube.developerinsider.co;

    access_log  /var/log/nginx/sonar.access.log;
    error_log   /var/log/nginx/sonar.error.log;

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;

    location / {
        proxy_pass  http://127.0.0.1:9000;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        proxy_redirect off;

        proxy_set_header    Host            $host;
        proxy_set_header    X-Real-IP       $remote_addr;
        proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto http;
    }
}

echo "Save and close the file. Next, make sure your configuration file has no syntax errors:" >> /tmp/sonarqube-output.txt

sudo nginx -t

echo "If you see errors, fix them and run sudo nginx -t again. Once there are no errors, restart Nginx:" >> /tmp/sonarqube-output.txt

sudo service nginx restart

# Setting Up SonarQube

# To set up your installation navigate to your server's domain name or public IP address: http://server_domain_name_or_IP.

# If you ve setup in you local system then visit http://127.0.0.1:9000/

# For more details you can read Sonarqube Official docs here.
# https://docs.sonarqube.org/latest/