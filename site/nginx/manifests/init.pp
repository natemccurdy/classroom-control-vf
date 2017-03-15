class nginx {

$module_dir = 'puppet:///modules/nginx'

case $facts['os']['name'] {
  'Debian','RedHat' :  { 
    $package_name = 'nginx'; 
    $owner = 'root'; 
    $group= 'root'; 
    $web_dir = '/var/www'; 
    $nginx_conf_dir = '/etc/nginx';
    $nginx_conf_dir = '/etc/nginx/conf.d';
    $log_dir = '/var/log/nginx';
    $block_file = epp('nginx/default.epp', { web_dir => $web_dir })
    } 
  'Windows':  { 
    $package_name = 'nginx-service';
    $owner = 'Administrator'; 
    $group= 'Administrators'; 
    $web_dir = 'C:/ProgramData/nginx/html'; 
    $nginx_conf_dir = 'C:/ProgramData/nginx';
    $nginx_block_dir = 'C:/ProgramData/nginx/conf.d';
    $log_dir = 'C:/ProgramData/nginx/logs'
    $block_file = epp('nginx/default.epp', { web_dir => $web_dir })
    } 
   default :  { notice("OS not supported") }
}

case $facts['os']['name'] {
  'Debian':  { $nginx_conf = epp('nginx/nginx.epp', { 
    user => 'www-data', 
    web_dir => $web_dir, 
    nginx_conf_dir => $nginx_conf_dir, 
    nginx_block_dir => $nginx_block_dir,
    log_dir => $log_dir
    })} 
  'RedHat':  { $nginx_conf = epp('nginx/nginx.epp', { 
    user => 'nginx' 
    web_dir => $web_dir, 
    nginx_conf_dir => $nginx_conf_dir, 
    nginx_block_dir => $nginx_block_dir,
    log_dir => $log_dir
    })} 
  'Windows':  { $nginx_conf = epp('nginx/nginx.epp', { 
    user => 'nobody' 
    web_dir => $web_dir, 
    nginx_conf_dir => $nginx_conf_dir, 
    nginx_block_dir => $nginx_block_dir,
    log_dir => $log_dir
    })} 
   default :  { notice("OS not supported") }
}

File {
owner => $owner,
group => $group,
mode => '0644',
require => Package['nginx'],
}

service { 'nginx':
  ensure => running,
  require => [File['web_index'], File['config'], File['block']],
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
  content => $nginx_conf,
  }
file { "${nginx_block_dir}/default.conf":
  ensure => file,
  content => $block_file,
  }
 }
