#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR=$(cd ${MY_DIR}/..; pwd)

# Remove possible old contrib modules, themes and libraries
rm -rf ${PARENT_DIR}/sites/all/modules/contrib
rm -rf ${PARENT_DIR}/sites/all/themes/contrib
rm -rf ${PARENT_DIR}/sites/all/libraries

# Run drush make
cd ${PARENT_DIR}
drush make --no-core ${MY_DIR}/contrib.make .
