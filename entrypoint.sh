#!/bin/bash
set -ex
#set -x

echo "$1" | grep -i '^exit' > /dev/null && exit 0

./maintain_db.sh /volumes/CommandVolume/WATCHLIST /volumes/CommandVolume/CONFIG $MYSQL_ROOT_PASSWORD $MYSQL_HOST $MYSQL_PORT

exit $?
