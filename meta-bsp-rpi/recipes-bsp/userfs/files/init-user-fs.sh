#!/bin/sh

# set -e

# Source function library.
. /etc/init.d/functions

start() {
   # create userfs partition (btrfs)
   /usr/bin/userfs -v > /run/userfs.log 2>&1
}

stop() {
   :
}

case "$1" in
    start)
       start
       ;;
    stop)
       stop
       ;;
    status)
       ;;
    *)
       echo "Usage: $0 {start|stop}"
esac

exit 0