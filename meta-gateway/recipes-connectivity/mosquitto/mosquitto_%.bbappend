FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://mosquitto.conf \
"

# no particular features are enabled by default
PACKAGECONFIG=""

do_install:append() {
    install -d ${D}${sysconfdir}/mosquitto
    install -m 0644 ${WORKDIR}/mosquitto.conf ${D}${sysconfdir}/mosquitto/mosquitto.conf
}