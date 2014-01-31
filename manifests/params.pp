# Class: icinga::server::params
#
# This class manges the parameters used to configure the server components of Icinga.
#
# Parameters: See the inline comments.

class icinga::params {
 
 
  ##############################
  # Configuration parameters
  ##############################
 
  ##################
  # Database settings
  #The server_db_password is left blank deliberately.
  #Since putting database passwords in your manifests/modules is a bad idea,
  #you should get the DB password via a Hiera lookup.
  $server_db_type       = 'pgsql'
  $server_db_host       = 'localhost'
  $server_db_port       = '5432'
  $server_db_user       = 'icingaidoutils'
  $server_db_password   = undef
  $server_db_name       = 'icinga'
  
  ##################
  # Icinga server settings
  #The default icingaadmin password.
  #Default value from: https://xkcd.com/936/
  $icingaadmin_password = 'horsebatterystaple'
  
  case $operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {}
    #File and template variable names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $etc_default_template = "icinga/ubuntu_etc-default-icinga.erb"
      $ido2db_cfg_template  = "icinga/ubuntu_ido2db.cfg.erb"
      $htpasswdusers_owner  = "www-data"
      $htpasswdusers_group  = "www-data"
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##################
  # Icinga client settings 
  
  $nrpe_debug_level        = '0'
  #in seconds:
  $nrpe_command_timeout    = '60'
  #in seconds:
  $nrpe_connection_timeout = '300'
   
  case $operatingsystem {
    #File and template variable names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {
      $nrpe_config_basedir = "/etc/nagios"
      $nrpe_pid_file_path  = "/var/run/nrpe/nrpe.pid"
      $nrpe_user           = "nrpe"
      $nrpe_group          = "nrpe"
    }
    #File and template variable names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $nrpe_config_basedir  = "/etc/nagios"
      $nrpe_pid_file_path   = "/var/run/nagios/nrpe.pid"
      $nrpe_user            = "nagios"
      $nrpe_group           = "nagios"
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

  ##################
  # Icinga web parameters
  #How often to automatically refresh the web UI, in seconds: 
  $web_ui_refresh_rate = "90"
  #How many results in large lists of hosts, services or check results to display per page: 
  $web_ui_results_per_page_limit = "200"
  #The character to use as a delimiter in CSV files that are exported:
  $exported_csv_delimiter_char   = ";"

  ##################
  # Package parameters
  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {
      #Pick the right DB lib package name based on the database type the user selected:
      case $icinga::params::server_db_type {
        'mysql': { $lib_db_package = 'icinga-idoutils-libdbi-mysql'}
        'pgsql': { $lib_db_package = 'icinga-idoutils-libdbi-pgsql'}
        default: { fail("${icinga::params::server_db_type} is not supported!") }
      }
      
      #Pick the right pacakage provider:
      $package_provider = 'yum'
      #Finally, pick the right list of packages:
      $icinga_client_packages = ["nrpe", "nagios-plugins-nrpe", "nagios-plugins-all"]
    } 
    #Debian/Ubuntu systems: 
    /^(Debian|Ubuntu)$/: {
      #Pick the right DB lib package name based on the database type the user selected:
      case $icinga::params::server_db_type {
        'mysql': { $lib_db_package = 'libdbd-mysql'}
        'pgsql': { $lib_db_package = 'libdbd-pgsql'}
        default: { fail("${icinga::params::server_db_type} is not supported!") } 
      }
      #Pick the right pacakage provider:
      $package_provider = 'apt'
      #Finally, pick the right list of packages:
      $icinga_server_packages = ["icinga", "icinga-doc", "icinga-idoutils", "nagios-nrpe-server", "nagios-plugins-basic", "nagios-plugins-common", "nagios-plugins-standard", "nagios-snmp-plugins", $lib_db_package]
      $icinga_client_packages = ["nagios-nrpe-server", "nagios-plugins-basic", "nagios-plugins-common", "nagios-plugins-standard", "nagios-snmp-plugins"]
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") } 
  }

  ##################
  # Service parameters
  case $operatingsystem {
    #Daemon names for Red Had/CentOS systems:
    'RedHat', 'CentOS': {
      $nrpe_daemon_name = 'nrpe'
    }
    #Daemon names for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: {
      $server_service_names = ["icinga", "ido2db"]
      $nrpe_daemon_name     = 'nagios-nrpe-server'
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") }
  }

}