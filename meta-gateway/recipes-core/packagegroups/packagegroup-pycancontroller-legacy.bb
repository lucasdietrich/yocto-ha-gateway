SUMMARY = "Python CAN Controller package group (legacy support)"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    ntpd-start \
    python3-can \
    python3-cancontroller \
    pycancontroller-can \
    pycancontroller-web \
"