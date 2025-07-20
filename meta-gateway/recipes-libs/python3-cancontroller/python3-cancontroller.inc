SUMMARY = "CANIOT Python Controller packages"
DESCRIPTION = "Python Controller (HTTP server + CLI client + CAN controller) to manage caniot devices : for RaspberryPI2"
LICENSE = "CLOSED"

SRC_URI = "\
    git://lins/applications/caniot-pycontroller.git;protocol=http;branch=develop \
    "

inherit setuptools3

S = "${WORKDIR}/git"

PYPI_PACKAGE = "caniot-controller"

RDEPENDS:${PN} += "\
    python3-aenum \
    python3-aiohttp \
    python3-aiohttp-jinja2 \
    python3-async-timeout \
    python3-attrs \
    python3-certifi \
    python3-chardet \
    python3-charset-normalizer \
    python3-grpcio \
    python3-grpcio-tools \
    python3-idna \
    python3-jinja2 \
    python3-markupsafe \
    python3-multidict \
    python3-protobuf \
    python3-can \
    python3-requests \
    python3-six \
    python3-typing-extensions \
    python3-urllib3 \
    python3-wrapt \
    python3-yarl \
    python3-toml \
    python3-pytz \
    "