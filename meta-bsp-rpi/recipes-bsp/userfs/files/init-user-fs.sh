#!/bin/sh

# set -e

# Source function library.
. /etc/init.d/functions

start() {
   # create userfs partition (btrfs)
   /usr/bin/userfs

   partprobe /dev/mmcblk0
   /usr/bin/mkfs.btrfs -f /dev/mmcblk0p3

   # mount userfs partition
   mkdir -p /mnt/userfs
   mount -t btrfs /dev/mmcblk0p3 /mnt/userfs

   # create subvolumes
   if ! btrfs subvolume show /mnt/userfs/vol-data >/dev/null 2>&1; then
      btrfs subvolume create /mnt/userfs/vol-data
   fi
   if ! btrfs subvolume show /mnt/userfs/vol-config >/dev/null 2>&1; then
      btrfs subvolume create /mnt/userfs/vol-config
   fi

   # if /var/volatile is already mounted, we need to unmount it first
   if mount | grep /var/volatile > /dev/null; then
      umount /var/volatile
   fi

   # create overlayfs for var, etc, and home
   mkdir -p /mnt/userfs/vol-config/etc /mnt/userfs/vol-config/.work.etc
   mount -t overlay overlay \
      -o lowerdir=/etc,upperdir=/mnt/userfs/vol-config/etc,workdir=/mnt/userfs/vol-config/.work.etc \
      /etc

   mkdir -p /mnt/userfs/vol-data/var /mnt/userfs/vol-data/.work.var
   mount -t overlay overlay \
      -o lowerdir=/var,upperdir=/mnt/userfs/vol-data/var,workdir=/mnt/userfs/vol-data/.work.var \
      /var

   mkdir -p /mnt/userfs/vol-data/home /mnt/userfs/vol-data/.work.home
   mount -t overlay overlay \
      -o lowerdir=/home,upperdir=/mnt/userfs/vol-data/home,workdir=/mnt/userfs/vol-data/.work.home \
      /home

   # mount /var/volatile again
   mount -t tmpfs tmpfs /var/volatile
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