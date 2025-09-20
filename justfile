swupdate-rpi4:
    MACHINE=rpi4ha HOST=rpinas-1 ./scripts/swupdate.sh

swupdate-rpi4-prod:
    CONF=rpi4ha-prod MACHINE=rpi4ha HOST=rpinas-1 ./scripts/swupdate.sh

swupdate-rpi2-prod:
    MACHINE=rpi2ha HOST=rpi2-can ./scripts/swupdate.sh

flash-rpi4:
    MACHINE=rpi4ha ./scripts/flash.sh

swupdate-tool:
    IMAGE=ha-image-tool MACHINE=rpi3ha HOST=192.168.10.212 ./scripts/swupdate.sh