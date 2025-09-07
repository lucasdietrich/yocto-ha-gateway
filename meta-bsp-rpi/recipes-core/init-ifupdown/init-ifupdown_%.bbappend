FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

do_configure:append() {
    # disable dhcp for eth0 only if HA_DEBUG_STATIC_IP is "1"
    if [ "${HA_DEBUG_STATIC_IP}" = "1" ]; then
        sed -i '/^iface eth0 inet dhcp/d' ${S}/interfaces
    fi
}