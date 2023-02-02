#!/bin/bash
if [ ! -f .env ]; then
    cp .env.example .env
fi

if [ -f .env ]; then
    cmp --silent .env .env.example && echo -e '\nFiles Are Identical! ###' && echo -e "Please update .env with your data" && exit 0
    
    export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
else
    echo "Please setup .env file."
    exit 0
fi

source _include/config.sh

source _include/choise.sh

echo -e "\n"
read -p "Please confirm buld of PHP ${PHP_VERSION} ? (Y/N):" -n 1 -r
echo # (optional) move to a new line



if [[ $REPLY =~ ^[Yy]$ ]]; then
    
    FRESH=""
    echo -e "\n"
    read -p "Build fresh ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        FRESH=" --force-rm  --no-cache --pull "
        docker rmi $(docker images | grep local-apache | grep ${PHP_VERSION} | tr -s ' ' | cut -d ' ' -f 3) --force  >/dev/null 2>&1
    fi
    
    
    ${COMMAND} ${CONFIGS} -f docker-compose.build.yml build ${FRESH} local-apache
    
    if [[ $? -ne 0 ]]; then
        echo -e "\nError: BUILD PHP ver: ${PHP_VERSION} failed!"
        exit 1
    fi
    
    docker image tag a87c81/local-apache:${PHP_VERSION} a87c81/local-apache:${PHP_VERSION}
    
    echo -e "\n"
    read -p "Do you like to push images to Docker HUB? " -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker login
        docker image push a87c81/local-apache:${PHP_VERSION}
    fi
    
fi

