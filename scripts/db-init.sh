#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=./scripts.conf
source "${MY_DIR}/scripts.conf"

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

  # Install Drupal.
  # Comment the following lines once you have a database dump.
  cp "${SCRIPTS_DIR}/db.env" "${D8_CODEBASES_DIR}/www.shila.test/.env"
  cd "${D8_CODEBASES_DIR}/www.shila.test" || exit 1
  sudo -u www-data drush si standard --account-pass='shila' --site-name='Shila Drupal' -y
  drush en admin_toolbar,coffee,components,shila_theme -y
  drush cset system.theme default shila_theme -y
  drush en features,features_ui -y
  sudo -u www-data drush en shila_core,shila_image_styles,shila_media -y

  # Uncomment the following line once you have a database dump.
  #mysql -u shila -pshila shila_dev_d8 < "${SQL_DUMPS_DIR}/shila_dev_d8.sql"
else
  echo "Cancelling..."
  exit 1
fi

exit 0
