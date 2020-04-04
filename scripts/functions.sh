#!/usr/bin/env bash

# Check out or update repositories.
#
# ${1} Base path
# ${2} Repository directory name
# ${3} Repository URL
# ${4} Branch (optional)
shila_setup_repo ()
{
  echo "Setting up repository ${2}..."
  cd "${1}" || exit 1
  if [ -d "${2}" ]
    then
      cd "${2}" || exit 1
      echo "Pulling possible updates..."
      git pull
    else
      if [ -z "${4}" ]
        then
          echo "Cloning default branch from ${3}..."
          git clone "${3}" "${2}"
        else
          echo "Cloning branch ${4} from ${3}..."
          git clone -b "${4}" "${3}" "${2}"
      fi
      cd "${2}" || exit 1
  fi
}

# Check out or update sites and themes.
#
# ${1} Site base path
# ${2} Site directory name
# ${3} Site repository URL
# ${4} Theme directory name
# ${5} Theme repository URL
shila_checkout_site ()
{
  # Clone or update site from repo.
  shila_setup_repo "${1}" "${2}" "${3}"
  # Run Composer install if the site contains a composer.json file.
  if [ -f composer.json ]
    then
      echo "Running Composer install in site directory..."
      composer install
      # Check out possibly overwritten files.
      git checkout -- web/sites/development.services.yml
      git checkout -- web/sites/sites.php
  fi
  if [ -n "${4}" ]
    then
      # Clone or update theme from repo.
      echo "Setting up theme ${4}..."
      mkdir -p "${1}/${2}/themes"
      shila_setup_repo "${1}/${2}/themes" "${4}" "${5}"
      # Run npm install if the theme contains a package.json file.
      if [ -f package.json ] && [ ! -d node_modules ]
        then
          echo "Running npm install in theme directory..."
          npm install
      fi
  fi
}

# Symlink site files directory to a directory under DRUPAL_FILES_DIR.
#
# ${1} Site base path
# ${2} Site directory name
symlink_site_files_dir ()
{
  sudo -u www-data mkdir -p "${DRUPAL_FILES_DIR}/${2}"
  cd "${1}/web/sites/${2}" || exit 1
  if [ ! -e files ]
    then
      ln -s "${DRUPAL_FILES_DIR}/${2}" files
  fi
}
