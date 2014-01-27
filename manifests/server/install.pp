# Class: icinga::server::install
#
# This class installs the server components of Icinga.
#
# Parameters:


#Packages

  

  #case statement goes here for selecting the package names based on the OS.

class icinga::server::install {
  #Apply our classes in the right order. Use the squiggly arrows (~>) to ensure that the 
  #class left is applied before the class on the right and that it also refreshes the 
  #class on the right.
  #
  #Here, we're setting up the package repos first, then installing the packages:
  class{'icinga::server:install::repos':} ~> class{'icinga::server:install::packages':} -> Class['icinga::server:install']


}

class icinga::server::install::repos { 

  ##################
  #Package repositories
  ##################
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

class icinga::server::install::packages { }