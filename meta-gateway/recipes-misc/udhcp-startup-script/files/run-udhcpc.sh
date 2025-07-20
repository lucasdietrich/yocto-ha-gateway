#!/bin/bash
# description: Description comes here....

# Source function library.
. /etc/init.d/functions

start() {
    # code to start app comes here
    # insert any kernel modules prior to 
    # executing/spawning any process that depends
    # on the LKM

   udhcpc -i eth0
}

stop() {
    # code to stop app comes here 
    # example: killproc program_name
    # Kill all the process started in start() function
    # remove any LKM inserted using insmod in start()
   :
}

case "$1" in 
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart)
       stop
       start
       ;;
    status)
       # code to check status of app comes here 
       # example: status program_name
       ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0 
