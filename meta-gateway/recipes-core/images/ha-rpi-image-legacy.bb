require recipes-core/images/ha-image.bb

IMAGE_INSTALL:append = "\
    packagegroup-pycancontroller-legacy \
"