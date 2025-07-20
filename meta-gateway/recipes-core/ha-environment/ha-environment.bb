SUMMARY = "Provide default environment variables in profile.d"
LICENSE = "CLOSED"

SRC_URI = "file://ha-env.sh"

do_install() {
    install -d ${D}${sysconfdir}/profile.d
    install -m 0644 ${WORKDIR}/ha-env.sh ${D}${sysconfdir}/profile.d
}

FILES:${PN} += "${sysconfdir}/profile.d"