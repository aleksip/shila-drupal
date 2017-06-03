#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

mkdir -p ${DATA_DIR}

echo "running remote db-dump"
ssh user@example.com '${REMOTE_SHILA_ROOT}/code/shila-drupal/scripts/db-dump.sh'

echo "running rsync"
rsync -avz -e ssh user@example.com:${REMOTE_SHILA_ROOT}/data/ ${DATA_DIR}
