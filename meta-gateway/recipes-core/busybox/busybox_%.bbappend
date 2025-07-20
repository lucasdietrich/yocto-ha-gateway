FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# file name fragment.cfg is automatically applied (if menuconfig)
SRC_URI += "file://fragment.cfg"

# SRC_URI += "file://fragment.cfg;subdir=busybox-1.35.0"

