require recipes-core/images/ha-image-minimal.bb

IMAGE_INSTALL:append = "\
    packagegroup-ha-gateway \
    packagegroup-ha-containers \
"