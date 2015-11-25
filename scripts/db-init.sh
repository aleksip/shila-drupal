#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

# Get command line options
while getopts y OPT
do
  case "${OPT}" in
    y)
	  yes_to_all="TRUE"
	  ;;
	\?)
	  echo "Usage: $(basename $BASH_SOURCE) [-y]"
	  exit 1
	  ;;
  esac
done
# Ask for confirmation if necessary
if [[ ! "${yes_to_all}" ]]
then
  echo
  echo "This script will initialize the databases from backups. Are you sure you want to continue? (y/n) "
  read -n 1 answer
  echo
fi
if [[ "${answer}" == "y" || "${yes_to_all}" ]]
then
  mysql -u root < ${SCRIPTS_DIR}/db-create.sql
  # Uncomment following line once you have a database dump
  #mysql -u shila -pshila shila_d8 < ${SQL_DUMPS_DIR}/shila_d8.sql
else
  echo "Cancelling..."
  exit 1
fi

exit 0
