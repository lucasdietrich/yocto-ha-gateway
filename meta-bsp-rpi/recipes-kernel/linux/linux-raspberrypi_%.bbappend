KBUILD_DEFCONFIG:rpi2ha = "bcm2709_defconfig"
KBUILD_DEFCONFIG:rpi3ha-64 = "bcm2711_defconfig"

# autoload vcan module
KERNEL_MODULE_AUTOLOAD += "vcan"