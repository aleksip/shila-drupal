#!/usr/bin/env bash

REMOTE_DATA_DIR=/var/www/shila-prod/data/
MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

mkdir -p ${DATA_DIR}

echo "running remote db-dump"
ssh user@example.com '/var/www/shila-prod/code/shila-drupal/scripts/db-dump.sh'

echo "running rsync"
rsync -avz -e ssh user@example.com:${REMOTE_DATA_DIR} ${DATA_DIR}
