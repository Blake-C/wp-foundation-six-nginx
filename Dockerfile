FROM nginx:1.18.0-alpine

COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# Install openssl
RUN apk add --update openssl && \
	rm -rf /var/cache/apk/*
RUN rm -rf /var/www/html
RUN mkdir /root/certs
WORKDIR /root/certs
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 9999 -nodes \
	-out localhost.crt -keyout localhost.key \
	-subj "/C=US/ST=TX/L=San Antonio/O=DigitalBlake/OU=Development/CN=localhost"
# RUN openssl dhparam 4096 -out /root/certs/dhparam.pem
RUN	chmod 400 /root/certs/localhost.key

WORKDIR /var/www/public_html
