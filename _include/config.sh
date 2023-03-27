#!/bin/bash

COMMAND="docker-compose "
CONFIGS="-f docker-compose.yml -f docker-compose.hosts.yml -f docker-compose.volumes.yml -f docker-compose.env.yml -f docker-compose.network.yml -f docker-compose-override.yml "

### comment out this to test ouher version
# export PHP_VERSION="7.4"
export PHP_VERSION="5.6"