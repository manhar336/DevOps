
# Install below set of softwares on Master and Nodes 

#!/bin/bash
sudo apt-get update 
sudo apt-get install vim curl unzip wget git apt-transport-https -y 
sudo apt-get update 
sudo apt-get install docker.io -y 
sudo usermod -aG docker ubuntu
sudo chmod 777 /var/run/docker.sock 
sudo systemctl status docker.service
sudo systemctl enable docker.service
sudo systemctl restart docker.service
sudo apt-get update 
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update 
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl



Master :

ubuntu@master:~$ sudo kubeadm init --pod-network-cidr=10.244.0.0/16

ubuntu@master:~$ mkdir -p $HOME/.kube

ubuntu@master:~$ sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

ubuntu@master:~$ sudo chown $(id -u):$(id -g) $HOME/.kube/config

ubuntu@master:~$ sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

ubuntu@master:~$ docker images

ubuntu@master:~$ docker ps


Then you can join any number of worker nodes by running the following on each as root:
# kubeadm join 172.31.35.77:6443 --token 0cbzuz.wsehymkln2lqz9q7 --discovery-token-ca-cert-hash sha256:525a8745984d4d1e816cae7e5fb0123ca521f3781016c15f5bacee3acd1f2979 

Node-1 :
sudo kubeadm join 172.31.35.77:6443 --token 0cbzuz.wsehymkln2lqz9q7 --discovery-token-ca-cert-hash sha256:525a8745984d4d1e816cae7e5fb0123ca521f3781016c15f5bacee3acd1f2979 

Node-2 : 
sudo kubeadm join 172.31.35.77:6443 --token 0cbzuz.wsehymkln2lqz9q7 --discovery-token-ca-cert-hash sha256:525a8745984d4d1e816cae7e5fb0123ca521f3781016c15f5bacee3acd1f2979 
