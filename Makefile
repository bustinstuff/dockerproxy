# dockerproxy makefile

SHELL := /bin/bash

.PHONY:
	configure clean start stop

configure:
	sudo mkdir -p /volumes/{nginx/{cache,html},letsencrypt}
	sudo touch /volumes/nginx/error.log
	sudo touch /volumes/nginx/html/default.html
	sudo cp configs/nginx.conf /volumes/nginx/nginx.conf
	sudo cp configs/letsencrypt.conf /volumes/letsencrypt/letsencrypt.conf
 	sudo systemctl enable docker

clean:
	sudo docker container prune -y

start:
	docker-compose up -d

stop:
	docker-compose down
	make clean
