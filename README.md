#dockerproxy

**requirments**

- a vm with docker installed

- i.e. a preinstalled docker vm from digital ocean marketplace

**installation**

- run the following to initialize the docker host and config

        apt update && apt install sudo && sudo apt upgrade -y && \
        sudo apt install make git -y && make configure

- clone this repo to your docker vm

        git clone git@github.com:bustinstuff/dockerproxy.git

- update the NGINX_HOST=localhost line from docker-compose.yml to reflect your host / settings

- run config

        cd dockerproxy && make config && make start

**commands**

    make config
    make clean
    make start
    make stop

**config**

- creates shared volumnes for nginx / letsencrypt
- copies nginx / letsencrypt configs

**clean**

- removes old docker containers

**start**

- starts docker compose

**stop**

- stops docker compose
- runs clean
