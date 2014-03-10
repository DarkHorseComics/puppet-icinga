# Class: icinga::server
#
# This subclass manages Icinga server components. This class is just the entry point for Puppet to get at the
# icinga::server:: subclasses.
#

class icinga::server (
  $server_db_type       = $icinga::params::server_db_type,
  $server_db_host       = $icinga::params::server_db_host,
  $server_db_port       = $icinga::params::server_db_port,
  $server_db_user       = $icinga::params::server_db_user,
  $server_db_password   = $icinga::params::server_db_password,
  $server_db_name       = $icinga::params::server_db_name,
  $server_users         = $icinga::params::server_users

) inherits icinga::params {
  
  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the 
  #class left is applied before the class on the right and that it also refreshes the 
  #class on the right.
  class {'icinga::server::install':} ~>
  class {'icinga::server::config':} ~>
  class {'icinga::server::service':}
}
