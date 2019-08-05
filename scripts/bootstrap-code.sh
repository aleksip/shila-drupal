#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

source "${SCRIPTS_DIR}/functions.sh"


################################################################################
# Drupal 8
################################################################################

shila_checkout_site \
  "${D8_CODEBASES_DIR}" \
  www.shila.test \
  https://github.com/aleksip/shila-drupal-site \
  shila_theme \
  https://github.com/aleksip/shila-drupal-theme


################################################################################
# Drupal 7
################################################################################

# Drush aliases.
#sudo mkdir -p /etc/drush
#sudo cp "${D7_DIR}/drush/site-aliases/*" /etc/drush 2>/dev/null

# Install core and contrib.
#"${D7_SCRIPTS_DIR}/update-core.sh"
#"${D7_SCRIPTS_DIR}/update-contrib.sh"
