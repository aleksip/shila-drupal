#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Create global Drush configuration directory
sudo mkdir -p /etc/drush/sites


################################################################################
# Drupal 8
################################################################################

# Check out or update sites and themes
# ${1} Site base path
# ${2} Site directory name
# ${3} Site repo URL
# ${4} Theme directory name
# ${5} Theme repo URL
checkout_site() {
  # Clone or update site from repo
  echo "Setting up site ${2}..."
  cd ${1}
  if [ -d ${2} ]
    then
      echo "Pulling possible updates from ${3}..."
      cd ${2}
      git pull
    else
      echo "Cloning site from ${3}..."
      git clone ${3} ${2}
      cd ${2}
  fi
  # Run Composer install
  echo "Running Composer install..."
  composer install
  # Check out possibly overwritten files
  git checkout -- web/sites/development.services.yml
  git checkout -- web/sites/sites.php
  if [ ! -z "${4}" ]
    then
      # Clone or update theme from repo
      echo "Setting up theme ${4}..."
      mkdir -p ${1}/${2}/themes
      cd ${1}/${2}/themes
      if [ -d ${4} ]
        then
          echo "Pulling possible updates from ${5}..."
          cd ${4}
          git pull
        else
          echo "Cloning theme from ${5}..."
          git clone ${5} ${4}
          cd ${4}
      fi
      # Run npm install if the theme contains a package.json file
      if [ -f package.json ] && [ ! -d node_modules ]
        then
          echo "Running npm install in theme directory..."
          npm install
      fi
  fi
}

checkout_site \
  ${D8_CODEBASES_DIR} \
  www.shila.test \
  https://github.com/aleksip/shila-drupal-site \
  shila_theme \
  https://github.com/aleksip/shila-drupal-theme


################################################################################
# Drupal 7
################################################################################

# Drush aliases
#sudo cp ${D7_DIR}/drush/site-aliases/* /etc/drush 2>/dev/null

# Install core and contrib
#${D7_SCRIPTS_DIR}/update-core.sh
#${D7_SCRIPTS_DIR}/update-contrib.sh
