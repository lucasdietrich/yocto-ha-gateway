FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-TCP-Remove-timeout-when-waiting-for-an-incoming-conn.patch \
            file://init-cannelloni-tcpserver.sh \
            "

inherit update-rc.d

INITSCRIPT_PARAMS = "start 60 5 3 2 . stop 40 0 1 6 ."
INITSCRIPT_NAME = "cannelloni-tcpserver.sh"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-cannelloni-tcpserver.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
}