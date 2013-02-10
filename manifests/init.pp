# Class: mysql
#
# This module manages MySQL.
#
# Parameters:
#
#   [*root_password*] - Password for root user
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
class mysql (
  $root_password = undef
) inherits mysql::params {
  class { 'mysql::package': 
    notify => Class['mysql::service'],
  }

  class { 'mysql::config':
    root_password => $root_password,
    notify        => Class['mysql::service'],
  }

  class { 'mysql::service': }
}