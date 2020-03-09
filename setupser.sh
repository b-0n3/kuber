#!/bin/bash

sudo su - 


mysql -u root -e "source /data.sql;"
mysql -u root -e "CREATE USER 'bone'@'' IDENTIFIED BY 'Abdelait12.';"
mysql -u root -e "GRANT ALL PRIVILEGES ON userSet.* TO bone@; FLUSH PRIVILEGES;"