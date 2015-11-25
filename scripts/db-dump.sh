#!/usr/bin/env bash

MY_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source ${MY_DIR}/scripts.conf

echo "mysqldump shila_d8"
mysqldump --single-transaction -ushila -pshila shila_d8 > ${SQL_DUMPS_DIR}/shila_d8.sql
