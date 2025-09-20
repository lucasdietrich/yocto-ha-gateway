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

    # ensure the bind mount directories exist
    mkdir -p /var/lib/grafana /var/lib/prometheus

    # ensure correct ownership
    # - Grafana runs as UID 472
    # - Prometheus runs as nobody (UID 65534)
    chown 472:472 /var/lib/grafana
    chown 65534:65534 /var/lib/prometheus

    cd "$STACK_DIR" || exit 1
    $CMD down || true # stop any existing stack
    $CMD up -d > /run/podman-grafana-stack.log 2>&1
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
