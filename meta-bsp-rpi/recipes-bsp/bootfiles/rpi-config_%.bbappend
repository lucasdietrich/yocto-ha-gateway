CAN_OSCILLATOR = "16000000"
CAN0_INTERRUPT_PIN = "23"

# Read https://elinux.org/RPiconfig

########################################################################
##      ISSUE WITH CAN1 (interrupt pin does not seems to work)        ##
########################################################################

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

# CAN 0 OK
#dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23

# CAN ONLY SEND 1 FRAME:
#dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25

# STUCK on IF UP:
#dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=24

# STUCK on IF UP
#dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=22

# CAN1 OK, CAN0 CAN ONLY SEND 1 FRAME
#dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
#dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25
#[    5.887935] mcp251x spi0.1 can0: MCP2515 successfully initialized.
#[    5.935941] mcp251x spi0.0 can1: MCP2515 successfully initialized.


# CAN0 STUCK on IF UP, CAN 1 OK
#dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
#dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=24
#[    6.034567] mcp251x spi0.1 can0: MCP2515 successfully initialized.
#[    6.063630] mcp251x spi0.0 can1: MCP2515 successfully initialized.

# CAN0 OK, CAN1 can only send 1 frame
#dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25
#dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
#[    5.908540] mcp251x spi0.0 can0: MCP2515 successfully initialized.
#[    5.929793] mcp251x spi0.1 can1: MCP2515 successfully initialized.

# CAN0 OK, CAN1 STUCK on IF UP
# dtoverlay=spi1-2cs
# dtoverlay=mcp2515-can1,oscillator=16000000,interrupt=25
# dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=23
#[    5.908540] mcp251x spi0.0 can0: MCP2515 successfully initialized.
#[    5.929793] mcp251x spi0.1 can1: MCP2515 successfully initialized.