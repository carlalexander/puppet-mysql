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