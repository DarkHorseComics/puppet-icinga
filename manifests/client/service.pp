# Class: icinga::client::service
#
# This class manges the daemons/services for the server components of Icinga.
#
# Parameters:

class icinga::client::service {

  include icinga::params

  #Service resource for NRPE.
  #This references the daemon name we defined in the icinga::params class based on the OS:
  service {$icinga::params::nrpe_daemon_name:
    ensure    => running,
    enable    => true, #Enable the service to start on system boot
    subscribe => Class['icinga::client::config'], #Subscribe to the client::config class so the service gets restarted if any config files change
  }

}