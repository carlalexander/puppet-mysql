# Class: mysql::service
#
# This module manages MySQL service management
#
# Parameters:
#
# There are no default parameters for this class.
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# This class file is not called directly
class mysql::service {
  service { 'mysql':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}