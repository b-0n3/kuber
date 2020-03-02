#!/bin/bash

# Colors
blue=$'\033[0;34m'
cyan=$'\033[1;96m'
reset=$'\033[0;39m'
red=$'\033[1;31m'

clean(){
    echo ${red}"cleaning cache ...." ${reset}
    if [ -f "./data.sql"];then
    rm -f data.sql
    fi
    if [-f "mysql-apt-config_0.8.13-1_all.deb"];then
    rm -rf mysql-apt-config_0.8.13-1_all.deb;
    fi
}

chown -R mysql: /var/lib/mysql;
service mysql start;

echo -e ${blue}"setting up database ....."${reset}
mysql -u root -e "CREATE USER 'bone'@'' IDENTIFIED BY 'Abdelait12.';"
mysql -u root -e "source /data.sql;"
mysql -u root -e "GRANT ALL PRIVILEGES ON userSet.* TO bone@; FLUSH PRIVILEGES;"
echo -e ${cyan}"done setting up database !" ${reset}
clean();