#Changelog
- - -

###v0.4.2

* [GH-2](https://github.com/nickchappell/puppet-icinga/tree/fix/GH2/missing-12.04-packages): Fixed an issue where the `nagios-plugins-common` and `nagios-plugins-contrib` packages were not available on Ubuntu 12.04 LTS, but the module tried to install them anway

###v0.4.1

* Fixed a problem where, out-of-the-box the Icinga install wouldn't work because I commented out some required object definitions in the `.cfg` file templates
* Added object creation examples to the `README`

###v0.4

* Added client installation and setup
* Added templates for managing the built-in Icinga `.cfg` files

###v0.0.3

* Added a template for `cgi.cfg`

###v0.0.2

* Moved some options and logic for OS-specific parameters to `params.pp`

###v0.0.1

* Basic installation and functionality for Ubuntu systems is complete