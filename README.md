Création des fichiers terraform pour provisionner une VM avec une ip publique 

Création de l'inventaire Ansible à destination de la machine locale : TP_Partiel/Ansible/inventories => inventory.ini

Exécutez le playbook Ansible : sudo ansible-playbook -i inventories/inventory.ini env_vars/Fastapi.yml    

Installation des dépendances : Python, virtualenv, Apache et les modules nécessaires

Création d'un utilisateur dédié : Un utilisateur nommé `fastapi_ryan` doit etre créé  sur la machine pour exécuter l'application.

Configuration de l'application : L'application est copiée dans le répertoire utilisateur sur la machine locale et les dépendances sont installées dans un environnement virtuel.

Création du service systemd pour que l'api se lance même au démarrage de la machine

Configuration Apache : Apache est configuré comme reverse proxy pour Uvicorn, servant l'application FastAPI sur la machine distante.

Après l'installation, accès de l'appli sur IP locale de la machine 127.0.0.1:80 et pour les docs : 127.0.0.1:80/docs

