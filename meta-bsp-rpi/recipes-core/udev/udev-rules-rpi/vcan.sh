#!/bin/sh

case "$1" in
    add)
        ip link add dev vcan0 type vcan
        ip link set vcan0 mtu 16
        ip link set up vcan0
        ;;
    remove)
        ip link delete vcan0 type vcan
        ;;
    *)
        echo "Usage: $0 {add|remove}"
        exit 1
        ;;
esac
