SUMMARY = "CANIOT Library"
DESCRIPTION = "CANIOT Library for IoT devices"
LICENSE = "CLOSED"

SRC_URI = "git://github.com/lucasdietrich/caniot-lib.git;branch=feature/rust;protocol=https"
SRCREV = "39b8e24255c8897a96d107c61ee7ba61e70fe37b"
S = "${WORKDIR}/git"

inherit cmake pkgconfig

PACKAGECONFIG ??= "shared"
PACKAGECONFIG[shared] = "-DBUILD_SHARED_LIBS=ON,-DBUILD_SHARED_LIBS=OFF"

BBCLASSEXTEND = "native nativesdk"