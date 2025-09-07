SUMMARY = "Home Assistant container configuration"
DESCRIPTION = "Provides homeassistant container configuration files"
LICENSE = "CLOSED"

SRC_URI = "file://init-hass.sh \
           file://podman-compose.yaml \
           "

RDEPENDS:${PN} += "podman-compose dbus"

inherit update-rc.d

# start late
INITSCRIPT_PARAMS = "start 99 5 3 2 . stop 10 0 1 6 ."
INITSCRIPT_NAME = "${PN}.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-hass.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    install -d ${D}/opt/hass
    install -m 0644 ${WORKDIR}/podman-compose.yaml ${D}/opt/hass/podman-compose.yaml

    install -d ${D}/opt/hass/config
}

FILES:${PN} += " /opt/hass"