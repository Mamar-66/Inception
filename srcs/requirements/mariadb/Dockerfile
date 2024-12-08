
FROM debian:Bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client vim && \
	rm -rf /var/lib/apt/list/*

RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

EXPOSE 3306

