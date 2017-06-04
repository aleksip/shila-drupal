#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Create global Drush configuration directory
sudo mkdir -p /etc/drush


################################################################################
# Drupal 8
################################################################################

# Drush aliases
sudo cp ${D8_DIR}/drush/site-aliases/* /etc/drush

# Install core and contrib
cd ${D8_DIR}
composer install

# Copy default sites.php if it does not exist
if [ ! -f ${D8_SITES_DIR}/sites.php ]; then
  cp ${D8_SCRIPTS_DIR}/sites.php ${D8_SITES_DIR}
fi

# Check out or update sites
cd ${D8_SITES_DIR}
(cd shila.dev && git pull) || git clone https://github.com/aleksip/shila-drupal-site shila.dev

# Check out or update themes
mkdir -p ${D8_SITES_DIR}/shila.dev/themes
cd ${D8_SITES_DIR}/shila.dev/themes
(cd shila_theme && git pull) || git clone https://github.com/aleksip/shila-drupal-theme shila_theme

# Check out or update configuration
mkdir -p ${D8_CONFIG_DIR}/shila
cd ${D8_CONFIG_DIR}
(cd shila && git pull) || git clone https://github.com/aleksip/shila-drupal-site-config shila


################################################################################
# Drupal 7
################################################################################

# Drush aliases
#sudo cp ${D7_DIR}/drush/site-aliases/* /etc/drush 2>/dev/null

# Install core and contrib
#${D7_SCRIPTS_DIR}/update-core.sh
#${D7_SCRIPTS_DIR}/update-contrib.sh
