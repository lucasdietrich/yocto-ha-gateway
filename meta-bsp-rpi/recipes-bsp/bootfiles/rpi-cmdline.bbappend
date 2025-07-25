# https://kr15h.github.io/RPi-Setup/

# Configure default interface and IP address for my LAN
CMDLINE += "ip=192.168.10.70::192.168.10.1:255.255.255.0:rpi:eth0:off"

# Disable the root= argument as it will be dynamically set by u-boot
CMDLINE_ROOTFS = "${CMDLINE_ROOT_FSTYPE} rootwait"

# rootfs type stays valid
CMDLINE_ROOT_FSTYPE ?= "rootfstype=ext4"