#!/bin/sh

### BEGIN INIT INFO
# Provides:          home-assistant
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 5
# Default-Stop:      0 1 6
# Short-Description: Home Assistant via Podman Compose
# Description:       Starts and stops Home Assistant using Podman Compose
### END INIT INFO

STACK_DIR="/opt/hass"
DESC="Home Assistant"
CMD="/usr/bin/podman-compose -f ${STACK_DIR}/podman-compose.yaml"
PIDFILE="/var/run/hass.pid"

set -e

do_start() {
    echo "Starting $DESC"

    # ensure the bind mount directories exist
    mkdir -p /var/lib/homeassistant

    # ensure correct ownership: Home Assistant runs as UID 1000
    chown 1000:1000 /var/lib/homeassistant 

    cd "$STACK_DIR" || exit 1
    $CMD down || true # stop any existing stack
    $CMD up -d > /run/podman-hass.log 2>&1
}

do_stop() {
    echo "Stopping $DESC"
    cd "$STACK_DIR" || exit 1
    $CMD down
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
    cd "$STACK_DIR" && $CMD ps
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|force-reload|status}" >&2
    exit 1
    ;;
esac

exit 0
