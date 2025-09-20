SUMMARY = "Home Assistant container configuration"
DESCRIPTION = "Provides homeassistant container configuration files"
LICENSE = "CLOSED"

SRC_URI = "file://init-hass.sh \
           file://podman-compose.yaml \
           file://configuration.yaml \
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

    install -d ${D}/var/lib/homeassistant
    # chown 1000:1000 ${D}/var/lib/homeassistant
    install -m 0644 ${WORKDIR}/configuration.yaml ${D}/var/lib/homeassistant/configuration.yaml
    echo "[]" >> ${D}/var/lib/homeassistant/automations.yaml
    touch ${D}/var/lib/homeassistant/scenes.yaml
    touch ${D}/var/lib/homeassistant/scripts.yaml
}

FILES:${PN} += " /opt/hass"