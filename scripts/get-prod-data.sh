#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

mkdir -p "${DATA_DIR}"

echo "Running remote db-dump..."
ssh user@example.com '${REMOTE_SHILA_ROOT}/code/shila-drupal/scripts/db-dump.sh'

echo "Running rsync..."
rsync -avz -e ssh "user@example.com:${REMOTE_SHILA_ROOT}/data/" "${DATA_DIR}"
