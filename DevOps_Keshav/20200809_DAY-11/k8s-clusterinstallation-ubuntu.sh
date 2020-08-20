
#!/bin/bash

echo "STEP-1 : Update the Repository" >> /tmp/execution-output.txt 

# Update the Repository on Ubuntu 18.04
sudo apt-get update 

echo "STEP-2 : Installing of Utility Softwares i.e. vim curl elinks unzip wget tree git" >> /tmp/execution-output.txt 

# Install required utility softwares 
sudo apt-get install vim curl unzip wget git apt-transport-https -y 

echo "`vim --version`" >> /tmp/execution-output.txt 
echo "`curl --version`" >> /tmp/execution-output.txt 
echo "`elinks --version`" >> /tmp/execution-output.txt 
echo "`unzip --version`" >> /tmp/execution-output.txt 
echo "`wget --version`" >> /tmp/execution-output.txt
echo "`tree --version`" >> /tmp/execution-output.txt
echo "`git --version`" >> /tmp/execution-output.txt 

echo "STEP-3 : Download, & Install Docker" >> /tmp/execution-output.txt
sudo apt-get update
sudo apt install docker.io -y 

echo "STEP-4 : Grant access to Ubuntu user on Docker" >> /tmp/execution-output.txt
sudo usermod -aG docker ubuntu

sudo chmod 666 /var/run/docker.sock 

echo "STEP-5 : Enable & Start the Docker Deamon" >> /tmp/execution-output.txt
sudo systemctl enable docker.service

sudo systemctl restart docker.service

echo "STEP-6 : Update ubuntu local repository" >> /tmp/execution-output.txt
sudo apt-get update 

echo "STEP-7 : Add Kubenetes apt key part of local repository" >> /tmp/execution-output.txt
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo "STEP-8 : Update the Repository on Ubuntu 18.04" >> /tmp/execution-output.txt
sudo apt-get update 

echo "STEP-9 : Install k8s on Ubuntu 18.04" >> /tmp/execution-output.txt
sudo apt-get install -y kubelet kubeadm kubectl

echo "STEP-10 : Holding the updates on k8s" >> /tmp/execution-output.txt
sudo apt-mark hold kubelet kubeadm kubectl