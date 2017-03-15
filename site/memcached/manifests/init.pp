class memcached {
  package { 'memcached' :
    ensure => installed,
    }
  file { '/etc/sysconfig/memcached' :
    ensure => file,
    source => 'puppet:///modules/memcached/memcached',  
    require => Package['memcached'],
  }
  service { 'memcached' :
    ensure => running,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
