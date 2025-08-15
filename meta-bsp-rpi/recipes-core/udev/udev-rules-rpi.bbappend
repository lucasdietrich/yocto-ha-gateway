FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://vcan.rules \
            file://vcan.sh \
"

do_install:append () {
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/vcan.rules ${D}${sysconfdir}/udev/rules.d/

    install -d ${D}${sysconfdir}/udev/scripts
    install -m 0755 ${WORKDIR}/vcan.sh ${D}${sysconfdir}/udev/scripts/
}
