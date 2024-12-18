#!/bin/sh


# Initialisation de la base de données
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
fi

# Démarrage explicite de MariaDB
mysqld --user=mysql --datadir=/var/lib/mysql &
pid=$! 
sleep 3

# Vérification de l'existence de la base de données
if ! mysql -uroot -e "USE $MYSQL_DATABASE;" 2>/dev/null; then
    echo "Database not found. Creating database and initializing users."

    # Exécution de mysql_secure_installation automatiquement
    mysql_secure_installation << _EOF_
Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
n
Y
Y
_EOF_

    # Création de la base de données et des utilisateurs
    mysql -uroot -e "
    GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
    FLUSH PRIVILEGES;"
else
    echo "DATABASE already exists. Skipping creation."
fi

kill $pid
sleep 3

exec mysqld --user=mysql --datadir=/var/lib/mysql