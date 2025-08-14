FILESEXTRAPATHS:prepend:class-target := "${THISDIR}/${PN}:"

RDEPENDS:${PN}:append:class-target = " fuse-overlayfs"

