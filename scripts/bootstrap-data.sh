#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

source "${SCRIPTS_DIR}/functions.sh"

# Symlink files directory.
symlink_site_files_dir "${D8_CODEBASES_DIR}/www.shila.test" www.shila.test

# Set up databases and load data from dump files.
"${SCRIPTS_DIR}/db-init.sh" -y
