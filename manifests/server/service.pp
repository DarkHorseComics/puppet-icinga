# Class: icinga::server::service
#
# This class manges the daemons/services for the server components of Icinga.
#
# Parameters:

class icinga::server::service {

  include icinga::params
  
  #Service resource that references the daemon names we defined above:
  service {$icinga::params::server_service_names:
    ensure    => running,
    subscribe => Class['icinga::server::config'],
  }

}