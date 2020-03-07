#!/bin/bash
clearn(){
if [ -d "/etc/kubernetes/" ];
then
	sudo rm -rf /etc/kubernetes
  echo removing kubere
	fi
if [ -d "/var/lib/etcd/" ];
then 
	sudo rm -rf /var/lib/etcd/ 
  echo removing etcd
fi
if [ -d "$HOME/.kube/" ];
then 
	sudo rm -rf $HOME/.kube/
  echo removing kube 
fi

if [ -d "/etc/systemd/system/kubelet.service.d/" ]; 
then 
sudo rm -rf /etc/systemd/system/kubelet.service.d/
fi
if [ -d "/etc/systemd/system/docker.service.d/" ]; 
then 
sudo rm -rf /etc/systemd/system/docker.service.d/ 
fi
if [ -d "/var/lib/docker/" ];
then 
sudo rm -rf /var/lib/docker/ 
fi
}

sudo apt-mark unhold kubelet kubeadm kubectl;

sudo dpkg --configure -a;

echo y | sudo kubeadm reset
sudo apt-get purge kubeadm kubectl kubelet kubernetes-cni kube*   
sudo apt-get autoremove  

sudo apt-get remove docker docker-engine docker.io containerd runc;
sudo apt-get  autoremove -y; 
clearn ;

sudo apt-get update -y;

sudo apt-get update && apt-get install -y  apt-transport-https ca-certificates curl software-properties-common gnupg2

### Add Docker’s official GPG key
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

### Add Docker apt repository.
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Install Docker CE.
sudo apt-get update ;
 sudo apt-get install -y containerd.io docker-ce docker-ce-cli ;

# Setup daemon.
sudo cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF



sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker 

echo "installing docker [Ok]"
echo "start setting kubdeam ..... "
sudo chmod 777 /etc/apt/sources.list.d/;
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add ; 
sudo echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list  ;
sudo apt-get update;
sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni; 
sleep 3;
sudo swapoff -a;
sleep 3;
sudo systemctl daemon-reload
sleep 6;
 sudo systemctl restart kubelet
 sleep 6;
sudo kubeadm init;
sleep 3;
sudo apt-mark hold kubelet kubeadm kubectl;
	mkdir -p $HOME/.kube/;

sudo  cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "installing kuber [ok]"
 
 if [ -d "./kuber" ];then rm -rf  ./kuber; fi

 git clone https://github.com/lalouabd/kuber.git; 2>&1


# while [ $? != 0 ];
# do
# echo " trying to reach github "
# git clone https://github.com/lalouabd/kuber.git; 2>&1
# done

 cd kuber;

sudo docker build ./srcs/pods/mysql/  -t mysql-deployment;
sudo docker build ./srcs/pods/server/ -t myserver;


sudo kubectl apply -f srcs/pods/mysql/srcs/mysql.yaml &> /dev/null

