# Define icinga::server::user
#
# This class sets up users for the Icinga classic web UI. It uses the httpauth module from:
# https://github.com/jamtur01/puppet-httpauth
#
# Parameters:
# * $username = The username for the Icinga classic web user
# * $password = The user's password
#

define icinga::server::user (
  $username     = $name,
  $password     = undef,
) {

  #Use the httpauth module to do most of the heavy lifting:
  httpauth { $username:
    file      => '/etc/icinga/htpasswd.users',
    password  => $password,
    realm     => 'realm',
    mechanism => basic,
    ensure    => present,
    require   => Class['icinga::server::config'],
    notify    => File['/etc/icinga/htpasswd.users'],
  }



}