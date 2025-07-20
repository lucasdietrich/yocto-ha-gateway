SUMMARY = "HA BSP packages"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    os-release \
    ca-certificates \
    userfs \
"