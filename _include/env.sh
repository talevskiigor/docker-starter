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

