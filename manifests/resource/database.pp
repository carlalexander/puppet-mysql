# Define: mysql::resource::database
#
# This definition creates mysql database
#
# Parameters:
#   [*dbname*]        - Database name. Default [$name]
#   [*character_set*] - Database character set. Default: utf8
#   [*collate*]       - Database collation
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   mysql::resource::database { 'test': }
define mysql::resource::database (
  $dbname        = $name,
  $character_set = 'utf8',
  $collate       = undef
) {
  Exec {
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => Class['mysql::config']
  }

  $collation = $collate ? {
    undef   => '',
    default => " COLLATE ${collate}"
  }

  exec { "mysql-create-database-${dbname}":
    command => "mysql -uroot -p${mysql::config::root_password} -e \"CREATE DATABASE IF NOT EXISTS ${dbname} CHARACTER SET ${character_set}${collation};\"",
  }
}