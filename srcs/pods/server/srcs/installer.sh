
#!/bin/bash

 apt update -y ;  apt install -y wget libasound2 libasound2-data; 
cat<<EOF >> /etc/apt/sources.list.d/java-8-debian.list
deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main
EOF
 apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886;
 apt-get update;
 apt-get install -y oracle-java8-installer;
 apt-get install -y oracle-java8-set-default;

java -version;