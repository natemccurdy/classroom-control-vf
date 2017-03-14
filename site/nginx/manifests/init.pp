class nginx {
service { 'nginx':
  ensure => running,
  require => [Package['nginx'], File['/var/www']],
  }
package { 'nginx':
  ensure => installed,
  }
file { '/var/www' :
  ensure => directory,
  }
 }
