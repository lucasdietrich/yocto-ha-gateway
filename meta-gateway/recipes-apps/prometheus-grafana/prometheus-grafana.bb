SUMMARY = "Prometheus + Grafana stack configuration files"
DESCRIPTION = "Provides podman-compose and configuration files for Prometheus + Grafana stack"
LICENSE = "CLOSED"

SRC_URI = "file://init-podman-grafana-stack.sh \
           file://podman-compose.yaml \
           file://prometheus/prometheus.yml \
           file://grafana/provisioning/datasources/prometheus.yml \
           file://grafana/provisioning/dashboards/default.yaml \
           file://grafana/dashboards/ble-devices-dashboard.json \
           https://raw.githubusercontent.com/rfmoz/grafana-dashboards/33d1847cfd7be0814eee52048dc23f22ff130b11/prometheus/node-exporter-full.json;name=node-exporter-full.json \
           "
SRC_URI[node-exporter-full.json.sha256sum] = "b9e3b9d0f7e0c20e7ae24df8b2751508196dee21fd8ead61704258c2bd66cedd"

RDEPENDS:${PN} += "podman-compose"

inherit update-rc.d

# start late
INITSCRIPT_PARAMS = "start 99 5 3 2 . stop 10 0 1 6 ."
INITSCRIPT_NAME = "${PN}.sh"

S = "${WORKDIR}"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -m 0755 ${WORKDIR}/init-podman-grafana-stack.sh ${D}${sysconfdir}/init.d/${INITSCRIPT_NAME}

    install -d ${D}/opt/prometheus-grafana/prometheus
    install -d ${D}/opt/prometheus-grafana/grafana/provisioning/datasources
    install -d ${D}/opt/prometheus-grafana/grafana/provisioning/dashboards
    install -d ${D}/opt/prometheus-grafana/grafana/dashboards

    install -m 0644 ${WORKDIR}/podman-compose.yaml ${D}/opt/prometheus-grafana/
    install -m 0644 ${WORKDIR}/prometheus/prometheus.yml ${D}/opt/prometheus-grafana/prometheus/
    install -m 0644 ${WORKDIR}/grafana/provisioning/datasources/prometheus.yml ${D}/opt/prometheus-grafana/grafana/provisioning/datasources/
    install -m 0644 ${WORKDIR}/grafana/provisioning/dashboards/default.yaml ${D}/opt/prometheus-grafana/grafana/provisioning/dashboards/
    
    install -m 0644 ${WORKDIR}/grafana/dashboards/ble-devices-dashboard.json ${D}/opt/prometheus-grafana/grafana/dashboards/
    install -m 0644 ${WORKDIR}/node-exporter-full.json ${D}/opt/prometheus-grafana/grafana/dashboards/node-exporter-full.json
}

FILES:${PN} += " /opt/prometheus-grafana/"