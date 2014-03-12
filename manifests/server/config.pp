# Class: icinga::server::config
#
# This class manages configuration for Icinga servers.
#
# Parameters:

class icinga::server::config {

  include icinga::params

  file { '/etc/icinga/htpasswd.users':
    path    => '/etc/icinga/htpasswd.users',
    ensure  => file,
    owner   => $icinga::params::htpasswdusers_owner,
    group   => $icinga::params::htpasswdusers_group,
    mode    => '644',
  }

  #The 'icingaadmin' user
  icinga::server::user { 'icingaadmin':
    password => $icinga::params::icingaadmin_password,
  }

  #/etc/default/icinga resource
  file { '/etc/default/icinga':
    path    => '/etc/default/icinga',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template($icinga::params::etc_default_template),
  }

  #/etc/icinga/icinga.cfg resource
  file { '/etc/icinga/icinga.cfg':
    path    => '/etc/icinga/icinga.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/icinga.cfg.erb'),
  }

  #/etc//etc/icinga/ido2db.cfg
  file { '/etc/icinga/ido2db.cfg':
    path    => '/etc/icinga/ido2db.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '600',
    content => template($icinga::params::ido2db_cfg_template),
  }
  
  #/etc/icinga/modules/idoutils.cfg
  file { '/etc/icinga/modules/idoutils.cfg':
    path    => '/etc/icinga/modules/idoutils.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/idoutils.cfg.erb'),
  }

  #/etc/icinga/idomod.cfg
  file { '/etc/icinga/idomod.cfg':
    path    => '/etc/icinga/idomod.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/idomod.cfg.erb'),
  }
  
  #/etc/icinga/cgi.cfg
  #This file sets up things for the classic CGI-based web UI.
  file { '/etc/icinga/cgi.cfg':
    path    => '/etc/icinga/cgi.cfg',
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '644',
    content => template('icinga/cgi.cfg.erb'),
  }

  #This folder is the base of where all of Icinga's objects are kept:
  file { '/etc/icinga/objects':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for command definitions:
  file { '/etc/icinga/objects/commands':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for contact definitions:
  file { '/etc/icinga/objects/contacts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for contact group definitions:
  file { '/etc/icinga/objects/contactgroups':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for host definitions:
  file { '/etc/icinga/objects/hosts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for host dependency definitions:
  file { '/etc/icinga/objects/hostdependencies':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for host escalation definitions:
  file { '/etc/icinga/objects/hostescalations':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for host extended info definitions:
  file { '/etc/icinga/objects/hostextinfo':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for hostgroup definitions:
  file { '/etc/icinga/objects/hostgroups':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for image icon files:
  file { '/etc/icinga/objects/icons':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for service definitions:
  file { '/etc/icinga/objects/services':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for service dependency definitions:
  file { '/etc/icinga/objects/servicedependencies':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for service escalation definitions:
  file { '/etc/icinga/objects/serviceescalations':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for service extended info definitions:
  file { '/etc/icinga/objects/serviceextinfo':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for service group definitions:
  file { '/etc/icinga/objects/servicegroups':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for template definitions:
  file { '/etc/icinga/objects/templates':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

  #A folder for timeperiod definitions:
  file { '/etc/icinga/objects/timeperiods':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    recurse => true,
  }

#The rest of these file resources are actually just commented-out copies of the .cfg files
#that are included out of the box in Icinga's default install. The originals are getting
#overwritten by these commented out copies so that any Nagios configs declared by the 
#user with Puppet's Nagios types don't conflict if they happen to have the same name.
#The 2 exceptions are the check for ido2db on the Icinga server and the localhost service
#definitions that monitor basic sergices on the Icinga server. Because those services are
#necessary for Icinga to function, we'll keep the uncommented versions.

  #File resource for /etc/icinga/objects/contacts_icinga.cfg.erb
  file {'/etc/icinga/objects/contacts_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/contacts_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/extinfo_icinga.cfg.erb
  file {'/etc/icinga/objects/extinfo_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/extinfo_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/generic-host_icinga.cfg.erb
  file {'/etc/icinga/objects/generic-host_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/generic-host_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/generic-service_icinga.cfg.erb
  file {'/etc/icinga/objects/generic-service_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/generic-service_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/hostgroups_icinga.cfg.erb
  file {'/etc/icinga/objects/hostgroups_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/hostgroups_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/ido2db_check_proc.cfg.erb
  file {'/etc/icinga/objects/ido2db_check_proc.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/ido2db_check_proc.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/localhost_icinga.cfg.erb
  file {'/etc/icinga/objects/localhost_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/localhost_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/services_icinga.cfg.erb
  file {'/etc/icinga/objects/services_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/services_icinga.cfg.erb'),
  }

  #File resource for /etc/icinga/objects/timeperiods_icinga.cfg.erb
  file {'/etc/icinga/objects/timeperiods_icinga.cfg':
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => template('icinga/timeperiods_icinga.cfg.erb'),
  }
  
  #If we're on Ubuntu/Debian, put a check_nrpe.cfg in place that comments out the check_nrpe
  #command definition so that we can define our own and not have them collide with each other.
  case $operatingsystem {
    /^(Debian|Ubuntu)$/: { 
      file {'/etc/nagios-plugins/config/check_nrpe.cfg':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '755',
        content => template('icinga/etc_nagios-plugins_config_check_nrpe.cfg.erb'),
      }
      
      file {'/etc/nagios-plugins/config/ssh.cfg':
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        mode    => '755',
        content => template('icinga/etc_nagios-plugins_config_ssh.cfg.erb'),
      }
    }
  }

}