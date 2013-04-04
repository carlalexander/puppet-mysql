# Class: mysql::params
# 
# This class manages MySQL parameters.
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
class mysql::params {
  $backup_dir = '/var/backups'
  $base_dir   = '/usr'
  $conf_dir   = '/etc/mysql'
  $data_dir   = '/var/lib/mysql'
  $tmp_dir    = '/tmp'

  $user         = 'mysql'
  $pid          = '/var/run/mysqld/mysqld.pid'
  $socket       = '/var/run/mysqld/mysqld.sock'
  $bind_address = '127.0.0.1'
  $port         = 3306
}