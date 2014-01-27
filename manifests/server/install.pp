# Class: icinga::server::install
#
# This class installs the server components of Icinga.
#
# Parameters:


#Packages

  

  #case statement goes here for selecting the package names based on the OS.

class icinga::server::install {

  #case statement goes here for adding the right package repo based on the OS.
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