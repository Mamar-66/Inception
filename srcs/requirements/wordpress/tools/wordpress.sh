#!/bin/sh

if [ -f ./wp-config.php ] && grep -q "username_here" wp-config.php; then
    echo "wordpress ok"
else
    if [ -f ./wp-config.php ]; then
        rm -rf wp-admin wp-content wp-includes
    fi

    # Télécharger WordPress et le fichier de configuration
    wget http://wordpress.org/latest.tar.gz && \
    tar xfz latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf latest.tar.gz wordpress

    # Remplacer les variables par celles du fichier .env
    sed -i \
        -e "s/username_here/$MYSQL_USER/g" \
        -e "s/password_here/$MYSQL_PASSWORD/g" \
        -e "s/localhost/$MYSQL_HOSTNAME/g" \
        -e "s/database_name_here/$MYSQL_DATABASE/g" \
        wp-config-sample.php

    cp wp-config-sample.php wp-config.php
fi

# Afficher la version de PHP pour vérifier si PHP fonctionne correctement
echo "PHP version:"
php -v

exec "$@"
