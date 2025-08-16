FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

VAR_VOLATILE_SIZE ?= "${@bb.utils.contains('DISTRO_FEATURES', 'swap-partition', '1G', '', d)}"

do_configure:append () {
    # Substitute MACHINE and DISTRO_VERSION into hwrevision
    sed -e 's/@MACHINE@/${MACHINE}/g' \
        -e 's/@DISTRO_VERSION@/${DISTRO_VERSION}/g' \
        -i ${WORKDIR}/motd

    # if VAR_VOLATILE_SIZE is set, append in fstab otherwise set default
    if [ -n "${VAR_VOLATILE_SIZE}" ]; then
        echo "tmpfs                /var/volatile        tmpfs      defaults,size=${VAR_VOLATILE_SIZE} 0 0" >> ${WORKDIR}/fstab
    else
        echo "tmpfs                /var/volatile        tmpfs      defaults              0  0" >> ${WORKDIR}/fstab
    fi
}