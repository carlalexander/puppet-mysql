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
class mysql::config (
  $root_password = undef
) inherits mysql::params {
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

  if ($root_password != undef and $root_password != '') {
    exec { 'set-mysql-root-password':
      unless  => "/usr/bin/mysqladmin status -uroot -p${root_password}",
      command => "/usr/bin/mysqladmin -uroot password ${root_password}",
    }
  }
}