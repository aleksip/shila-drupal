#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Aliases for global Drush
sudo mkdir -p /etc/drush
sudo cp ${D8_DIR}/drush/site-aliases/* /etc/drush
sudo cp ${D7_DIR}/drush/site-aliases/* /etc/drush 2>/dev/null

##
# Drupal 8
##

# Install core and contrib
cd ${D8_DIR}
composer install

# Install sites
cd ${D8_SITES_DIR}
(cd shila.dev && git pull) || git clone https://github.com/aleksip/shila-drupal-site shila.dev
mkdir -p ${D8_SITES_DIR}/shila.dev/themes
cd ${D8_SITES_DIR}/shila.dev/themes
(cd shila_theme && git pull) || git clone https://github.com/aleksip/shila-drupal-theme shila_theme

##
# Drupal 7
##

# Install core and contrib
${D7_SCRIPTS_DIR}/update-core.sh
${D7_SCRIPTS_DIR}/update-contrib.sh
