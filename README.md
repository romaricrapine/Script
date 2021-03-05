# Script Shell pour deployer une application Symfony 5 sous Debian 10

***
***

## Menu

1. [Description] (#description)
1. [Pré Requis] (#pre-requis)
2. [Guide d'installation] (#installation)
3. [Copyright] (#copyright)

***

<a name="description"></a>
## Description
Ces scripts .sh vont être utiles pour deployer une application symfony 5 sur Debian 10.
Il gère automatiquement : 

- Installation des dépendances de base pour le serveur
- Installation de [Symfony 5] 
- Installation de [PHP 7.4]
- Installation de [Mysql 8]
- Installation de [NodeJS]
- Installation de [NPM]
- Installation de [Yarn]
- Installation de [Composer]
- Installation de [Git]
- Installation de [Nano]
- Désinstallation d'[Apache 2]

***

<a name="pre-requis"></a>
## Pré-Requis
Vous allez devoir posséder le fichier "nginx.config" dans la racine de votre projet.
Posséder une connexion SSH à votre serveur.
Le répertoire de base du serveur pour le quel le script est programmé est le suivant :

`root/var/www/...`

_(Il est possible de modifier le chemin en touchant un peu les lignes de code)_

***

<a name="installation"></a>
## Guide d'installation 

1. Pour commencer il vous faudra configurer un fichier "nginx.conf" à la racine de votre projet.<br><br>
    - Pour cela, rendez-vous dans le dossier "Nginx".
    - Cliquez sur le fichier nginx.conf -> Copier tout le code puis le mettre dans votre fichier nginx.conf dans la racine de votre projet.
    - Modifiez la ligne 6 "root /var/www/nom_du_projet/public;" le "nom_du_projet" par le nom de votre projet.
    - Push sur GitHub.<br><br>
    
2. Vous connectez au serveur avec une connexion SSH. <br><br>
    - Ouvrez votre invite de commande (CMDER recommandé pour Windows) puis tapez : <br>
    ```ssh root@ip_de_votre_serveur``` <br>
    - Une demande pour accepter le certificat vous seras adressé, il suffit juste de faire "Yes" ou "Y" puis entrer.
    - Ensuite il vous faut le mot de passe que vous avez inscrit en créant le serveur. (**Attention ! Le mot de passe et invisible CTRL+V ou clique droit pour copier le texte qui est dans votre presse papier**).
    - Vous voilà connecter au serveur en SSH.<br><br>
    
3. Une fois connecté au serveur il ne vous reste plus qu'à exécuter le script. <br><br>
    - Pour exécuter le script, il faut écrire : <br>
    ``nano install.sh`` <br>
    - Puis copier tout le code qu'il y a dans le fichier "install.sh" de ce repository GitHub.
    - Pour coller dans le fichier qui est en cours d'écriture dans l'invite de commande faire un clique droit puis "ok" "ok".
    - Pour sauvegarder les modifications faire : <br>
    ``CTRL+X`` suivis de ``Y`` PUIS ``ENTRER``.
    - Une fois le script prêt il faut l'exécuter, taper : <br>
    ``chmod +x install.sh`` puis ``ENTRER``.
    - Il ne vous reste plus qu'à l'exécuter avec la commande : <br>
    ``./install.sh``.<br><br>
      
4. Le script est en cours de deployment mais il reste encore quelques petite configuration à faire.<br><br>
    - Au bout d'un certain temps le script vous demanderas de choisir entre 4 choix pour un serveur MYSQL, sélectionner juste "OK".
    - Ensuite il vous faudra inscrire un mot de passe pour la connexion à MySQL (**il doit être identique à celui inscrit dans votre .env**).
    - Ici petit soucis avec CMDER car le script demande une deuxième fois le mot de passe mais il est possible que la page de CMDER bug et que vous ne voyez pas ce qu'il y a d'écrit MAIS, il est possible d'écrire donc **attention d'écrire le même mot de passe** et ensuite appuyer plusieurs fois sur ``ENTRER`` jusqu'à ce que l'affichage redevienne normal.
    - Après s'être connecter à MYSQL avec le mot de passe que vous venez d'inscrire, il va falloir crée la base de donnée via MYSQL pour cela il faudra copier la ligne de commande 
      ``CREATE DATABASE IF NOT EXISTS databasedname;`` et remplace databasedname par le nom de votre base de donnée inscrite dans le .env de symfony, puis ``EXIT;``.  
    - Le script va demander par la suite si vous souhaitez déployer l'application répondez par "Yes" ou "Y" si vous le souhaitez sinon, répondez par "No" ou "N".
    - Si vous avez validé pour continuer, le script va vous demander le lien de votre repository GitHub. (VERIFIER BIEN QUE VOUS AVEZ LE FICHIER nginx.conf).
    - Ensuite il va vous demander le nom de votre projet (le nom que vous donc indiquez dans le fichier nginx.conf ligne 6).<br><br>
    
5. Votre application est maintenant en ligne.<br><br>
    - Effectivement votre application est maintenant en ligne ! 
    - Vous pouvez y accedez depuis l'adresse IP de votre serveur OU votre nom de domaine si vous en avez configuré un.
    - Si vous rencontrez un problème, vous pouvez ouvrir une issue sur GitHUb.
    
    
***

### [***YOU CAN FORK - SHARE - UPGRADE THIS PROJECT***]