SUMMARY = "userfs is a tool to create/manage user partitions and filesystems"
HOMEPAGE = "https://github.com/lucasdietrich/userfs"
LICENSE = "CLOSED"

SRC_URI = "git://github.com/lucasdietrich/userfs.git;protocol=https;branch=main \
           file://init-user-fs.sh \
           "
SRCREV = "fca3c71c886e278fa769a1c905eda576c31f7869"

DEPENDS += "util-linux"
RDEPENDS:${PN} += "util-linux-libfdisk"

inherit meson pkgconfig update-rc.d

S = "${WORKDIR}/git"

# the filesystems must be created after the `mountall.sh` script,
# before any application want to store data
INITSCRIPT_PARAMS = "start 04 S ."
INITSCRIPT_NAME = "${PN}.sh"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-user-fs.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
}