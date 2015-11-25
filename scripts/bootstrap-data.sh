#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Set up databases and load data from dump files
${SCRIPTS_DIR}/db-init.sh -y

# Link site files directories to data dir
mkdir -p ${DRUPAL_FILES_DIR}/shila.dev
ln -fs ${DRUPAL_FILES_DIR}/shila.dev ${D8_SITES_DIR}/shila.dev/files
