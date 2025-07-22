inherit core-image

DESCRIPTION = "HA image minimal"

LICENSE = "CLOSED"

IMAGE_INSTALL:append = "\
    packagegroup-core-boot \
    packagegroup-ha-bsp \
    packagegroup-core-base-utils \
"

IMAGE_FEATURES += "${@bb.utils.contains('HA_DEBUG_IMAGE', '1','ssh-server-openssh', '', d)}"

IMAGE_INSTALL:append = "${@bb.utils.contains('HA_DEBUG_IMAGE', '1',' \
    util-linux \
    e2fsprogs-resize2fs \
    e2fsprogs-e2fsck \
    e2fsprogs \
    btrfs-tools \
    gdbserver \
    htop \
    strace \
    socat \
    valgrind \
    iperf3 \
    tcpdump \
    perf \
    curl \
    nano \
    tree \
    canutils \
    can-utils \
    dtc \
    git \
    bash-completion \
    minicom \
    mosquitto-clients \
', '', d)}"

EXTRA_IMAGE_FEATURES = "${@bb.utils.contains('HA_DEBUG_IMAGE', '1',' \
    debug-tweaks \
    empty-root-password \
    allow-empty-password \
    allow-root-login \
    post-install-logging \
', '', d)}"

TOOLCHAIN_HOST_TASK += "packagegroup-rust-cross-canadian-${MACHINE} \
                        nativesdk-umoci \
                        nativesdk-skopeo \
                        nativesdk-erofs-utils \
                        nativesdk-systemtap \
                        "


# BalenaEtcher fails to flash the image if it is too big
# IMAGE_ROOTFS_SIZE = "2097152"
# IMAGE_ROOTFS_EXTRA_SPACE = "327680"

WKS_FILE = "sdimage-ha-raspberrypi.wks"

# TODO
# ROOTFS_READ_ONLY ?= "1"

# cgroups
rootfs_fstab_cgroup2() {
    # Path /etc/fstab and add cgroup2 mount
    echo "cgroup               /sys/fs/cgroup       cgroup2    defaults              0  0" >> ${IMAGE_ROOTFS}/etc/fstab
}
ROOTFS_POSTPROCESS_COMMAND += "rootfs_fstab_cgroup2; "

# userfs directory
rootfs_prepare_userfs() {
    install -d ${IMAGE_ROOTFS}/mnt/userfs
}
ROOTFS_POSTPROCESS_COMMAND += "rootfs_prepare_userfs;"

# ha debug flag
ha_debug_image_rootfs_postprocess() {
    install -d ${IMAGE_ROOTFS}/etc
    touch ${IMAGE_ROOTFS}/etc/.ha-debug-image
}
ROOTFS_POSTPROCESS_COMMAND += "${@bb.utils.contains('HA_DEBUG_IMAGE', '1',' ha_debug_image_rootfs_postprocess;', '', d)}"