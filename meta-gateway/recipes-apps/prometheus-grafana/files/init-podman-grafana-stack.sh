#!/bin/sh

### BEGIN INIT INFO
# Provides:          prometheus-grafana
# Required-Start:    $network
# Required-Stop:     $network
# Default-Start:     2 3 5
# Default-Stop:      0 1 6
# Short-Description: Prometheus + Grafana via Podman Compose
# Description:       Starts and stops Prometheus and Grafana stack using Podman Compose
### END INIT INFO

STACK_DIR="/opt/prometheus-grafana"
DESC="Prometheus + Grafana stack"
CMD="/usr/bin/podman-compose -f ${STACK_DIR}/podman-compose.yaml"
PIDFILE="/var/run/prometheus-grafana.pid"

set -e

do_start() {
    echo "Starting $DESC"
    cd "$STACK_DIR" || exit 1
    $CMD up -d
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
