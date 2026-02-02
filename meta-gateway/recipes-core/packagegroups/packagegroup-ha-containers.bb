SUMMARY = "HA Containers Package Group"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    podman \
    podman-tui \
    podman-compose \
    prometheus-grafana \
    hass \
"