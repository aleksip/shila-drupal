#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR=$(cd ${MY_DIR}/..; pwd)

# Download new Drupal core into a temporary directory
drush make ${MY_DIR}/core.make ${PARENT_DIR}/drupal-7.update

# Remove the default sites directory and link to ours
rm -rf ${PARENT_DIR}/drupal-7.update/sites
ln -s ${PARENT_DIR}/sites ${PARENT_DIR}/drupal-7.update/sites

# Remove possible old core
rm -rf ${PARENT_DIR}/drupal-7

# Move new core into place
mv ${PARENT_DIR}/drupal-7.update ${PARENT_DIR}/drupal-7
