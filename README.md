#puppet-icinga
> A simple Puppet module to install [Icinga](http://www.icinga.org/)

> [github.com/nickchappell/puppet-icinga](https://github.com/nickchappell/puppet-icinga)
- - -

####Table of Contents

1. [Overview](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
5. [Implementation - An under-the-hood peek at what the module is doing](#implementation)
    * [Classes and Defined Types](#classes-and-defined-types)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
8. [Release Notes - Notes on the most recent updates to the module](#release-notes)

##Overview

This module installs [Icinga](http://icinga.org/), a server monitoring tool.

##Module Description

Coming soon...

##Setup

###Requirements

####Puppet module requirements

This module requires the [httpauth](https://github.com/jamtur01/puppet-httpauth) module. It uses the type provided by the module to create users in the `htpasswd` file that Icinga uses for authentication.

If you don't already have it in your collection of modules, install it from the [Puppet Forge](https://forge.puppetlabs.com/):

<pre>
puppet module install jamtur01/httpauth
</pre>

####Other requirements

**Database**

Icinga requires a database, either local or remote.

By default, the Debian/Ubuntu Icinga packages themselves will install MySQL, create a database and tables, an Icinga database user and will set up Icinga with the connection settings.

This module defaults to using Postgres. Like MySQL, the Icinga packages will install and configure Postgres for Icinga, including creating the database, tables and user.

If you would like to set up your own database, either of the Puppet Labs [MySQL](https://github.com/puppetlabs/puppetlabs-mysql) or [Postgres](https://github.com/puppetlabs/puppetlabs-postgresql) modules can be used. 

The example below shows the Puppet Labs Postgres module being used to install Postgres and create a database and database user for Icinga:

<pre>
  class { 'postgresql::server': }

  postgresql::server::db { 'icinga':
    user     => 'icingaidoutils',
    password => postgresql_password('icingaidoutils', 'password'),
  }
</pre>

For production use, you'll probably want to get the database password via a [Hiera lookup](http://docs.puppetlabs.com/hiera/1/puppet.html) so the password isn't sitting in your site manifests in plain text.

To configure Icinga with the password you set up for the Postgres Icinga user, use the `server_db_password` parameter (shown here with a Hiera lookup):

<pre>
  class { 'icinga::server':
    server_db_password => hiera('icinga_db_password_key_here')
  }
</pre>

**Webserver**

Icinga requires a web server for the web UI. The Icinga packages automatically install Apache 2 and set up Icinga to be served by Apache at the [/icinga](/icinga) path of your Icinga server (eg. [http://icinga.company.com/icinga](http://icinga.company.com/icinga)).

This module currently does not set up any Apache virtual host for Icinga.

##Usage

###Server

To set up an Icinga monitoring server, first set up a Postgres database:

<pre>
  class { 'postgresql::server': }

  postgresql::server::db { 'icinga':
    user     => 'icingaidoutils',
    password => postgresql_password('icingaidoutils', 'password'),
  }
</pre>

To set up Icinga itself, include the `icinga::server` class with a `server_db_password` parameter. Make sure `server_db_password` matches what you set above when you created the database.

<pre>
  class { 'icinga::server':
    server_db_password => 'password',
  }
</pre>

To add Icinga Web users, use the `icinga::server::user` defined type:

<pre>
  icinga::server::user { 'nick2':
    password => 'password1', 
  }
</pre>

In production use, you'll probably want to do a Hiera lookup of the plaintext password instead of adding it to your site manifest.

**Note:** Because the `htpasswd` Icinga uses for authentication won't be created until you install Icinga, you'll have to declare the `icinga::server` class on a node to install Icinga first before you can delcare any `icinga::server::user` resources. 

If you have **both** `icinga::server` and `icinga::server::user` declared in your site manifest, you'll have to do 2 Puppet runs initially, one to install Icinga and create the `htpasswd` file and another one to populate the `icinga::server::user` in that file.

To allow Icinga Web users access to view, trigger and schedule host and service checks, add their username to the `server_users` parameter of the `::server` class:

<pre>
  class { 'icinga::server':
    server_db_password => 'password',
    server_users => ['icingaadmin', 'nick2', 'nick'],
  }
</pre>

###Clients

####Distributing plugin scripts

To disbribute plugin scripts to your client machines, add the script file to your Puppet master and use the `icinga::client::plugin` defined type:

<pre>
icinga::client::plugin { 'check_omreport_raid':
  source_file => 'puppet:///modules/icinga/check_omreport_raid.pl',
}
</pre>

For `source_file`, you can use any format of file URL that Puppet will understand. See the [Puppet file type reference](http://docs.puppetlabs.com/references/3.stable/type.html#file-attribute-source) for more info.

###Usage - Creating an object hierarchy

This module will keep a few of the defined objects that come with an out-of-the-box Icinga install:

* a `root` contact
* an `admins` contact group
* a `generic-service` service definition template
* a `generic-host` host definition template
* a `localhost` host definition for the machine that the `icinga::server` class was applied to
* A few services for `localhost`, like IDO2DB, current load average, disk usage, users on the system, etc.
* Timeperiods for 24x7, 9am-5pm M-F work hours, 5pm-8am Sat./Sun. non-work hours and a 'never' time period

For the rest of your object hierarchy, you can define objects with the built-in Puppet Nagios types. Just set the `target =>` parameter to point to one of the object type subdirectories in `/etc/icinga/objects`, along with a filename. The `icinga::server::config` class makes directories in `/etc/icinga/objects` for:

* commands
* contactgroups
* contacts
* hostdependencies
* hostescalations
* hostextinfo
* hostgroups
* hosts
* servicedependencies
* serviceescalations
* servicegroups
* services
* templates
* timeperiods

As a workaround for bug [PUP-1327](https://tickets.puppetlabs.com/browse/PUP-1327), the `icinga::server::config` class sets the mode of any files created in `/etc/icinga/bojects` to **755** so the Icinga daemon will be able to read them.

####Using the built-in Puppet Nagios types

Below are some examples for how to use the built-in Nagios types with this module. To make any of these a template you can inherit from, add `use => '0'` as a parameter.

**Host definitions**

<pre>
@@nagios_host { $::fqdn:
  address => $::ipaddress,
  check_command => 'check_ping!100.0,20%!500.0,60%',
  use => 'generic-host',
  hostgroups => ['ssh_servers'], #Include this machine in the ssh_servers hostgroup
  target => "/etc/icinga/objects/hosts/host_${::fqdn}.cfg",
}
</pre> 

**Note:** The above code is actually put in the site manifest for the **client** machine that's being monitored, not the Icinga server. It's exported by the machine with the `@@` sigils. See [Exported Resources with Nagios](http://docs.puppetlabs.com/guides/exported_resources.html#exported-resources-with-nagios) for more details.

On the site manifest for the Icinga server, add:

<pre>
#Collect all @@nagios_host resources from PuppetDB that were exported by other machines:
Nagios_host &lt;&lt;||&gt;&gt; { }
</pre>

**Hostgroup definitions**

If you have a `hostgroups =>` parameter in your `@@nagios_host` definitions, you can create the actual hostgroup itself:

<pre>
nagios_hostgroup { 'ssh_servers':
  ensure         => present,
  target         => '/etc/icinga/objects/hostgroups/ssh_servers.cfg',
  hostgroup_name => 'ssh_servers',
  alias          => 'SSH servers',
}
</pre>

**Command definitions**

<pre>
#Define this command first so that any other services can use it as part of their check commands:
nagios_command { 'check_nrpe':
  command_name => 'check_nrpe',
  ensure       => present,
  command_line => '$USER1$/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -t 20',
  target       => "/etc/icinga/objects/commands/check_nrpe.cfg",
}
</pre>

**Service definitions**

For a network-reachable service that can be checked directly from the Icinga server:

<pre>
#Service definition for checking SSH
nagios_service { 'check_ssh_service':
  ensure => present,
  target => '/etc/icinga/objects/services/check_ssh_service.cfg',
  use => 'generic-service',
  hostgroup_name => 'ssh_servers',
  service_description => 'SSH',
  check_command => 'check_ssh',
}
</pre>

For a non-network-checkable service that requires the use of NRPE on the machine being monitored (this uses the `check_nrpe` command defined in the command example farther above):

<pre>
#check_zombie_procs
nagios_service { 'check_zombie_procs':
  ensure => present,
  target => '/etc/icinga/objects/services/check_zombie_procs_service.cfg',
  use => 'generic-service',
  hostgroup_name => 'ssh_servers',
  service_description => 'Zombie procs',
  check_command => 'check_nrpe!check_zombie_procs',
}
</pre>

On the machine being monitored, you would need a matching NRPE command definition like this:

<pre>
#check_zombie_procs
icinga::client::command { 'check_zombie_procs':
  nrpe_plugin_name => 'check_procs',
  nrpe_plugin_args => '-w 5 -c 10 -s Z',
}
</pre>


##Implementation

Coming soon...

###Classes and Defined Types

####Class: `icinga`

Coming soon...

###Templates

Coming soon...

##Limitations

Currently, Red Hat/CentOS based systems are not supported.

Currently, remote databases are not supported.

##Copyright and License

Coming soon...
