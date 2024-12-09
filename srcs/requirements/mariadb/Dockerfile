
FROM debian:Bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client vim && \
	rm -rf /var/lib/apt/list/*

RUN mkdir -p /var/run/mysqld && \
	mkdir -p /usr/local/bin && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh \
	./conf/wordpress.sql \
	/usr/local/bin/

RUN chmod +x /usr/local/bin/mariadb.sh && \
	chmod +x /usr/local/bin/wordpress.sql