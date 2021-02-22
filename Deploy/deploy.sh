#!/bin/bash

clear

echo "Suppression fichier Html"
cd /var/www && rm -rf html

#----------------------------------------#

echo "Clone du rep git"
echo -n "Lien du repository GitHub : "
read git
echo -n "Nom du projet : "
read project
echo "Clonage du repository dans /var/www/$project"
git clone "$git" "/var/www/$project"
cd "/var/www/$project"
echo "Clonage terminer !"

#----------------------------------------#

echo "Installation des dépendances"
echo "Installation de Composer"
composer install
echo "Installation de Yarn"
yarn install
echo "Build de Yarn"
yarn build

#----------------------------------------#

echo "Installation de Symfony"
symfony console d:d:c
symfony console m:migr
symfony console d:m:m

#----------------------------------------#

echo "Configuration de Nginx"
rm -rf /etc/nginx/sites-available/default
mv /var/www/"$project"/nginx.conf /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enable/
echo "On vérifie si la config est OK"
nginx -t

if [ $? -eq 0 ]; then
  echo "OK"
  else
  echo "FAIL"
fi

systemctl reload nginx

#----------------------------------------#

clear

service --status-all

history -c

