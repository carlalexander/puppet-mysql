class mysql inherits mysql::params {
  class { 'mysql::package': 
    notify => Class['mysql::service'],
  }

  class { 'mysql::config': }

  class { 'mysql::service': }
}