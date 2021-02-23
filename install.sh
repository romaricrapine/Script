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
apt-get install lsb-release
apt-transport-https ca-certificates -y
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

echo "Do you want to run the deployment script?"
echo "Y/N or Yes/No"
read response

if [ $response == Y ] || [ $response == y ] || [ $response == yes ]; then

#!/bin/bash

clear

echo "Delete Html file"
cd /var/www && rm -rf html

#----------------------------------------#

echo "GitHub repository clone"
echo -n "Enter the GitHub repository link: "
read git
echo -n "Name of the project :"
read project
git clone "$git" "/var/www/$project"
cd "/var/www/$project"
echo "Cloning complete !"

#----------------------------------------#

echo "Installing dependencies"
echo "Installing Composer"
composer install
echo "Installing Yarn"
yarn install
echo "Build Yarn"
yarn build

#----------------------------------------#

echo "Installing Symfony"
symfony console d:d:c
symfony console make:migration
symfony console d:m:m

#----------------------------------------#

echo "Configuring Nginx"
rm -rf /etc/nginx/sites-available/default
mv /var/www/"$project"/nginx.conf /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enable/
nginx -t

if [ $? -eq 0 ]; then
  echo "OK"
  else
  echo "FAIL"
fi

sleep 5

systemctl reload nginx

#----------------------------------------#

clear

service --status-all

history -c

echo "Your application is now deployed, you can go to your site!"

echo "                                                                            ## ";
echo "                                                                           #### ";
echo "   #####   ##  ##    ####     ####     ####     #####    #####             #### ";
echo "  ##       ##  ##   ##  ##   ##  ##   ##  ##   ##       ##                  ## ";
echo "   #####   ##  ##   ##       ##       ######    #####    #####              ## ";
echo "       ##  ##  ##   ##  ##   ##  ##   ##            ##       ## ";
echo "  ######    ######   ####     ####     #####   ######   ######              ## ";

else

echo "Deployment cancel, to complete the deployment run the script again and select Yes or Y."

echo "                                ###            ###                                   ## ";
echo "                                 ##             ##                                  #### ";
echo "   ### ##   ####     ####        ##             ##      ##  ##    ####              #### ";
echo "  ##  ##   ##  ##   ##  ##    #####             #####   ##  ##   ##  ##              ## ";
echo "  ##  ##   ##  ##   ##  ##   ##  ##             ##  ##  ##  ##   ######              ## ";
echo "   #####   ##  ##   ##  ##   ##  ##             ##  ##   #####   ## ";
echo "      ##    ####     ####     ######           ######       ##    #####              ## ";
echo "  #####                                                 ##### ";

fi


