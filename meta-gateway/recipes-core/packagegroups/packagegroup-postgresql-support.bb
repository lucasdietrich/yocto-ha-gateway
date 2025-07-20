SUMMARY = "PostgreSQL support for HA Gateway"
LICENSE = "CLOSED"

inherit packagegroup

# populate here
RDEPENDS:${PN} = "\
    postgresql \
    postgresql-contrib \
    postgresql-client \
"