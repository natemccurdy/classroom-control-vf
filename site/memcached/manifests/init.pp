class memcached {


package { 'memcached':
ensure => present,
}

service { 'memcached':
ensure => running ,
enable => true,
subscribe => File ['/etc/sysconfig/memcached'],
}

file { 'conf file':
ensure =file,
path = '/etc/sysconfig/memcached',
source = 'puppet:///modules/memcached/index.conf',
require => Package ['memcached'],
}



}
