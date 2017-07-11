#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Link site files directories to data dir
sudo -u www-data mkdir -p ${DRUPAL_FILES_DIR}/www.shila.dev
cd ${D8_SITES_DIR}/www.shila.dev
if [ ! -L files ]; then
  ln -fs ${DRUPAL_FILES_DIR}/www.shila.dev files
fi

# Set up databases and load data from dump files
${SCRIPTS_DIR}/db-init.sh -y
