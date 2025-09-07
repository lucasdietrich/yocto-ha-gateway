require recipes-core/images/ha-image-minimal.bb

# jlink requires freetype
IMAGE_INSTALL:append = "\
    freetype \
    openocd \
    minicom \
    picocom \
    tmux \
"