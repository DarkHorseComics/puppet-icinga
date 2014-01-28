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

  case $operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {}
    #File and template variable names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $etc_default_template = "icinga/ubuntu_etc-default-icinga.erb"
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }
}