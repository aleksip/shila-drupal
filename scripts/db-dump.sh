#!/usr/bin/env bash

# shellcheck source=scripts-conf.sh
source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scripts-conf.sh"

echo "mysqldump shila_prod_d8"
mysqldump --single-transaction -ushila -pshila shila_prod_d8 > "${SQL_DUMPS_DIR}/shila_prod_d8.sql"
