#!/bin/bash
service docker stop;
minikube stop;
apt purge  docker-ce docker-ce-cli containerd.io qemu-kvm libvirt-daemon libvirt-daemon-system virtinst bridge-utils -y
if [ -f "/usr/local/bin/minikube" ];then 
	rm -rf /usr/local/bin/minikube
fi
if [ -f "/usr/local/bin/docker-machine-driver-kvm2" ];then 
rm -rf /usr/local/bin/docker-machine-driver-kvm2
fi

apt autoremove -y ;
apt-get update -y;
sudo apt-get install -y\
 apt-transport-https \
	ca-certificates \
	curl \
	git \
	gnupg-agent \
	software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
apt-key fingerprint 0EBFCD88;
add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	      $(lsb_release -cs) \
		     stable";

apt-get update -y;
apt-get install -y docker-ce docker-ce-cli containerd.io;
echo "installing docker [Ok]"
echo "installin kuber  >>>"
apt -y install qemu-kvm libvirt-daemon libvirt-daemon-system virtinst bridge-utils;
apt -y install apt-transport-https gnupg2 curl ;
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list;
 apt update;
 apt -y install kubectl;
 wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -O minikube;
 wget https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2;
 chmod 755 minikube docker-machine-driver-kvm2;
 mv minikube docker-machine-driver-kvm2 /usr/local/bin/;
echo "installing kuber [ok]"
 
if test -d "./kuber" ;then rm -rf  ./kuber; fi

git clone https://github.com/lalouabd/kubers.git; 2>&1


while [ $? != 0 ]
do
echo " trying to reach github "
git clone https://github.com/lalouabd/kuber.git; 2>&1
done

cd kuber;

docker build ./srcs/pods/mysql/  -t mysql;



