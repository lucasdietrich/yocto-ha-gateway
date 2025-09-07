#!/bin/bash

# Usage: ./flash.sh [image_name] [machine] [device]
# Or set IMAGE, MACHINE, DEVICE as environment variables

# Set defaults
IMAGE="${IMAGE:-ha-image}"
MACHINE="${MACHINE:-rpi3ha}"
DEVICE="${DEVICE:-/dev/sdd}"

# Override with positional arguments if provided
[ -n "$1" ] && IMAGE="$1"
[ -n "$2" ] && MACHINE="$2"
[ -n "$3" ] && DEVICE="$3"

IMAGE_PATH="build/tmp-${MACHINE}/deploy/images/${MACHINE}/${IMAGE}-${MACHINE}.rootfs.wic.bz2"

echo "Flashing image:"
echo "  Image:  $IMAGE"
echo "  Machine: $MACHINE"
echo "  Device: $DEVICE"
echo "  Path:   $IMAGE_PATH"
read -p "Are you sure you want to flash to $DEVICE? [y/N] " confirm
[[ "$confirm" =~ ^[Yy]$ ]] || exit 1

bunzip2 -c "${IMAGE_PATH}" | sudo dd of="${DEVICE}" bs=1M oflag=direct iflag=fullblock conv=fsync