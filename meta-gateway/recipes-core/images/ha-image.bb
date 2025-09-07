require recipes-core/images/ha-image-minimal.bb

IMAGE_INSTALL:append = "\
    packagegroup-ha-gateway \
    openssl \
    mbedtls \
    nginx \
    libstd-rs \
    ntpd-start \
    sqlite3 \
    podman \
    podman-tui \
    podman-compose \
    prometheus-grafana \
    hass \
"