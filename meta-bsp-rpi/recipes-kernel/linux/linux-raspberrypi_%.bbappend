FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:raspberrypi4 = " \
    file://rpi4-btrfs.cfg \
"

KBUILD_DEFCONFIG:rpi2ha = "bcm2709_defconfig"
KBUILD_DEFCONFIG:rpi3ha = "bcm2711_defconfig"
KBUILD_DEFCONFIG:rpi4ha = "bcm2711_defconfig"

# autoload vcan module
KERNEL_MODULE_AUTOLOAD += "vcan"