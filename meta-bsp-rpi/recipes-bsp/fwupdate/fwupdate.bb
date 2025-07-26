SUMMARY = "fwupdate script are used to update the firmware of the Raspberry Pi"
LICENSE = "CLOSED"

SRC_URI = "file://init-fwupdate.sh \
           file://fwupdate.sh \
           "

inherit update-rc.d

# starts before swupdate
INITSCRIPT_PARAMS = "start 65 S ."
INITSCRIPT_NAME = "${PN}.sh"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-fwupdate.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    install -d ${D}${bindir}
    install -m 0755 ${WORKDIR}/fwupdate.sh ${D}${bindir}/fwupdate
}

FILES:${PN} += "${bindir}/fwupdate"