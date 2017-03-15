class nginx {

File {
owner => 'root',
group => 'root',
mode => '0644',
require => Package['nginx'],
}

$module_dir = 'puppet:///modules/nginx'
$web_dir = '/var/www'
$nginx_conf_dir = '/etc/nginx'

case $facts['os']['name'] {
  'Debian':  { $user = epp('nginx/nginx.epp', { user => 'www-data' })} 
  'RedHat':  { $user = epp('nginx/nginx.epp', { user => 'nginx' })} 
  default :  { notice("OS not supported"); $user = epp('nginx/nginx.epp', { user => 'nginx' }) }
}

service { 'nginx':
  ensure => running,
  require => [File['/var/www/index.html'], File['/etc/nginx/nginx.conf'], File['/etc/nginx/conf.d/default.conf']],
  }
package { 'nginx':
  ensure => installed,
  }
file { $web_dir :
  ensure => directory,
  }
file { "${web_dir}/index.html" :
  ensure => file,
  source => "${module_dir}/index.html",  
  }
file { "${nginx_conf_dir}/nginx.conf" :
  ensure => file,
  source => $user,
  }
file { "${nginx_conf_dir}/conf.d/default.conf":
  ensure => file,
  source => "${module_dir}/default.conf",
  }
 }
