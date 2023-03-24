#!/bin/bash

if [ ! -d image-resizer/application/vendor ]; then
    echo -e "\nInitializing Image Resizer"

    git submodule init
    git submodule update --depth 1
    cp image-resizer/.env.example image-resizer/.env

    docker run \
        --rm \
        --user `id -u`:`id -g` \
        --volume `pwd`/image-resizer:/var/www/sites/image-resizer \
        --workdir /var/www/sites/image-resizer \
        internetbrands/image-resizer:latest \
        composer install --ignore-platform-reqs

    echo -e "Done: Initializing Image Resizer\n"
fi