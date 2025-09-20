inherit core-image

DESCRIPTION = "HA image minimal"

LICENSE = "CLOSED"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

IMAGE_INSTALL:append = "\
    packagegroup-core-boot \
    packagegroup-ha-bsp \
    packagegroup-core-base-utils \
    swupdate \
    swupdate-www \
    swupdate-tools \
    cannelloni \
    udev-rules-rpi \
"

IMAGE_INSTALL:append = "${@bb.utils.contains('HA_DEBUG_UTILS', '1',' \
    util-linux \
    e2fsprogs-resize2fs \
    e2fsprogs-e2fsck \
    e2fsprogs \
    btrfs-tools \
    gdbserver \
    htop \
    iotop \
    lsof \
    strace \
    socat \
    valgrind \
    iperf3 \
    smemstat \
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

IMAGE_FEATURES += "ssh-server-openssh"

EXTRA_IMAGE_FEATURES = "\
    allow-root-login \
"

EXTRA_IMAGE_FEATURES += "${@bb.utils.contains('HA_DEBUG_SSH', '1',' \
    debug-tweaks \
    empty-root-password \
    allow-empty-password \
    post-install-logging \
', '', d)}"

inherit extrausers

# Use mkpasswd tool (can be obtained through package whois on debian) to generate a password hash:
#       printf "%q" $(mkpasswd -m sha256crypt mypassword)

# defaults to "root"
HA_ROOT_PASSWORD ?= "\$5\$i2vQ16WOMEpOajYi\$zXVuoyLsBzoKS7Cgdk3VrFOom9zNfQIW2hGC/yxPfZ9"
EXTRA_USERS_PARAMS = "\
        usermod -p '${HA_ROOT_PASSWORD}' root; \
        "

TOOLCHAIN_HOST_TASK += "packagegroup-rust-cross-canadian-${MACHINE} \
                        nativesdk-umoci \
                        nativesdk-skopeo \
                        nativesdk-erofs-utils \
                        nativesdk-systemtap \
                        "

# Fix the image size and maximum to 1GiB to make sure it fits in a fixed-size partition
# IMAGE_OVERHEAD_FACTOR = "1.0"
# IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_ROOTFS_SIZE = "1048576"
IMAGE_ROOTFS_MAXSIZE = "${IMAGE_ROOTFS_SIZE}"

IMAGE_FSTYPES += "squashfs"
IMAGE_FSTYPES += "ext3.gz"

# Make sure the fstab is not altered by wic command after the rootfs is created
# fix an issue where /etc/fstab is unaligned for .SWU and .WIC images
WIC_CREATE_EXTRA_ARGS = "--no-fstab-update"
WKS_FILE = "${@bb.utils.contains('DISTRO_FEATURES', 'swap-partition', 'sdimage-ha-minimal-raspberrypi-swap.wks', 'sdimage-ha-minimal-raspberrypi.wks', d)}"

# TODO
# ROOTFS_READ_ONLY ?= "1"

python() {
  d.setVarFlag("SWUPDATE_IMAGES_FSTYPES", d.getVar("IMAGE_BASENAME"), ".ext3.gz")
}

# swupdate image
inherit swupdate-image

SRC_URI += "\
    file://sw-description \
    file://update-script.sh \
"

# boot partition
rootfs_fstab_boot() {
    # Patch /etc/fstab and add boot partition mount
    echo "/dev/mmcblk0p1	/boot	vfat	defaults	0	0" >> ${IMAGE_ROOTFS}/etc/fstab
}
ROOTFS_POSTPROCESS_COMMAND += "rootfs_fstab_boot; "

# swap partition
rootfs_fstab_swap() {
    # Patch /etc/fstab and add swap partition mount
    echo "/dev/mmcblk0p5	none	swap	sw	0	0" >> ${IMAGE_ROOTFS}/etc/fstab
}
ROOTFS_POSTPROCESS_COMMAND += "${@bb.utils.contains('DISTRO_FEATURES', 'swap-partition', 'rootfs_fstab_swap;', '', d)} "

# cgroups
rootfs_fstab_cgroup2() {
    # Patch /etc/fstab and add cgroup2 mount
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