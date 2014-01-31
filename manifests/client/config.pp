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
  
  #The folder that will hold our command definition files:
  file { '/etc/nagios/nrpe.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #File resource for /etc/nagios/nrpe.cfg
  file { '/etc/nagios/nrpe.cfg':
    path    => '/etc/nagios/nrpe.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/nrpe.cfg.erb'),
  }

}
