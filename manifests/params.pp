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
  
  ##################
  # Package parameters



}