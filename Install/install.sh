#!/bin/bash

clear

echo "Update"
apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

echo "Base"
apt-get install nodejs npm curl git nano make wget sudo apt-transport-https lsb-release ca-certificates locate systemd nginx fail2ban -y
apt-get purge ntp rsyslog exim* postfix* sendmail* updatedb ldconfig -y

service nginx start

echo "Install Symfony"
wget https://get.symfony.com/cli/installer -O - | bash
mv /root/.symfony/bin/symfony /usr/local/bin/symfony

echo "Install Composer"
apt install composer -y

echo "Install PHP"
apt-get install lsb-release apt-transport-https ca-certificates -y
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt-get update
apt-get install php7.4 -y

echo "PHP Packages"
apt-get install php7.4-{fpm,bcmath,bz2,intl,gd,mbstring,mysql,zip,redis,imagick,intl,yaml,xml,pdo} -y

echo "Install Redis"
apt-get install redis-server -y
service redis-server start

echo "Install Mysql 8"
cd /tmp
wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb
dpkg -i mysql-apt-config*
rm -rf mysql-apt-config_0.8.13-1_all.deb
apt update && apt install mysql-server -y

echo "Install Yarn"
npm install -g yarn -y

echo "Remove Apache"
service apache2 stop
apt-get purge apache2 apache2-utils -y

service --status-all

history -c