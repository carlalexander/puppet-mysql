# Define: mysql::resource::user
#
# This definition creates a database user
#
# Parameters:
#   [*username*]    - Username of the new user. Default [$name]
#   [*password*]    - User password
#   [*priviliges*]  - Priviliges to be granted to the user. Default: ALL
#   [*object*]      - Objects that the user will be granted access to. Default: *.*
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
#   mysql::resource::user { 'localuser':
#     password => 'password'
#   }
define mysql::resource::user (
  $username   = $name,
  $password   = undef,
  $priviliges = 'ALL',
  $object     = '*.*',
) {
  Exec {
    path    => '/bin:/sbin:/usr/bin:/usr/sbin',
    require => Class['mysql::config']
  }

  if ($password == undef or $password == '') {
    fail('You must set a password')
  }

  exec { "mysql-create-user-${username}":
    command => "mysql -uroot -p${mysql::config::root_password} -e \"CREATE USER ${username}@localhost IDENTIFIED BY '${password}';\"",
    unless  => "mysql -u${username} -p${password} -e 'SHOW DATABASES'",
    notify  => Exec["mysql-setup-user-${username}"],
  }

  exec { "mysql-setup-user-${username}":
    command     => "mysql -uroot -p${mysql::config::root_password} -e \"GRANT ${priviliges} ON ${object} TO ${username}@localhost;\"",
    refreshonly => true,
  }
}