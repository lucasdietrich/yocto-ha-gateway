SUMMARY = "HA Gateway applications"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    ha-environment \
    ntpd-start \
    caniot-controller \
    nginx \
    tzdata \
    overlays-init-script \
"