FROM debian:bullseye

# Mise à jour des paquets et installation des outils nécessaires
RUN apt-get update && apt-get -y install \
    wget curl \
	# telecharge depuis web, HTTP API
    bash php \
    php-cgi \
	# CGI pour PHP
    php-mysql \
	# cenection MySQL/MariaDB
    php-fpm \
	# Gestionnaire FastCGI
    php-pdo \
	# Interface abstraction pour les bases de données
    php-gd php-cli \
	# Manipulation dimages et exécution de PHP en CLI
    php-mbstring \
	# PHP Multi-Byte String (langues non-ASCII)
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp #present dans le PATH du systeme

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/

RUN mkdir -p /run/php #pour les fichier temp de php-fpm

COPY ./tools/wordpress.sh /usr/local/bin

RUN	chmod +x /usr/local/bin/wordpress.sh

ENTRYPOINT	["/usr/local/bin/wordpress.sh"]

WORKDIR	/var/www/html/

EXPOSE 9000

CMD ["php-fpm7.4", "-F"]