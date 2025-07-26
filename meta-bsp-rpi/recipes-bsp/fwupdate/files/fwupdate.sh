#!/bin/sh

set -e

usage() {
    echo "Usage: $0 [apply_new_update | abort_update]"
    exit 1
}

ustate=$(fw_printenv ustate | cut -d= -f2)

# get root partition we are currently booted from
current_root_part=$(fw_printenv rootpart | cut -d= -f2)

if [ "$current_root_part" = "2" ]; then
    other_root_part="3"
else
    other_root_part="2"
fi

echo "$0 ustate: $ustate current_root_part: $current_root_part"


# Handle arguments
case "$1" in
    apply_new_update)
        # swupdate has set ustate to 7 (STATE_IN_PROGRESS)

        echo "Applying new update..."

        # select the other root partition
        fw_setenv rootpart "$other_root_part"

        ;;
    abort_update)
        echo "Aborting update..."

        # set ustate to 0 to indicate no update is in progress
        fw_setenv ustate 0

        # revert to the current root partition
        fw_setenv rootpart "$current_root_part"

        ;;
    "" | -h | --help)
        usage
        ;;
    *)
        echo "Error: Unknown argument '$1'"
        usage
        ;;
esac