SUMMARY = "userfs is a tool to create/manage user partitions and filesystems"
HOMEPAGE = "https://github.com/lucasdietrich/userfs"
LICENSE = "CLOSED"

SRC_URI = "git://github.com/lucasdietrich/userfs.git;protocol=https;branch=main \
           file://init-user-fs.sh \
           "
SRCREV = "64685aa36054215c984ed40e80230f52dd9fca5b"

DEPENDS += "util-linux"
RDEPENDS:${PN} += "util-linux-libfdisk"

inherit meson pkgconfig update-rc.d

# part 0: bootfs, part 1 rootfs, part 2 rootfs2, part 3 userfs
EXTRA_OEMESON += "-Duserfs_partno=3"

S = "${WORKDIR}/git"

# the filesystems must be created after the `mountall.sh` script,
# before any application want to store data
INITSCRIPT_PARAMS = "start 04 S ."
INITSCRIPT_NAME = "${PN}.sh"

do_install:append() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-user-fs.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}
}