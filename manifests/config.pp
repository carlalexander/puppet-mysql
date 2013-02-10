# Class: mysql::config
#
# This module manages MySQL bootstrap and configuration
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
class mysql::config inherits mysql::params {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  file { $mysql::config::backup_dir:
    ensure => directory,
  }

  file { $mysql::config::conf_dir:
    ensure => directory,
  }

  file { "${mysql::config::conf_dir}/my.cnf":
    ensure  => file,
    content => template('mysql/my.cnf.erb'),
    require => File[$mysql::config::conf_dir]
  }
}