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

To allow Icinga Web users access to view, trigger and schedule host and service checks, add their username to the `server_users` parameter of the `::server` class:

<pre>
  class { 'icinga::server':
    server_db_password => 'password',
    server_users => ['icingaadmin', 'nick2', 'nick'],
  }
</pre>

###Clients

Coming soon...

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