FROM debian:buster

EXPOSE 3306

ENV    DEBIAN_FRONTEND noninteractive

RUN    apt update  -y && \
       apt upgrade -y && \
       cd tmp && \
       apt-get install wget vim  lsb-release gnupg  -y && \
       echo "mysql-apt-config mysql-apt-config/select-server select mysql-5.7" | debconf-set-selections && \
       wget http://repo.mysql.com/mysql-apt-config_0.8.13-1_all.deb && \
       dpkg -i mysql-apt-config_0.8.13-1_all.deb && \
       apt update -y && \
       apt install mysql-server  -y
COPY  ./srcs/start.sh  ./start.sh
COPY ./srcs/init_db.sh ./init_db.sh
COPY  ./srcs/data.sql ./data.sql

RUN chmod +x start.sh; 
chmod +x init_db.sh ;
 /bin/bash init_db.sh

ENTRYPOINT ["/bin/bash","./start.sh"]