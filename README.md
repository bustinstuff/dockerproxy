# dockerproxy

- Creates an nginx docker service that redirects port 80 requests to your app on port 443

- Uses acme docker / letsencrypt to create / register ssl

- Installs a cron job that updates the letsencrypt certs

**requirments**

- a vm with docker installed

- i.e. a preinstalled docker vm from digital ocean marketplace

**installation**

- run the following to initialize the docker host

        apt update && apt install sudo && sudo apt upgrade -y && \
        sudo apt install make git -y

- clone this repo to your docker vm

        git clone git@github.com:bustinstuff/dockerproxy.git

- switch to working directory in project

        cd dockerproxy

- update docker-compose.yml

        NGINX_HOST=localhost to reflect your host / settings

- run the following to configure

        make config && make start

**commands**

    make config                 # initial configuration
    make nginx-config           # run to update any changes made to nginx.conf
    make generate-default-ssl   # regenerate the default ssl
    make wipe                   # wipe all config / docker containers / ssl certs
    make start                  # start docker comnpose as a deamon
    make stop                   # stop docker compose
