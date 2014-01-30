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
    file      => '/etc/icinga/htpasswd.users',
    password  => $icinga::params::icingaadmin_password,
    realm     => 'realm',
    mechanism => basic,
    ensure    => present,
  }

  file { '/etc/icinga/htpasswd.users':
    path    => '/etc/icinga/htpasswd.users',
    ensure  => file,
    owner   => $icinga::params::htpasswdusers_owner,
    group   => $icinga::params::htpasswdusers_group,
    mode    => '644',
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
  }

  #A folder for command definitions:
  file { '/etc/icinga/objects/commands':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for contact definitions:
  file { '/etc/icinga/objects/contacts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for host definitions:
  file { '/etc/icinga/objects/hosts':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for hostgroup definitions:
  file { '/etc/icinga/objects/hostgroups':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for service definitions:
  file { '/etc/icinga/objects/services':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for service group definitions:
  file { '/etc/icinga/objects/servicegroups':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

  #A folder for template definitions:
  file { '/etc/icinga/objects/templates':
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
  }

}