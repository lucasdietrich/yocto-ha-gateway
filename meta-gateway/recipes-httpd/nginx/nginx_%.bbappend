FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "\
    file://default_server.site \
    file://pycancontroller_server.site \
    file://mqtt.conf \
"

# nginx features
PACKAGECONFIG += "ssl"
PACKAGECONFIG += "stream"
PACKAGECONFIG += "http-auth-request"
PACKAGECONFIG += "stream_ssl"

# for SSL in stream { }
# - http://nginx.org/en/docs/stream/ngx_stream_ssl_module.html
PACKAGECONFIG[stream_ssl] = "--with-stream_ssl_module,,"

do_install:append() {
    # install pycancontroller_server site
    install -Dm 0644 ${WORKDIR}/pycancontroller_server.site ${D}${sysconfdir}/nginx/sites-available/pycancontroller_server
    ln -s ../sites-available/pycancontroller_server ${D}${sysconfdir}/nginx/sites-enabled/

    install -Dm 0644 ${WORKDIR}/mqtt.conf ${D}${sysconfdir}/nginx/conf.d/mqtt.conf
}