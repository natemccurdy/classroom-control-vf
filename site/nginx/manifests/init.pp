class nginx (
  $package_name = $nginx::params::package_name ,
  $owner = $nginx::params::owner ,
  $group= $nginx::params::group ,
  $web_dir = $nginx::params::web_dir ,
  $nginx_conf_dir = $nginx::params::nginx_conf_dir ,
  $nginx_block_dir = $nginx::params::nginx_block_dir ,
  $log_dir = $nginx::params::log_dir ,
  $block_file = $nginx::params::block_file ,
) inherits nginx::params
{

$module_dir = 'puppet:///modules/nginx'



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
