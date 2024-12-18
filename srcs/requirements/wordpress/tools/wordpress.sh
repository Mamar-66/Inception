#!/bin/sh

sleep 8

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

if ! wp core is-installed --allow-root --path='/var/www/html'; then
    echo "Création du site.."
    wp core install --allow-root \
        --url=${DOMAIN_NAME} \
        --title=42-inception \
        --admin_user=${MYSQL_USER} \
        --admin_password=${MYSQL_ROOT_PASSWORD} \
        --admin_email=omar_felk@hotmail.fr \
        --skip-email \
        --path='/var/www/html'

    echo "Création du user.."
    wp user create --allow-root \
        ${MYSQL_USER} \
        omar_felk@hotmail.fr \
        --user_pass=${MYSQL_PASSWORD} \
        --role="editor" \
        --display_name=Rafael \
        --porcelain \
        --path='/var/www/html'
fi

echo "PHP version:"
php -v

exec "$@"
