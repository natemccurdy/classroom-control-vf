class nginx {
service { 'nginx':
  require => [Package['nginx'], File['/var/www']],
  }
package { 'nginx':
  ensure => installed,
  }
file { '/var/www' :
  ensure => directory,
  }
 }
