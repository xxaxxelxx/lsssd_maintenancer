#!/bin/bash
set -ex
#set -x

echo "$1" | grep -i '^exit' > /dev/null && exit 0

./maintain_db.sh $MYSQL_ROOT_PASSWORD $MYSQL_HOST $MYSQL_PORT /volumes/CommandVolume/WATCHLIST /volumes/CommandVolume/CONFIG_MASTER

exit $?
