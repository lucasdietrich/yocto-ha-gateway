#!/bin/bash

image=ha-image
# image=ha-image-minimal
# image=ha-image-ng
image_path="build/tmp-rpi3ha-64/deploy/images/rpi3ha-64/${image}-rpi3ha-64.rootfs.wic.bz2"

# bunzip2 -c build/tmp-rpi3ha-64/deploy/images/rpi3ha-64/ha-rpi-image-ng-rpi3ha-64.rootfs.wic.bz2 | sudo dd of=/dev/sdd bs=1M oflag=direct iflag=fullblock conv=fsync 
bunzip2 -c ${image_path} | sudo dd of=/dev/sdd bs=1M oflag=direct iflag=fullblock conv=fsync 
# bunzip2 -c build/tmp-rpi3ha-64/deploy/images/rpi3ha-64/ha-image-minimal-rpi3ha-64.rootfs.wic.bz2 | sudo dd of=/dev/sdd bs=1M oflag=direct iflag=fullblock conv=fsync 