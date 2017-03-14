package { 'nginx':
  ensure => installed,
  require => File['/var/www'],
  }
file { '/var/www' :
  ensure => directory,
  }
