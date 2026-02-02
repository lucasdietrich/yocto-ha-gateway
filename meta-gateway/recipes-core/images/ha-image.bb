require recipes-core/images/ha-image-minimal.bb

IMAGE_INSTALL:append = "\
    packagegroup-ha-gateway \
    packagegroup-pycancontroller-legacy \
    packagegroup-ha-containers \
"