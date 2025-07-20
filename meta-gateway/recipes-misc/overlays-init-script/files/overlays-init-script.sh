#!/bin/bash
# description: Description comes here....

# Source function library.
. /etc/init.d/functions

start() {
   # mount etc
   mkdir -p /mnt/userfs/etc
   mkdir -p /mnt/userfs/.work.etc
      
   mount -t overlay overlay \
      -o lowerdir=/etc,upperdir=/mnt/userfs/etc,workdir=/mnt/userfs/.work.etc \
      /etc

   # mount var
   mkdir -p /mnt/userfs/var
   mkdir -p /mnt/userfs/.work.var

   # if /var/volatile is already mounted, we need to unmount it first
   if mount | grep /var/volatile > /dev/null; then
      umount /var/volatile
   fi

   mount -t overlay overlay \
      -o lowerdir=/var,upperdir=/mnt/userfs/var,workdir=/mnt/userfs/.work.var \
      /var

   # mount /var/volatile again
   mount -t tmpfs tmpfs /var/volatile

   # mount run
   mkdir -p /mnt/userfs/home
   mkdir -p /mnt/userfs/.work.home

   mount -t overlay overlay \
      -o lowerdir=/home,upperdir=/mnt/userfs/home,workdir=/mnt/userfs/.work.home \
       /home
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
