#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Link site files directories to data dir
# ${1} Site directory name
link_site_files_dir() {
  sudo -u www-data mkdir -p ${DRUPAL_FILES_DIR}/${1}
  cd ${D8_SITES_DIR}/${1}
  if [ ! -L files ]
    then
      ln -fs ${DRUPAL_FILES_DIR}/${1} files
  fi
}

link_site_files_dir www.shila.test

# Set up databases and load data from dump files
${SCRIPTS_DIR}/db-init.sh -y
