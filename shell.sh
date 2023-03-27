#!/bin/bash
# docker exec -ti --user docker --workdir=/var/www/html/webmgr/editor dev-apache bash
source _include/env.sh
docker exec -ti ${PREFIX}-dev-apache bash