# Class: icinga
#
# This module manages Icinga. This class is just the entry point for Puppet to get at the
# subclass(es).
#

class icinga {
  include icinga::server
}

