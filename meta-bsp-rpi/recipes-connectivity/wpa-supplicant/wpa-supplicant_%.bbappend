FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://wpa_supplicant.conf.fragment.in"

# Define SSID and password as variables (can be overridden from local.conf)
WIFI_SSID ?= "${HA_DEBUG_WIFI_SSID}"
WIFI_PASSWORD ?= "${HA_DEBUG_WIFI_PASSWORD}"

do_configure:append() {
    if [ ! -z "${WIFI_SSID}" ]; then
        sed -e "s|@SSID@|${WIFI_SSID}|g" \
            -e "s|@PASSWORD@|${WIFI_PASSWORD}|g" \
            ${WORKDIR}/wpa_supplicant.conf.fragment.in \
            >> ${WORKDIR}/wpa_supplicant.conf-sane
    fi
}