#!/bin/bash
apt-get update;
sudo apt-get install \
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
apt-get update;
apt-get install docker-ce docker-ce-cli containerd.io;
service docker start ;
