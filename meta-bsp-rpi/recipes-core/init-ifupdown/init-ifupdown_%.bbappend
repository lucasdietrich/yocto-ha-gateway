do_configure:append() {
    # disable dhcp for eth0
    sed -i '/^iface eth0 inet dhcp/d' ${S}/interfaces
}