# Class: icinga::server::service
#
# This class manges the daemons/services for the server components of Icinga.
#
# Parameters:

class icinga::server::service {

  include icinga::params
  
  case $operatingsystem {
    #Daemon names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {}
    #Daemon names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $service_names = ["icinga", "ido2db"]
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }
  
  #Service resource that references the daemon names we defined above:
  service {$service_names:
    ensure => running,
  }

}