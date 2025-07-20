DESCRIPTION = "Overlays init script, this recipes create overlays for /var and /home"
LICENSE = "CLOSED"

SRC_URI = "file://overlays-init-script.sh"

RDEPENDS:${PN} += "bash"
inherit update-rc.d

INITSCRIPT_NAME = "${PN}.sh"
INITSCRIPT_PARAMS = "start 04 S ."

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/${INITSCRIPT_NAME} ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
}

FILES_${PN} += "${sysconfdir}/init.d"
