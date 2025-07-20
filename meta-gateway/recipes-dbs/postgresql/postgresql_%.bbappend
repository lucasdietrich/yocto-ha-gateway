INITSCRIPT_PARAMS = "start 64 0 1 2 3 4 5 6 . stop 64 0 1 2 3 4 5 6 ."

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

RDEPENDS:${PN} += "postgresql-init-script"