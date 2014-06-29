# Class: icinga::client::install
#
# This subclass installs NRPE and Nagios plugin packages on Icinga client machines.
#

class icinga::client::install
inherits icinga::params {
  
  #Apply our subclasses in the right order. Use the squiggly arrows (~>) to ensure that the 
  #class left is applied before the class on the right and that it also refreshes the 
  #class on the right.
  class {'icinga::client::install::repos':} ~>
  class {'icinga::client::install::packages':} ~>
  class {'icinga::client::install::execs':}
}

##################
#Package repositories
##################
class icinga::client::install::repos {

  #repository resources here

}

##################
# Packages
##################
class icinga::client::install::packages {

  #Install the packages we specified in the ::params class:
  package {$icinga::params::icinga_client_packages:
    ensure   => installed,
    provider => $icinga::params::package_provider,
  }

}


##################
# Execs
##################
class icinga::client::install::execs { 

  #exec resources here

}