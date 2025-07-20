# Read https://elinux.org/RPiconfig

# make sure ENABLE_DUAL_CAN and ENABLE_CAN are not set
ENABLE_DUAL_CAN = ""
ENABLE_CAN = ""

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

do_deploy:append() {
    # Clear any CAN configuration in the config.txt file
    sed -i '/dtoverlay=mcp2515-can/d' $CONFIG

    #
    # With 2-CH_CAN_HAT on raspberry pi 2 model B
    # - oscillator is 16Mhz
    # 
    # Troubleshooting:
    #
    # 1. Make sure to select 5V for the jumper on the board (and not 3.3V), otherwise you
    # will experience jiggling on your interrupt 25 and a load of 100% on the core handling
    # SPI interrupts.
    #
    # 2. For some reason the interrupt pins are not set correctly with ENABLE_DUAL_CAN option
    # we need to set them manually.
    # 
    # TODO: Curently, can0 actually refers to the CAN marked as CAN1 on the board, and vice versa.
    # 
    # Notes:
    #
    # more information on the shield here: https://www.waveshare.com/wiki/2-CH_CAN_HAT
    # infos about the driver here: http://www.airspayce.com/mikem/bcm2835/index.html
    echo "dtoverlay=mcp2515-can0,oscillator=${CAN_OSCILLATOR},interrupt=23" >> $CONFIG

    # TODO second can doesn't work yet
    # echo "dtoverlay=mcp2515-can1,oscillator=${CAN_OSCILLATOR},interrupt=25" >> $CONFIG
}