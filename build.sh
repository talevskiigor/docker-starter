source _include/env.sh
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
        docker rmi $(docker images | grep ${PREFIX}-dev-apache | grep ${PHP_VERSION} | tr -s ' ' | cut -d ' ' -f 3) --force
    fi


    ${COMMAND} ${CONFIGS} -f docker-compose.build.yml --project-name=${PREFIX} build ${FRESH} dev-apache
    if [[ $? -ne 0 ]]; then
        echo -e "\nError: BUILD of PHP ver: ${PHP_VERSION} failed!"
        exit 1
    fi
    docker image tag a87c81/dev-apache:${PHP_VERSION} a87c81/dev-apache:${PHP_VERSION}


    echo -e "\n"
    read -p "Would you like to push PHP ver: ${PHP_VERSION} images to Docker HUB ? (Y/N):" -n 1 -r
    echo # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker login
        docker image push a87c81/dev-apache:${PHP_VERSION}
        # docker image push a87c81/dev-apache:latest
    fi

fi

