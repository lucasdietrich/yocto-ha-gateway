FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://dnsmasq.conf"

do_install:append() {
    # Copy the dnsmasq configuration file to the appropriate location
    install -d ${D}${sysconfdir}/dnsmasq.d
    install -m 644 ${WORKDIR}/dnsmasq.conf ${D}${sysconfdir}/
}