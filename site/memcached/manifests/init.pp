class memcached {


package { 'memcached':
ensure => present '
}

service { 'memcached':
ensure => running ,
enable => true,
}

file { 'conf file':
ensure =file,
path = '/etc/sysconfig/memcached',
source = 'puppet:///modules/memcached/index.conf',

}



}
