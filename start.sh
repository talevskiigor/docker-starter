#!/bin/bash
if [ ! -f .env ]; then
    cp .env.example .env
fi
if [ -f .env ]; then
    cmp --silent .env .env.example && echo -e '\nFiles Are Identical! ###' && echo -e "\nPlease update .env with your data" && exit 1
    
    export $(echo $(cat .env | sed 's/#.*//g'| xargs) | envsubst)
else
    echo -e "\nPlease setup .env file."
    exit 1
fi



source _include/config.sh
source _include/choise.sh

${COMMAND} ${CONFIGS} --remove-orphans >/dev/null 2>&1
${COMMAND} ${CONFIGS} pull




${COMMAND} ${CONFIGS} up   local-apache local-postgresql local-memcached local-redis
