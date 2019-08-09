#!/bin/bash
test $# -lt 4 && echo "Some arguments needed: MYSQL_ROOT_PASSWORD MYSQL_HOST MYSQL_PORT WATCHLIST CONFIG" && exit 1
MYSQL_ROOT_PASSWORD=$1
MYSQL_HOST=$2
MYSQL_PORT=$3
WATCHLIST="$4"
CONFIG="$5"
MYSQLCMD="mysql -u root -p$MYSQL_ROOT_PASSWORD -D silenceDB -h $MYSQL_HOST -P $MYSQL_PORT"

while true; do

    # CONFIG
    # DISALBED / UNUSED
    #if [ ! -r "$CONFIG" ]; then
    #	exit 1
    #fi
    #. $CONFIG
    #echo "INSERT INTO config (confkey, confvalue) VALUES ('MOUNTPOINT_ALIVE_SECONDS_LIMIT', $MOUNTPOINT_ALIVE_SECONDS_LIMIT) ON DUPLICATE KEY UPDATE confkey='MOUNTPOINT_ALIVE_SECONDS_LIMIT',confvalue=$MOUNTPOINT_ALIVE_SECONDS_LIMIT;" | $MYSQLCMD
    
    cat "$WATCHLIST" | grep -v -e '^#' -e '^\s*$' | awk '{print $1}' | (
    SQLSTRG=""
    while read LINE;do
	MNTPNT="$(echo "$LINE" | awk '{print $1}')"
	test "x$MNTPNT" == "x" && continue
	SQLSTRG="${SQLSTRG}INSERT IGNORE INTO status (mntpnt, alive, status, since) VALUES ('$MNTPNT', 0, 0, 0);"
	#sleep 1
    done
    echo "$SQLSTRG" | $MYSQLCMD
    )

    echo "select mntpnt from status;"  | $MYSQLCMD --skip-column-names | (
	while read MNTPNT; do
	    cat "$WATCHLIST" | grep -v -e '^#' -e '^\s*$' | awk '{print $1}' | grep -w $MNTPNT > /dev/null || echo "DELETE FROM status WHERE mntpnt = '$MNTPNT';" | $MYSQLCMD
	done
    )
    sleep 20
done

exit $?

# END
