SUMMARY = "HA Gateway applications"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    ha-environment \
    dnsmasq \
    ntpd-start \
    caniot-controller \
    nginx \
    tzdata \
    dbus \
"