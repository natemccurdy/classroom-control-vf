class nginx1 {

package { 'nginx':
ensure => 'present',
}

 file { 'doc root':
 ensure => directory,
 path => '/var/www',

}


file { 'index file':
 ensure => file,
 path => '/var/www/index.html',
 source => 'puppet:///modules/nginx1/index.html',
}

 file { 'block file':
 ensure => file,
 path => '/etc/nginx/conf.d/default.conf',
 source => 'puppet:///modules/nginx1/default.conf',
}

 file { 'conf file':
 ensure => file,
 path => '/etc/nginx/nginx.conf',
 source => 'puppet:///modules/nginx1/nginx.conf',
}

service { 'nginx':
ensure => running,
enable => true,


}

}
