#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Symlink site files directories to data dir
# ${1} Site base path
# ${2} Site directory name
symlink_site_files_dir() {
  sudo -u www-data mkdir -p ${DRUPAL_FILES_DIR}/${2}
  cd ${1}/web/sites/${2}
  if [ ! -L files ] && [ ! -e files ]
    then
      ln -s ${DRUPAL_FILES_DIR}/${2} files
  fi
}

symlink_site_files_dir \
  ${D8_CODEBASES_DIR}/www.shila.test \
  www.shila.test

# Set up databases and load data from dump files
${SCRIPTS_DIR}/db-init.sh -y
