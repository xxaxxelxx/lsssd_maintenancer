#!/bin/bash
set -ex
#set -x

test "x$1" == "xbash" && exit 0

echo "$MYSQL_HOST is host"

exit $?
