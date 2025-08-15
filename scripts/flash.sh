#!/bin/bash

image=ha-image
image_path="build/tmp-rpi3ha-64/deploy/images/rpi3ha-64/${image}-rpi3ha-64.rootfs.wic.bz2"

bunzip2 -c ${image_path} | sudo dd of=/dev/sdd bs=1M oflag=direct iflag=fullblock conv=fsync 