# Class: icinga::server::config
#
# This class manages configuration for Icinga servers.
#
# Parameters:

class icinga::server::config {

  include icinga::params
  
  #Create an htpasswd entry for the 'icingaadmin' user. This requires the httpauth module
  #to be installed: https://github.com/jamtur01/puppet-httpauth
  httpauth { 'icingaadmin':
    file      => '/etc/icinga/passwd',
    password  => $icinga::params::icingaadmin_password,
    realm     => 'realm',
    mechanism => basic,
    ensure    => present,
  }

}