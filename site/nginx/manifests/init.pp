class nginx {
service { 'nginx':
  ensure => running,
  require => [Package['nginx'], File['/var/www'], File['/var/www/index.html'], File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf']],
  }
package { 'nginx':
  ensure => installed,
  }
file { '/var/www' :
  ensure => directory,
  }
file { '/var/www/index.html' :
  ensure => file,
  source => 'puppet:///modules/nginx/index.html'
  }
file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/nginx.conf'
  }
file { '/etc/nginx/conf.d/default.conf':
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf'
  }
 }
