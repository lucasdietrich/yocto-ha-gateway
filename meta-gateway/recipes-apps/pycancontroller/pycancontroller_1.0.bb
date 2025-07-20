SUMMARY = "CANIOT Python Controller controller and http server"
DESCRIPTION = "Services for controller and http server"
LICENSE="CLOSED"

SRC_URI = "\
    file://pycancontroller-can.service \
    file://pycancontroller-web.service \
    file://pycancontroller-can.init \
    file://pycancontroller-web.init \
    file://config.toml \
"

inherit update-rc.d systemd

PACKAGES = "${PN}-can ${PN}-web"

CONFFILES:${PN} = "${sysconfdir}/default/pycancontroller.default.toml"

# enable both services
PACKAGECONFIG ??= "can web"
PACKAGECONFIG[can] = ""
PACKAGECONFIG[web] = ""

INITSCRIPT_PACKAGES = "\
    ${@bb.utils.contains('PACKAGECONFIG', 'can', '${PN}-can', '', d)} \
    ${@bb.utils.contains('PACKAGECONFIG', 'web', '${PN}-web', '', d)} \
"

INITSCRIPT_NAME:${PN}-can="${PN}-can.init"
INITSCRIPT_PARAMS:${PN}-can = "defaults 80"

INITSCRIPT_NAME:${PN}-web="${PN}-web.init"
INITSCRIPT_PARAMS:${PN}-web = "defaults 81"


SYSTEMD_PACKAGES = "\
    ${@bb.utils.contains('PACKAGECONFIG', 'can', '${PN}-can', '', d)} \
    ${@bb.utils.contains('PACKAGECONFIG', 'web', '${PN}-web', '', d)} \
"

SYSTEMD_SERVICE:${PN}-can = "${PN}-can.service"
SYSTEMD_SERVICE:${PN}-web = "${PN}-web.service"

SYSTEMD_AUTO_ENABLE:${PN}-can = "enable"
SYSTEMD_AUTO_ENABLE:${PN}-web = "enable"


RDEPENDS:${PN}-can += "python3-cancontroller"
RDEPENDS:${PN}-web += "python3-cancontroller"

FILES:${PN}-can += "\
    ${systemd_unitdir}/system/pycancontroller-can.service \
    ${sysconfdir}/init.d/pycancontroller-can.init \
    ${sysconfdir}/pycancontroller/config.toml \
"

FILES:${PN}-web += "\
    ${systemd_unitdir}/system/pycancontroller-web.service \
    ${sysconfdir}/init.d/pycancontroller-web.init \
    ${sysconfdir}/pycancontroller/config.toml \
"

do_install() {
    # # default config
    # install -d ${D}${sysconfdir}/default
    # install -m 0644 ${WORKDIR}/config.toml ${D}${sysconfdir}/default/pycancontroller.default.toml

    # config
    install -d ${D}${sysconfdir}/pycancontroller
    install -m 0644 ${WORKDIR}/config.toml ${D}${sysconfdir}/pycancontroller/config.toml

    if ${@bb.utils.contains('DISTRO_FEATURES', 'sysvinit', 'true', 'false', d)}; then
        install -d ${D}${sysconfdir}/init.d
        if ${@bb.utils.contains('PACKAGECONFIG', 'can', 'true', 'false', d)}; then
            install -m 0755 ${WORKDIR}/pycancontroller-can.init ${D}${sysconfdir}/init.d/
        fi
        if ${@bb.utils.contains('PACKAGECONFIG', 'web', 'true', 'false', d)}; then
            install -m 0755 ${WORKDIR}/pycancontroller-web.init ${D}${sysconfdir}/init.d/
        fi
    elif ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        # install systemd services
        install -d ${D}${systemd_unitdir}/system
        if ${@bb.utils.contains('PACKAGECONFIG', 'can', 'true', 'false', d)}; then
            install -m 0644 ${WORKDIR}/pycancontroller-can.service ${D}${systemd_unitdir}/system/
        fi
        if ${@bb.utils.contains('PACKAGECONFIG', 'web', 'true', 'false', d)}; then
            install -m 0644 ${WORKDIR}/pycancontroller-web.service ${D}${systemd_unitdir}/system/
        fi
    fi
}
