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
- `rpi3ha-64`: Raspberry Pi 3 based HA gateway (new)

## Images

- `ha-rpi-image-ng`: Main image for the HA gateway
- `ha-rpi-image-legacy`: Legacy image for the HA gatewaye

## References:

- [Raspberry Pi ASAP Setup Guide](https://kr15h.github.io/RPi-Setup/)

## Swupdate

Build swupdate image:

    bitbake mc:rpi3ha-64:ha-swupdate-image

Run swupdate

    /usr/bin/swupdate -v -w -r/www -p 8080 -H rpi3:1.0

Upload the image to the device:

    curl -F "file=@tmp-rpi3ha-64/deploy/images/rpi3ha-64/ha-image-rpi3ha-64.rootfs.swu" http://192.168.10.70:8080/upload

Decrompress the swu file:

    cpio -iv -H crc < /home/lucas/yocto/yocto-ha-gateway/build/tmp-rpi3ha-64/deploy/images/rpi3ha-64/ha-image-rpi3ha-64.rootfs.swu

Desired config 

```
software =
{
	version = "0.1.0";
	hardware-compatibility: [ "1.0" ];

	rpi3 = {
		images: (
			{
				filename = "ha-image-@@MACHINE@@.rootfs.ext3.gz";
				type = "raw";
				device = "/dev/mmcblk0p2";
				compressed = "zlib";
				sha256 = "$swupdate_get_sha256(ha-image-@@MACHINE@@.rootfs.ext3.gz)";
			}
		);
	}
}
```