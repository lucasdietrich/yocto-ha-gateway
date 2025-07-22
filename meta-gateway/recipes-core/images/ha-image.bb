require recipes-core/images/ha-image-minimal.bb

IMAGE_INSTALL:append = "\
    packagegroup-ha-gateway \
    openssl \
    mbedtls \
    nginx \
    libstd-rs \
    ntpd-start \
    sqlite3 \
"