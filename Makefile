# dockerproxy makefile

SHELL := /bin/bash
NGINX_HOST = 'localhost'

.PHONY:
	configure wipe start stop

configure:
	sudo mkdir -p /volumes/{acme,nginx/{cache,html/certbot}}

	sudo touch /volumes/nginx/html/index.html

	sudo cp nginx.conf /volumes/nginx/nginx.conf.template

	sudo NGINX_HOST=$(NGINX_HOST) \
	envsubst '$$NGINX_HOST' < /volumes/nginx/nginx.conf.template > /volumes/nginx/nginx.conf

	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=US/ST=CA/L=San Francisco/O=Docker Proxy/CN=localhost" \
	-keyout /volumes/acme/default.key \
	-out /volumes/acme/default.crt

	sudo openssl dhparam -out /volumes/acme/dhparam.pem 2048

wipe:
	sudo docker-compose down
	sudo docker container prune --force
	sudo docker network prune --force
	sudo rm -rf /volumes

start:
	sudo docker-compose up -d

stop:
	sudo docker-compose down
