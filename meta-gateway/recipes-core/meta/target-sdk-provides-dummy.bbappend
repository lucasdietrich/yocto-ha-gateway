# TODO find an alternative to this
#   see: meta-st-stm32mp/recipes-core/meta/target-sdk-provides-dummy.bbappend

# >>> bitbake ha-rpi-image-minimal -c populate_sdk
#
# ERROR: ha-rpi-image-minimal-1.0-r0 do_populate_sdk: Unable to install packages. Command '/var/lib/jenkins/workspace/yocto-caniot-gateway_main/build/tmp/work/raspberrypi2-poky-linux-gnueabi/ha-rpi-image-minimal/1.0-r0/recipe-sysroot-native/usr/bin/opkg --volatile-cache -f /var/lib/jenkins/workspace/yocto-caniot-gateway_main/build/tmp/work/raspberrypi2-poky-linux-gnueabi/ha-rpi-image-minimal/1.0-r0/opkg-sdk-target.conf -t /var/lib/jenkins/workspace/yocto-caniot-gateway_main/build/tmp/work/raspberrypi2-poky-linux-gnueabi/ha-rpi-image-minimal/1.0-r0/temp/ipktemp/ -o /var/lib/jenkins/workspace/yocto-caniot-gateway_main/build/tmp/work/raspberrypi2-poky-linux-gnueabi/ha-rpi-image-minimal/1.0-r0/sdk/image/usr/local/oe-sdk-hardcoded-buildpath/sysroots/cortexa7t2hf-neon-vfpv4-poky-linux-gnueabi  --force_postinstall --prefer-arch-to-version   install bash-completion canutils curl dtc e2fsprogs-resize2fs gdbserver git htop libmosquitto1 mbedtls mosquitto mosquitto-clients nano nginx openssl os-release packagegroup-base-extended packagegroup-core-boot packagegroup-core-ssh-dropbear packagegroup-core-standalone-sdk-target packagegroup-ha-gateway python3 python3-aiohttp python3-pyopenssl python3-requests python3-requests-oauthlib run-postinsts rust-hello-world strace target-sdk-provides-dummy test-double-init tree' returned 1:
# * Solver encountered 1 problem(s):
# * Problem 1/1:
# *   - package postgresql-14.5-r0.cortexa7hf-neon-vfpv4 requires perl >= 5.34.1, but none of the providers can be installed
# *   - package target-sdk-provides-dummy-1.0-r0.sdk-provides-dummy-target conflicts with perl provided by perl-5.34.1-r0.cortexa7t2hf-neon-vfpv4
# *   - package packagegroup-ha-gateway-1.0-r0.all requires postgresql, but none of the providers can be installed
# *   - conflicting requests
# *   - conflicting requests
# * 
# * Solution 1:
# *   - do not ask to install a package providing target-sdk-provides-dummy
#
# * Solution 2:
# *   - do not ask to install a package providing packagegroup-ha-gateway

DUMMYPROVIDES_PACKAGES:remove = "\
    busybox \
    busybox-dev \
    perl \
    perl-dev \
    perl-src \
    perl-module-re \
    perl-module-strict \
    perl-module-vars \
    perl-module-text-wrap \
    libxml-parser-perl \
    perl-module-bytes \
    perl-module-carp \
    perl-module-config \
    perl-module-constant \
    perl-module-data-dumper \
    perl-module-errno \
    perl-module-exporter \
    perl-module-file-basename \
    perl-module-file-compare \
    perl-module-file-copy \
    perl-module-file-find \
    perl-module-file-glob \
    perl-module-file-path \
    perl-module-file-stat \
    perl-module-file-temp \
    perl-module-getopt-long \
    perl-module-io-file \
    perl-module-overload \
    perl-module-overloading \
    perl-module-posix \
    perl-module-thread-queue \
    perl-module-threads \
    perl-module-warnings \
    perl-module-warnings-register \
"