define icinga::server::user (
  $username     = $name,
  $password     = undef,
) {

  httpauth { $username:
    file      => '/etc/icinga/htpasswd.users',
    password  => $password,
    realm     => 'realm',
    mechanism => basic,
    ensure    => present,
  }

}