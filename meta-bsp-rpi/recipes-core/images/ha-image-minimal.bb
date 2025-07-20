inherit core-image

DESCRIPTION = "HA minimal image"

LICENSE = "CLOSED"

IMAGE_FEATURES += "ssh-server-openssh"

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-core-base-utils \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    "

EXTRA_IMAGE_FEATURES = "${@bb.utils.contains('HA_DEBUG_IMAGE', '1',' \
    debug-tweaks \
    empty-root-password \
    allow-empty-password \
    allow-root-login \
    post-install-logging \
', '', d)}"