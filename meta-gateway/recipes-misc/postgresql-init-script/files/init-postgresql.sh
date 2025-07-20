#!/bin/bash
# description: Description comes here....

# Source function library.
. /etc/init.d/functions

PGDIR=/var/lib/postgresql
PGHBA=$PGDIR/data/pg_hba.conf
PGCONF=$PGDIR/data/postgresql.conf

STAMP_CFG=$PGDIR/.stamp_cfg
STAMP_DBS=$PGDIR/.stamp_dbs
PGEXE=/etc/init.d/postgresql-server

do_init_postgresql() {
   if [ ! -f $STAMP_CFG ]; then
      if [ -d $PGDIR ]; then
         rm -rf $PGDIR
      fi

      postgresql-setup initdb

      # set port
      echo "port = 5432" >> $PGDIR/data/postgresql.conf

      # prepend to the file: allow any local (socket) connections
      sed -i 's/^local[[:space:]]\+all[[:space:]]\+all[[:space:]]\+peer/local all all trust/' $PGHBA

      # remove default entries
      sed -i '/^host[[:space:]]\+all[[:space:]]\+all[[:space:]]\+127\.0\.0\.1\/32[[:space:]]\+ident/d' $PGHBA
      sed -i '/^host[[:space:]]\+all[[:space:]]\+all[[:space:]]\+::1\/128[[:space:]]\+ident/d' $PGHBA

      # in development image, listen on all interfaces and trust all connections (local and remote)
      if [ -f "/etc/.ha-debug-image" ]; then
         echo "listen_addresses = '*'" >> $PGCONF

         # allow any external (IP) connection
         echo "host all all 0.0.0.0/0 trust" >> $PGHBA
         echo "host all all ::0/0 trust" >> $PGHBA
      else
         echo "listen_addresses = 'localhost'" >> $PGCONF

         echo "host all all samenet trust" >> $PGHBA
         echo "host all all samehost trust" >> $PGHBA
      fi

      # mark init script as executed
      touch $STAMP_CFG
   fi
}

do_init_postgresql_dbs() {
   if [ ! -f $STAMP_DBS ]; then
      while ! /usr/bin/pg_isready; do
         sleep 1
      done

      /usr/bin/psql -U postgres -c "CREATE USER caniot WITH PASSWORD 'caniot';"
      /usr/bin/psql -U postgres -c "CREATE DATABASE caniot WITH OWNER caniot;"

      touch $STAMP_DBS
   fi
}

start() {
   do_init_postgresql
   $PGEXE start
   do_init_postgresql_dbs
}

reset() {
   $PGEXE stop
   rm $STAMP_CFG
   rm $STAMP_DBS
   start
   $PGEXE start
}

case "$1" in 
    start)
       start
       ;;
    reset)
       stop
       start
       ;;
    *)
       echo "Usage: $0 {start|reset}"
esac

exit 0 
