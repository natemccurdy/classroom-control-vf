

class nginx {

package { 'nginx':
ensure => present,
}

file { 'doc root':
ensure => directory,
path => '/var/www',
}

file { 'doc file':
ensure => file,
path => '/etc/nginx/nginx.conf',
}

file { 'block file':
ensure => file,
path => '/etc/nginx/conf.d/default.conf',
}


}
