# Class: mysql
#
# This module manages MySQL.
#
# Parameters:
#
# There are no default parameters for this class. All module parameters are managed
# via the mysql::params class
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# The module works with sensible defaults:
#
# node default {
#   include mysql
# }
class mysql inherits mysql::params {
  class { 'mysql::package': 
    notify => Class['mysql::service'],
  }

  class { 'mysql::config': }

  class { 'mysql::service': }
}