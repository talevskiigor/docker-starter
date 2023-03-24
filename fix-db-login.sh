#!/bin/bash

docker exec -it dev-postgresql sed -i.bak 's/scram-sha-256/md5/g' /var/lib/postgresql/data/pg_hba.conf
docker kill dev-postgresql
./start.sh
