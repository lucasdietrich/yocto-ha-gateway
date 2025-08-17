# HA gateway

## Configuration

### `local.conf`

```conf
DL_DIR ?= "/home/lucas/yocto/downloads"
SSTATE_DIR ?= "/home/lucas/yocto/sstate-cache"

CONF_VERSION = "2"
INHERIT += "rm_work"
RM_WORK_EXCLUDE += ""

MACHINE ??= "rpi2ha"
DISTRO = "ha"

HA_DEBUG_IMAGE = "1"
HA_DEBUG_STATIC_IP = "0"
LICENSE_FLAGS_ACCEPTED = "commercial synaptics-killswitch"
```

### `bblayers.conf`

```conf
BBLAYERS ?= " \
  ${TOPDIR}/../poky/meta \
  ${TOPDIR}/../poky/meta-poky \
  ${TOPDIR}/../poky/meta-yocto-bsp \
  ${TOPDIR}/../meta-openembedded/meta-oe \
  ${TOPDIR}/../meta-openembedded/meta-python \
  ${TOPDIR}/../meta-openembedded/meta-networking \
  ${TOPDIR}/../meta-openembedded/meta-filesystems \
  ${TOPDIR}/../meta-openembedded/meta-webserver \
  ${TOPDIR}/../meta-virtualization \
  ${TOPDIR}/../meta-raspberrypi \
  ${TOPDIR}/../meta-bsp-rpi \
  ${TOPDIR}/../meta-gateway \
  "
```


## Machines

- `rpi2ha`: Raspberry Pi 2 based HA gateway
- `rpi3ha`: Raspberry Pi 3 based HA gateway
- `rpi4ha`: Raspberry Pi 4 based HA gateway

## Images

- `ha-rpi-image-ng`: Main image for the HA gateway
- `ha-rpi-image-legacy`: Legacy image for the HA gatewaye

## References:

- [Raspberry Pi ASAP Setup Guide](https://kr15h.github.io/RPi-Setup/)
