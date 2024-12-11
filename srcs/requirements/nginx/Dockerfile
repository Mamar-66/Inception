
FROM debian:Bullseye

RUN apt-get update && \
	apt-get install -y nginx openssl && \
	mkdir -p /etc/nginx/ssl /run/nginx && \
	rm -rf /var/lib/apt/lists/*

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out		/etc/nginx/ssl/publicCertificat.crt \
	-subj 		"/C=FR/ST=Occitanie/L=Perpignant/O=42 School/OU=omfelk/CN=domaine.com" \
	-keyout		/etc/nginx/ssl/privatKey.key

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
