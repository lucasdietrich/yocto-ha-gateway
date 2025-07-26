SUMMARY = "HA BSP packages"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    os-release \
    ca-certificates \
    userfs \
    fwupdate \
"

# u-boot-fw-utils add the fw_printenv fw_setenv utilities
# u-boot-env provides the env config file `/etc/fw_env.config`
RDEPENDS:${PN} += "\
    u-boot-env \
    u-boot-fw-utils \
"