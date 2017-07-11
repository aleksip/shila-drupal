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
cd ${D8_DIR}/drupal-8
composer install

# Check out overwritten files
git checkout -- web/sites/development.services.yml
git checkout -- web/sites/sites.php

# Check out or update sites
cd ${D8_SITES_DIR}
if [ -d www.shila.dev ]; then
  cd www.shila.dev
  git pull
else
  git clone https://github.com/aleksip/shila-drupal-site www.shila.dev
fi

# Check out or update themes
mkdir -p ${D8_SITES_DIR}/www.shila.dev/themes
cd ${D8_SITES_DIR}/www.shila.dev/themes
if [ -d shila_theme ]; then
  cd shila_theme
  git pull
else
  git clone https://github.com/aleksip/shila-drupal-theme shila_theme
  cd shila_theme
fi

# Set up Shila theme
npm install
npm run install-pattern-lab

# Check out or update configuration
cd ${D8_CONFIG_DIR}
if [ -d www.shila.dev ]; then
  cd www.shila.dev
  git pull
else
  git clone https://github.com/aleksip/shila-drupal-site-config www.shila.dev
fi


################################################################################
# Drupal 7
################################################################################

# Drush aliases
#sudo cp ${D7_DIR}/drush/site-aliases/* /etc/drush 2>/dev/null

# Install core and contrib
#${D7_SCRIPTS_DIR}/update-core.sh
#${D7_SCRIPTS_DIR}/update-contrib.sh
