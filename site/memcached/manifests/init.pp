class memcached{

package { 'memcached':
    ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure  => file,
    require => Package['memcached'],
    content => 'PORT="11211"
USER="memcached"
MAXCONN="96"
CACHESIZE="32"
OPTIONS=""',
  }
  
  service { 'memcached':
     ensure => running,
     require => File['/etc/sysconfig/memcached'],
  
  }


}
