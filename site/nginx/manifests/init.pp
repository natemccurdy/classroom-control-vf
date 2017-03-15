class nginx {

File {
owner => 'root',
group => 'root',
mode => '0644',
require => Package['nginx'],
}

$module_dir = 'puppet:///modules/nginx'

service { 'nginx':
  ensure => running,
  require => [File['/var/www/index.html'], File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf']],
  }
package { 'nginx':
  ensure => installed,
  }
file { '/var/www' :
  ensure => directory,
  }
file { '/var/www/index.html' :
  ensure => file,
  source => "${module_dir}/index.html",  
  }
file { '/etc/nginx/nginx.conf':
  ensure => file,
  source => "${module_dir}/nginx.conf",
  }
file { '/etc/nginx/conf.d/default.conf':
  ensure => file,
  source => "${module_dir}/default.conf",
  }
 }
