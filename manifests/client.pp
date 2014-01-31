# Class: icinga::client
#
# This subclass manages Icinga client components. This class is just the entry point for Puppet to get at the
# icinga::client:: subclasses.
#

class icinga::client (

  $nrpe_listen_port        = $icinga::params::nrpe_listen_port,
  $nrpe_debug_level        = $icinga::params::nrpe_debug_level,
  $nrpe_log_facility       = $icinga::params::nrpe_log_facility,
  $nrpe_command_timeout    = $icinga::params::nrpe_command_timeout,
  $nrpe_connection_timeout = $icinga::params::nrpe_connection_timeout

) inherits icinga::params {
  
  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the 
  #class left is applied before the class on the right and that it also refreshes the 
  #class on the right.
  class {'icinga::client::install':} ~>
  class {'icinga::client::config':} ~>
  class {'icinga::client::service':}
}
