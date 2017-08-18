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

# Check out or update sites, themes and configuration
# ${1} Site directory name
# ${2} Site repo URL
# ${3} Theme directory name
# ${4} Theme repo URL
# ${5} Config repo URL
checkout_site_theme_config() {
  # Site
  echo "Setting up site ${1}..."
  cd ${D8_SITES_DIR}
  if [ -d ${1} ]
    then
      cd ${1}
      git pull
    else
      git clone ${2} ${1}
  fi
  # Theme
  echo "Setting up theme ${3}..."
  mkdir -p ${D8_SITES_DIR}/${1}/themes
  cd ${D8_SITES_DIR}/${1}/themes
  if [ -d ${3} ]
    then
      cd ${3}
      git pull
    else
      git clone ${4} ${3}
      cd ${3}
  fi
  if [ -f package.json ] && [ ! -d node_modules ]
    then
      echo "Running npm install in theme directory..."
      npm install
  fi
  # Configuration
  echo "Setting up configuration for ${1}..."
  cd ${D8_CONFIG_DIR}
  if [ -d ${1} ]
    then
      cd ${1}
      git pull
    else
      git clone ${5} ${1}
  fi
}

checkout_site_theme_config \
  www.shila.dev \
  https://github.com/aleksip/shila-drupal-site \
  shila_theme \
  https://github.com/aleksip/shila-drupal-theme \
  https://github.com/aleksip/shila-drupal-site-config


################################################################################
# Drupal 7
################################################################################

# Drush aliases
#sudo cp ${D7_DIR}/drush/site-aliases/* /etc/drush 2>/dev/null

# Install core and contrib
#${D7_SCRIPTS_DIR}/update-core.sh
#${D7_SCRIPTS_DIR}/update-contrib.sh
