
FROM devian:Bullseye

RUN apt-get update
RUN apt-install -y \
					nginx \
					openssl

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out		/etc/nginx/ssl/publicCertificat.crt \
	-subj 		"/C=FR/ST=Occitanie/L=Perpignant/O=42 School/OU=omfelk/CN=domaine.com" \
	-keyout		/etc/nginx/ssl/privatKey.key


RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
