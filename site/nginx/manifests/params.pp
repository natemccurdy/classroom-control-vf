class nginx::params {
case $facts['os']['name'] {
  'Debian','RedHat','CentOS' :  { 
    $package_name = 'nginx'; 
    $owner = 'root'; 
    $group= 'root'; 
    $web_dir = '/var/www' ; 
    $nginx_conf_dir = '/etc/nginx';
    $nginx_block_dir = '/etc/nginx/conf.d';
    $log_dir = '/var/log/nginx';
    $block_file = epp('nginx/default.epp', { web_dir => $web_dir })
    } 
  'Windows':  { 
    $package_name = 'nginx-service';
    $owner = 'Administrator'; 
    $group= 'Administrators'; 
    $web_dir = '/var/www'; 
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
}
