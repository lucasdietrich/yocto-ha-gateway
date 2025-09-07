#!/bin/bash

# Usage: ./rpi2-swupdate.sh [image_name] [machine] [ip] [port]
# Or set IMAGE, MACHINE, HOST, PORT as environment variables

IMAGE="${IMAGE:-ha-image}"
MACHINE="${MACHINE:-rpi2ha}"
HOST="${HOST:-192.168.10.222}"
PORT="${PORT:-8087}"

[ -n "$1" ] && IMAGE="$1"
[ -n "$2" ] && MACHINE="$2"
[ -n "$3" ] && HOST="$3"
[ -n "$4" ] && PORT="$4"

SWU_PATH="build/tmp-${MACHINE}/deploy/images/${MACHINE}/${IMAGE}-${MACHINE}.rootfs.swu"

echo "Uploading SWU image:"
echo "  Image:   $IMAGE"
echo "  Machine: $MACHINE"
echo "  HOST:    $HOST"
echo "  Port:    $PORT"
echo "  Path:    $SWU_PATH"

curl -F "file=@${SWU_PATH}" http://${HOST}:${PORT}/upload