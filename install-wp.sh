#!/bin/bash

#update system
echo "***************DEBUG: Updating system..."
apt update

dpkg -l 'apache2'
if [ $? -eq 0 ]; then
        echo "*************DEBUG: Apache already installed, moving on..."
else
        echo "*************DEBUG: Installing Apache web server..."
        apt -q -y install apache2
        service apache2 start
fi

dpkg -l 'mysql-server'
if [ $? -eq 0 ]; then
        echo "*************DEBUG: Mysql already installed, moving on..."
else
        echo "*************DEBUG: Installing Mysql Database..."
        export DEBIAN_FRONTEND=noninteractive
        apt -q -y install mysql-server
        service mysql start
fi

dpkg -l 'php'
if [ $? -eq 0 ]; then
        echo "**************DEBUG: PHP already installed, moving on..."
else
        echo "**************DEBUG: Installing PHP..."
        apt -q -y install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd
fi

dpkg -l 'wget'
if [ $? -eq 0 ]; then
        echo "**************DEBUG: Wget already installed"
else
        echo "**************DEBUG: Installing wget..."
        apt -q -y install wget
fi

echo "****************DEBUG: Grabbing latest wordpress software..."
wget -c http://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz


dpkg -l 'rsync'
if [ $? -eq 0 ]; then
        echo "**************DEBUG: rsync already installed"
else
        echo "*************DEBUG: installing rsync..."
        apt -q -y install rsync
fi
rsync -av wordpress/* /var/www/html/

chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

#Create database
echo "***************DEBUG: Creating database..."
mysql -e "CREATE DATABASE wp_myblog;"
mysql -e "GRANT ALL PRIVILEGES ON wp_myblog.* TO root@localhost IDENTIFIED BY '';"
mysql -e "FLUSH PRIVILEGES;"

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
cp /root/scripts/wp-config.php /var/www/html/wp-config.php
mv /var/www/html/index.html /var/www/html/index.html.OLD

#Restarting services
service apache2 restart
service mysql restart

echo "***************DEBUG: Wordpress is ready!"
