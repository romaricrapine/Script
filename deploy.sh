#!/bin/bash

clear

echo "Suppression fichier Html"
cd /var/www && rm -rf html

#----------------------------------------#

echo "Clone du rep git"
echo "Entrer le lien du repository GitHub"
read git
git clone $git
cd *

#----------------------------------------#

echo "Installation des dépendances"
composer install -y
yarn install -y

#----------------------------------------#

echo "Installation de Symfony"
symfony console d:d:c
symfony console make:migr
symfony console d:m:m

#----------------------------------------#

echo "Configuration de Nginx"
rm -rf /etc/nginx/sites-available/default
mv nginx.conf /etc/nginx/sites-available/default.conf
ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enable/
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