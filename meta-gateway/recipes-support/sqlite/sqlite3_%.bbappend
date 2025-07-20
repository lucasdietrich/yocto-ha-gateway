# sqlx-sqlite crate depends on "unlock_notify" feature of crate 
# libsqlite3-sys which uses 'sqlite3_unlock_notify()' symbol.
CFLAGS += " -DSQLITE_ENABLE_UNLOCK_NOTIFY=1"