# Class: icinga::client::config
#
# This subclass configures Icinga clients.
#

class icinga::client::config 
inherits icinga::params {
  
  #config resources here
 
  #The NRPE configuration base directory:
  file { $nrpe_config_basedir:
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

}
