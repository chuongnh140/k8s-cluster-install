#run on master node

KUBE_VERSION=1.21.0
sudo kubeadm init --kubernetes-version=${KUBE_VERSION}

k apply -f "https://docs.projectcalico.org/v3.14/manifests/calico.yaml"


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/nchuong/.kube/config
sudo chown $(id -u):$(id -g) /home/nchuong/.kube/config
