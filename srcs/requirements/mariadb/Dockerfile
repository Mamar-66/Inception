
FROM debian:bullseye

RUN apt-get update && \
	apt-get install -y mariadb-server mariadb-client vim && \
	rm -rf /var/lib/apt/list/*

RUN mkdir -p /var/run/mysqld && \
	mkdir -p /usr/local/bin && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

EXPOSE 3306

COPY ./tools/mariadb.sh \
	/usr/local/bin/

COPY ./conf/mysqld.conf \
	/etc/mysql/mariadb.conf.d/mysqld.cnf

RUN chmod +x /usr/local/bin/mariadb.sh

ENTRYPOINT ["/usr/local/bin/mariadb.sh"]

CMD ["mysqld", "--bind-address=0.0.0.0"]
