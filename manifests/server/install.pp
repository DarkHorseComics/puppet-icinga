# Class: icinga::server::install
#
# This class installs the server components of Icinga.

class icinga::server::install {
  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the 
  #class left is applied before the class on the right and that it also refreshes the 
  #class on the right.
  #
  #Here, we're setting up the package repos first, then installing the packages:
  include icinga::params
  class{'icinga::server::install::repos':} ~> class{'icinga::server::install::packages':} -> Class['icinga::server::install']

}

##################
#Package repositories
##################
class icinga::server::install::repos { 

  case $operatingsystem {
    #Add the yum repo for Red Had and CentOS systems:
    'RedHat', 'CentOS': {}
    #Add the Icinga PPA for Debian/Ubuntu systems:
    /^(Debian|Ubuntu)$/: { 
      #Include the apt module's base class so we can...
      include apt
      #...use the module to add the Icinga PPA:
      apt::ppa { 'ppa:formorer/icinga': }
    }
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") } 
  }

}

##################
#Packages
##################
class icinga::server::install::packages {

  #Pick the right list of packages
  case $operatingsystem {
    #Red Hat/CentOS systems:
    'RedHat', 'CentOS': {} 
    #Debian/Ubuntu systems: 
    /^(Debian|Ubuntu)$/: {}
    #Fail if we're on any other OS:
    default: { fail("${operatingsystem} is not supported!") } 
  }

}