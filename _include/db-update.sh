#!/bin/bash

if [ ! -f postgresql/data/dump_9_5.sql -a ! -f postgresql/data/dump_14_4.sql ]; then
    clear
    echo -e "\n"
    echo -e "\nPlease wait to update database."
    docker-compose ${CONFIGS} -f docker-compose.db95.yml pull
    mkdir -p postgresql/data
    docker network prune --force
    echo -e "\e[31mDon't stop script until DONE is printed !!!\e[0m"
    
    echo -e "\nDon't stop script until DONE is printed !!!"
    docker-compose -f docker-compose.db95.yml down --remove-orphans >/dev/null 2>&1
    echo -e "\nStart v9.5"
    docker-compose -f docker-compose.db95.yml up --detach dev-postgresql95
    echo -e "\nSleep until db is ready 60s"
    
    docker ps
    
    start=1
    stop=60
    while [ $start -lt $stop ]; do
        printf "%s" "#"
        start=$(($start + 1))
        sleep 1
    done
    
    echo -e "\nBackup v9.5"
    docker exec -t dev-postgresql95 pg_dumpall -c -U postgres >postgresql/data/dump_9_5.sql
    echo -e "\nClean UP"
    docker-compose -f docker-compose.db95.yml down --remove-orphans >/dev/null 2>&1
    
    echo -e "\nStart v14.4"
    echo docker-compose ${CONFIGS} up --detach dev-postgresql
    
    echo -e "\nSleep until db is ready 60s"
    
    
    start=1
    stop=60
    while [ $start -lt $stop ]; do
        printf "%s" "#"
        start=$(($start + 1))
        sleep 1
    done
    
    echo -e "\nBackup v14.4"
    docker exec -t dev-postgresql pg_dumpall -c -U vagrant >postgresql/data/dump_14_4.sql
    
    echo -e "\nRestore 9.5 to 14.4"
    sleep 5
    cat postgresql/data/dump_9_5.sql | docker exec -i dev-postgresql psql -U vagrant -d webmgrdb
    
    echo -e "\nClean UP"
    docker-compose ${CONFIGS} down --remove-orphans >/dev/null 2>&1
    echo -e "\nDone."
    echo -e "\n"
    
fi
