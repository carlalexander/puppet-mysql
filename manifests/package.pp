# Class: mysql::package
#
# This module manages MySQL package installation
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
class mysql::package {
  package { 'mysql-server':
    ensure => latest,
  }
}