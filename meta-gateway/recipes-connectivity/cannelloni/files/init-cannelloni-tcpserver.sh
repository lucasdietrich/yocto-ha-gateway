#!/bin/sh

### BEGIN INIT INFO
# Provides:          cannelloni-tcpserver
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 5
# Default-Stop:      0 1 6
# Short-Description: Cannelloni TCP server
# Description:       Starts and stops the Cannelloni server using start-stop-daemon
### END INIT INFO

DESC="Cannelloni TCP server"
DAEMON="/usr/bin/cannelloni"
INTERFACE="can0"
PORT="20000"
DAEMON_ARGS="-I ${INTERFACE} -l ${PORT} -C s"
PIDFILE="/var/run/cannelloni.pid"

set -e

do_start() {
    echo "Starting $DESC"
    start-stop-daemon --start --background \
        --make-pidfile --pidfile "$PIDFILE" \
        --exec "$DAEMON" -- $DAEMON_ARGS
}

do_stop() {
    echo "Stopping $DESC"
    start-stop-daemon --stop --pidfile "$PIDFILE" --retry 5
    rm -f "$PIDFILE"
}

case "$1" in
  start)
    do_start
    ;;
  stop)
    do_stop
    ;;
  restart|force-reload)
    do_stop
    sleep 1
    do_start
    ;;
  status)
    if [ -f "$PIDFILE" ]; then
        PID=$(cat "$PIDFILE")
        if kill -0 "$PID" 2>/dev/null; then
            echo "$DESC is running (PID: $PID)"
            exit 0
        else
            echo "$DESC is not running, but PID file exists"
            exit 1
        fi
    else
        echo "$DESC is not running"
        exit 3
    fi
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|force-reload|status}" >&2
    exit 1
    ;;
esac

exit 0
