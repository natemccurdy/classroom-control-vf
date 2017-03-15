class nginx {
service { 'nginx':
  ensure => running,
  require => [File['/var/www/index.html'], File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf']],
  }
package { 'nginx':
  ensure => installed,
  }
file { '/var/www' :
  ensure => directory,
  require => Package['nginx'],
  }
file { '/var/www/index.html' :
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',  
  require => File['/var/www'],
  }
file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/nginx.conf'
  require => Package['nginx'],
  }
file { '/etc/nginx/conf.d/default.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf',
  require => Package['nginx'],
  }
 }
