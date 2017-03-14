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
file { '/var/www/index.html' :
  ensure => file,
  source => 'puppet:///modules/nginx/files/index.html'
  }
 }
