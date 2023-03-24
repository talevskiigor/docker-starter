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
source _include/image-resizer.sh
source _include/choise.sh


echo -e "\n"
read -p "Please confirm build of PHP ${PHP_VERSION} ? (Y/N):" -n 1 -r
echo # (optional) move to a new line


if [[ $REPLY =~ ^[Yy]$ ]]; then

    echo -e "\n"
    read -p "Prune ALL docker files ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker system prune -a -f
    fi


    FRESH=""
    echo -e "\n"
    read -p "Build fresh ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        FRESH=" --force-rm  --no-cache --pull "
        docker rmi $(docker images | grep dev-apache | grep ${PHP_VERSION} | tr -s ' ' | cut -d ' ' -f 3) --force
    fi


    ${COMMAND} ${CONFIGS} -f docker-compose.build.yml build ${FRESH} dev-apache
    if [[ $? -ne 0 ]]; then
        echo -e "\nError: BUILD of PHP ver: ${PHP_VERSION} failed!"
        exit 1
    fi
    docker image tag internetbrands/dev-apache:${PHP_VERSION} internetbrands/dev-apache:${PHP_VERSION}


    echo -e "\n"
    read -p "Would you like to push PHP ver: ${PHP_VERSION} images to Docker HUB ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker login
        docker image push internetbrands/dev-apache:${PHP_VERSION}
        # docker image push internetbrands/dev-apache:latest
    fi

fi


echo -e "\n"
read -p "Please confirm build of Image Resizer ? (Y/N):" -n 1 -r
echo # (optional) move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then

    FRESH=""
    echo -e "\n"
    read -p "Build fresh ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        FRESH=" --force-rm  --no-cache --pull "
        docker rmi $(docker images | grep dev-image-resizer | grep latest | tr -s ' ' | cut -d ' ' -f 3) --force
    fi


    ${COMMAND} ${CONFIGS} -f docker-compose.build.yml build ${FRESH} dev-image-resizer
    if [[ $? -ne 0 ]]; then
        echo -e "\nError: BUILD of Image Resizer failed!"
        exit 1
    fi
    docker image tag internetbrands/dev-image-resizer:latest internetbrands/dev-image-resizer:latest


    echo -e "\n"
    read -p "Would you like to push Image Resizer to Docker HUB ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker login
        docker image push internetbrands/dev-image-resizer:latest
    fi

fi

