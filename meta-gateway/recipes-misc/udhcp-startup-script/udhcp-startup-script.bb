DESCRIPTION = "Custom startup script for ha-gateway"
LICENSE = "CLOSED"

SRC_URI = "file://run-udhcpc.sh"

RDEPENDS:${PN} += "bash"
DEPENDS:append = "update-rc.d-native"

do_install:append() {
    install -d 644 ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/run-udhcpc.sh ${D}${sysconfdir}/init.d/run-udhcpc.sh
    update-rc.d -r ${D} run-udhcpc.sh start 99 2 3 4 5 .
}

FILES_${PN} += "${sysconfdir}/init.d"
