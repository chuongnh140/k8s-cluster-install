#!/bin/bash


sudo apt install apt-transport-https ca-certificates curl -y

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y

#check version kube hien tai
#sudo apt-cache madison kubeadm | head -10

KUBE_VERSION=1.21.0

sudo apt install -y \
	docker.io \
	kubelet=${KUBE_VERSION}-00 \
	kubeadm=${KUBE_VERSION}-00 \
	kubectl=${KUBE_VERSION}-00

sudo apt-mark hold kubelet kubeadm kubectl


sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
"exec-opts": ["native.cgroupdriver=systemd"],
"log-driver": "json-file",
"storage-driver": "overlay2"
}
EOF'



sudo mkdir -p /etc/systemd/system/docker.service.d

sudo systemctl daemon-reload
sudo systemctl restart docker


sudo systemctl enable docker
sudo systemctl enable kubelet
