# Define icinga::client::command
#
# This defined type creates NRPE command definitions on machines running NRPE.
#
# Parameters:
# * $command_name = What NRPE will know the command as; this defaults to the title of the resource
# * $nrpe_plugin_liddir = The directory where the NRPE plugins themselves live
# * $nrpe_plugin_name = The name of the plugin the command will run
# * $nrpe_plugin_args = The arguments to pass to the plugin. This may be optional, 
#                       depending on the plugin and whether it expects any arguments or parameters

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