LICENSE = "CLOSED"
 
SRC_URI = "file://one.sh \
file://two.sh \
"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
 
UNPACKDIR = "${S}"
 
inherit update-rc.d
 
INITSCRIPT_PACKAGES = "${PN}-one ${PN}-two"

UPDATERCPN = "one.sh two.sh"
 
INITSCRIPT_NAME:${PN}-one = "one.sh"
INITSCRIPT_PARAMS:${PN}-one = "start 50 5 ."
 
INITSCRIPT_NAME:${PN}-two= "two.sh"
INITSCRIPT_PARAMS:${PN}-two= "start 40 5 ."
 
do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/one.sh ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/two.sh ${D}${sysconfdir}/init.d/
}
 
PACKAGES =+ "${PN}-one"
PACKAGES =+ "${PN}-two"
 
FILES_${PN}-one= "${sysconfdir}/init.d/one.sh"
FILES_${PN}-two= "${sysconfdir}/init.d/two.sh"