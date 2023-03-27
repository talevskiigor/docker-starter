#!/bin/bash

source _include/config.sh
source _include/choise.sh

${COMMAND} down
${COMMAND} ${CONFIGS} --remove-orphans >/dev/null 2>&1
${COMMAND} ${CONFIGS} pull


${COMMAND} ${CONFIGS} --project-name=${PREFIX} up   dev-apache
