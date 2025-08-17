#!/bin/sh

# set -e

# Source function library.
. /etc/init.d/functions

create_ab_symlinks() {
    # get root partition we are currently booted from
    self_root_part=$(fw_printenv rootpart | cut -d= -f2)

    if [ "$self_root_part" = "2" ]; then
        other_root_part="3"
    else
        other_root_part="2"
    fi

    # create symlinks to the current and other root partitions
    self_root="/dev/mmcblk0p$self_root_part"
    other_root="/dev/mmcblk0p$other_root_part"

    mkdir -p /dev/disk
    ln -snf "$self_root" /dev/disk/rootfs-self
    ln -snf "$other_root" /dev/disk/rootfs-other
}

handle_pending_update() {
    # https://sbabic.github.io/swupdate/swupdate-best-practise.html
    ustate=$(fw_printenv ustate | cut -d= -f2)

    case "$ustate" in
        0)
            echo "fwupdate: No update pending."
            ;;
        1)
            echo "fwupdate: A new update was installed (under test)."

            # swupdate has finished installed th update, the ustate is set to 1 (STATE_INSTALLED)
            # we should normally test the update here, but for now we just assume it is ok
            # and we just clear the ustate flag (STATE_OK)
            fw_setenv ustate 0
            ;;
        3)
            echo "fwupdate: Update failed, rolling back to previous rootfs. (TODO)"
            ;;
        *)
            echo "fwupdate: Unknown ustate: $ustate"
            ;;
    esac
}

start() {
    handle_pending_update
    create_ab_symlinks
}

stop() {
    :
}

case "$1" in
    start)
       start
       ;;
    stop)
       stop
       ;;
    status)
       ;;
    *)
       echo "Usage: $0 {start|stop}"
esac

exit 0