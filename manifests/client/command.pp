# Define icinga::client::command

define icinga::client::command (
  $command_name       = $name,
  $nrpe_plugin_liddir = $icinga::params::nrpe_plugin_liddir,
  $nrpe_plugin_name   = undef,
  $nrpe_plugin_args   = undef,
) {

  file { "/etc/nagios/nrpe.d/${command_name}.cfg":
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/nrpe_command.cfg.erb'),
    require => Package[$icinga::params::icinga_client_packages],
    notify  => Service[$icinga::params::nrpe_daemon_name]
  }
  
  
}