class nginx1 {

$sourcefile = 'puppet:///modules/nginx1'
$confdir = '/etc/nginx/nginx.conf'

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
 source => "$sourcefile/index.html",
}

 file { 'block file':
 ensure => file,
 path => $confdir,
 source => "$sourcefile/default.conf",
}

 file { 'conf file':
 ensure => file,
 path => '/etc/nginx/nginx.conf',
 source => "$sourcefile/nginx.conf",
 require => Package['nginx'],
}

service { 'nginx':
ensure => running,
enable => true,
subscribe => $confdir

}

}
