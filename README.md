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

##Usage

Coming soon...

##Implementation

Coming soon...

###Classes and Defined Types

####Class: `icinga`

Coming soon...

###Templates

Coming soon...

##Limitations

Coming soon...

##Copyright and License

Coming soon...