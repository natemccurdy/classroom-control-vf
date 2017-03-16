class nginx (
  $root = '/var/www'
)
{
$module_dir = 'puppet:///modules/nginx'

case $facts['os']['name'] {
  'Debian','RedHat','CentOS' :  { 
    $package_name = 'nginx'; 
    $owner = 'root'; 
    $group= 'root'; 
    $web_dir = $root; 
    $nginx_conf_dir = '/etc/nginx';
    $nginx_block_dir = '/etc/nginx/conf.d';
    $log_dir = '/var/log/nginx';
    $block_file = epp('nginx/default.epp', { web_dir => $web_dir })
    } 
  'Windows':  { 
    $package_name = 'nginx-service';
    $owner = 'Administrator'; 
    $group= 'Administrators'; 
    $web_dir = $root; 
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
  'RedHat','CentOS':  { $nginx_conf = epp('nginx/nginx.epp', { 
    user => 'nginx', 
    web_dir => $web_dir, 
    nginx_conf_dir => $nginx_conf_dir, 
    nginx_block_dir => $nginx_block_dir,
    log_dir => $log_dir
    })} 
  'Windows':  { $nginx_conf = epp('nginx/nginx.epp', { 
    user => 'nobody', 
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
  require => [File['index_file'], File['config_file'], File['block_file']],
  }
package { 'nginx':
  ensure => installed,
  }
file { $web_dir :
  ensure => directory,
  }
file { index_file :
  path => "${web_dir}/index.html",
  ensure => file,
  source => "${module_dir}/index.html",  
  }
file { config_file :
  path => "${nginx_conf_dir}/nginx.conf",
  ensure => file,
  content => $nginx_conf,
  }
file { block_file :
  path => "${nginx_block_dir}/default.conf",
  ensure => file,
  content => $block_file,
  }
 }
