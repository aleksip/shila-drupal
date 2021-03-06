#!/usr/bin/env bash

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SHILA_DRUPAL_DIR="$(cd "${SCRIPTS_DIR}/.." && pwd)"
SHILA_ROOT="$(cd "${SHILA_DRUPAL_DIR}/../.." && pwd)"
CODE_DIR="${SHILA_ROOT}/code"
DATA_DIR="${SHILA_ROOT}/data"
SQL_DUMPS_DIR="${DATA_DIR}/sql-dumps"
DRUPAL_FILES_DIR="${DATA_DIR}/drupal-files"

D8_DIR="${SHILA_DRUPAL_DIR}/d8"
D8_CODEBASES_DIR="${D8_DIR}/codebases"
D8_MULTISITES_DIR="${D8_DIR}/multisites"

D7_DIR="${SHILA_DRUPAL_DIR}/d7"
D7_SCRIPTS_DIR="${D7_DIR}/scripts"
D7_SITES_DIR="${D7_DIR}/sites"

REMOTE_SHILA_ROOT=/var/www/shila-prod
