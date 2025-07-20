DEPENDS += "protobuf-native nodejs-native bash-native"

inherit update-rc.d

FILESEXTRAPATHS:append := "${THISDIR}/files:"

SRC_URI += "file://caniot-controller.toml \
            file://caniot-controller.init \
            "

S = "${WORKDIR}/git"

INITSCRIPT_NAME = "${PN}.init"
INITSCRIPT_PARAMS = "defaults 80"

PACKAGECONFIG ??= "sqlite3 ble-copro"
PACKAGECONFIG[sqlite3] = ",,sqlite3"
PACKAGECONFIG[postgres] = ",,packagegroup-postgresql-support"
PACKAGECONFIG[ble-copro] = ",,,ble-copro-usb-net"

do_compile[network] = "1"
do_compile:prepend() {
    # make sure a local npm cache is used (instead of the global one)
    OPTIONS="--prefer-online --cache ${WORKDIR}/npm-cache"

    cd ${S}/proto/grpc-web
    npm install ${OPTIONS}
    bash ./proto-gen-grpc-web.sh

    cd ${S}/ui
    npm install ${OPTIONS}
    npm run build ${OPTIONS}
}

do_install:append() {
    # copy ui files
    install -d ${D}${datadir}/caniot-controller/ui
    cp -r ${S}/ui/dist/* ${D}${datadir}/caniot-controller/ui

    # copy configuration file
    install -d ${D}${sysconfdir}/caniot-controller
    install -m 0644 ${WORKDIR}/caniot-controller.toml ${D}${sysconfdir}/caniot-controller

    # copy init script
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/caniot-controller.init ${D}${sysconfdir}/init.d/

    # prepare persitent data directory /var/lib/caniot-controller
    install -d ${D}${localstatedir}/lib/caniot-controller
}