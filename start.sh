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


UPSTREAM=${1:-'@{u}'}
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse "$UPSTREAM")
BASE=$(git merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
    echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
    echo "Need to pull"
    exit 0;
elif [ $REMOTE = $BASE ]; then
    echo "Need to push"
    exit 0;
else
    echo "Diverged"
    exit 0;
fi

source _include/image-resizer.sh


source _include/config.sh
source _include/choise.sh

${COMMAND} down
${COMMAND} ${CONFIGS} --remove-orphans >/dev/null 2>&1
${COMMAND} ${CONFIGS} pull

# source _include/db-update.sh




${COMMAND} ${CONFIGS} up   dev-apache dev-postgresql dev-memcached dev-redis dev-image-resizer
