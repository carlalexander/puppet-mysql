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
  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  if ($root_password == undef or $root_password == '') {
    fail('You must set a root password')
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

  exec { 'mysql-set-root-password':
    command => "mysqladmin -uroot password ${root_password}",
    unless  => "mysqladmin status -uroot -p${root_password}",
  }

  exec { 'mysql-drop-test-database'
    command     => "mysql -uroot -p${root_password} -e \"DROP DATABASE test;\"",
    refreshonly => true,
    subscribe   => Exec['mysql-set-root-password'],
  }

  exec { 'mysql-disable-anonymous-user'
    command     => "mysql -uroot -p${root_password} -e \"DROP USER ''@localhost;\"",
    refreshonly => true,
    subscribe   => Exec['mysql-set-root-password'],
  }
}