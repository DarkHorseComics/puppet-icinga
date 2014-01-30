# Class: icinga::server::params
#
# This class manges the parameters used to configure the server components of Icinga.
#
# Parameters: See the inline comments.

class icinga::params {
 
 
  ##############################
  # Configuration parameters
  ##############################
 
  ##################
  # Database settings
  
  #The server_db_password is left blank deliberately.
  #Since putting database passwords in your manifests/modules is a bad idea,
  #you should get the DB password via a Hiera lookup.
  $server_db_type       = 'pgsql'
  $server_db_host       = 'localhost'
  $server_db_port       = '5432'
  $server_db_user       = 'icingaidoutils'
  $server_db_password   = undef
  $server_db_name       = 'icinga'
  
  ##################
  # Icinga settings
  
  $icingaadmin_password = 'horsebatterystaple'
  
  case $operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {}
    #File and template variable names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $etc_default_template = "icinga/ubuntu_etc-default-icinga.erb"
      $ido2db_cfg_template  = "icinga/ubuntu_ido2db.cfg.erb"
      $htpasswdusers_owner  = "www-data"
      $htpasswdusers_group = "www-data"
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }
  
  ##################
  # Package parameters



}