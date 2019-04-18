# dockerproxy makefile

SHELL := /bin/bash
NGINX_HOST = 'localhost'

.PHONY:
	config nginx-config generate-default-ssl wipe start stop

config:
	sudo mkdir -p volumes/{acme,nginx/{cache,html/certbot}}

	make config-nginx

	make generate-default-ssl

config-nginx:
	sudo touch volumes/nginx/html/index.html
	sudo cp nginx.conf volumes/nginx/nginx.conf.template
	sudo NGINX_HOST=$(NGINX_HOST) \
	envsubst '$$NGINX_HOST' < volumes/nginx/nginx.conf.template > volumes/nginx/nginx.conf

generate-default-ssl:
	sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj "/C=US/ST=CA/L=San Francisco/O=Docker Proxy/CN=$(NGINX_HOST)" \
	-keyout volumes/acme/default.key \
	-out volumes/acme/default.crt

	sudo openssl dhparam -out volumes/acme/dhparam.pem 2048

wipe:
	sudo docker-compose down >/dev/null 2>&1 || true
	sudo docker container prune --force
	sudo docker network prune --force
	sudo rm -rf volumes

start:
	sudo docker-compose up -d

stop:
	sudo docker-compose down
