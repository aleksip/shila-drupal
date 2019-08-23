#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

# Get command line options.
while getopts y OPT
  do
    case "${OPT}" in
      y)
      yes_to_all="TRUE"
      ;;
      [?])
      echo "Usage: $( basename "${BASH_SOURCE[0]}" ) [-y]"
      exit 1
      ;;
    esac
done

# Ask for confirmation if necessary.
if [[ ! "${yes_to_all}" ]]
  then
    echo
    echo "This script will initialize databases from backups. Are you sure you want to continue? (y/n) "
    read -r -n 1 answer
    echo
fi

if [[ "${answer}" == "y" || "${yes_to_all}" ]]
  then
    # Create databases if necessary and grant privileges.
    mysql -u root -pshila < "${SCRIPTS_DIR}/db-create.sql"
    if [ ! -f "${SQL_DUMPS_DIR}/shila_dev_d8.sql" ]
      then
        # Install Drupal.
        echo "Installing Drupal..."
        cd "${D8_CODEBASES_DIR}/www.shila.test" || exit 1
        sudo -u www-data drush si --account-pass="shila" --site-name="Shila Drupal" -y standard
        drush en admin_toolbar,coffee,components -y
        drush theme:enable shila_theme -y && drush cset system.theme default shila_theme -y
        drush en features,features_ui -y
        sudo -u www-data drush en shila_core,shila_image_styles,shila_media -y
        if [ ! -e web/sites/www.shila.test/settings.local.php ]
          then
            ln -s ../../../settings.local.php web/sites/www.shila.test/settings.local.php
        fi
      else
        # Restore from SQL backup.
        echo "Restoring database from SQL backup..."
        mysql -u shila -pshila -e "DROP DATABASE IF EXISTS shila_dev_d8;"
        mysql -u shila -pshila -e "CREATE DATABASE IF NOT EXISTS shila_dev_d8;"
        mysql -u shila -pshila shila_dev_d8 < "${SQL_DUMPS_DIR}/shila_dev_d8.sql"
    fi
  else
    echo "Cancelling..."
    exit 1
fi

exit 0
