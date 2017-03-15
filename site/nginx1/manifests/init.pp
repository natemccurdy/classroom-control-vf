class nginx1 {

package { 'nginx':
ensure => present'
}

 file { 'doc root':
 ensure => directory,
 path => '/var/www',

}

 file { 'block file':
 ensure => file,
 path => '/etc/nginx/conf.d/default.conf',
 source => 'puppet:///modules/nginx1/default',
}

 file { 'conf file':
 ensure => file,
 path => '/etc/nginx/nginx.conf',
 source => 'puppet:///modules/nginx1/nginx.conf',
}

}
