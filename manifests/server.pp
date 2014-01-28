
#Files to Puppetize:

#Ubuntu

#/etc/icinga/ido2db.cfg
#Perms are -rw------- nagios nagios

# copied a file with the command below, but I could template it
# cp /usr/share/doc/icinga-idoutils/examples/idoutils.cfg-sample /etc/icinga/modules/idoutils.cfg
# -rw-r--r-- 1 root root 1.3K Jan 23 22:22 /etc/icinga/modules/idoutils.cfg


#set IDO2DB to yes in /etc/icinga/default
#Perms are -rw-r--r-- 1 root root 340 Jan 23 22:38 /etc/default/icinga

#/etc/icinga/idomod.cfg
#-rw-r--r-- 1 root root 8.7K Nov  6 19:49 /etc/icinga/idomod.cfg

#/etc/icinga/modules/idoutils.cfg
#-rw-r--r-- 1 root root 1.3K Jan 23 22:22 /etc/icinga/modules/idoutils.cfg

#/etc/icinga/icinga.cfg
#Perms: -rw-r--r-- 1 root root 51K Jan 23 22:40 /etc/icinga/icinga.cfg
  #Things I set:
    # check_external_commands=1


#Exec resource commands to run:

#dpkg-statoverride --update --add nagios www-data 2710 /var/lib/icinga/rw; touch /etc/icinga/exec-override-icinga-rw-www_is_complete

#dpkg-statoverride --update --add nagios nagios 751 /var/lib/icinga; touch touch /etc/icinga/override-icinga-lib-www_is_complete

#load DB schema

# su postgres -c 'psql -d icinga < /usr/share/dbconfig-common/data/icinga-idoutils/install/pgsql'

class icinga::server (
  $server_db_type       = icinga::params::server_db_type,
  $server_db_host       = icinga::params::server_db_host,
  $server_db_port       = icinga::params::server_db_port,
  $server_db_user       = icinga::params::server_db_user,
  $server_db_password   = icinga::params::server_db_password,
  $server_db_name       = icinga::params::server_db_name,

) {
  include icinga::params
  include icinga::server::install
  include icinga::server::config
  include icinga::server::service
}
