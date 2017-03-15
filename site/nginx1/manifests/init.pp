class nginx1 {

$sourcefile = 'puppet:///modules/nginx1'
$confdir = '/etc/nginx'

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
 path => "$confdir/default.conf",
 source => "$sourcefile/default.conf",
}

 file { 'conf file':
 ensure => file,
 path => "$confdir/nginx.cong",
 source => "$sourcefile/nginx.conf",
 require => Package['nginx'],
}

service { 'nginx':
ensure => running,
enable => true,
subscribe => "$confdir/nginx.conf",

}

}
