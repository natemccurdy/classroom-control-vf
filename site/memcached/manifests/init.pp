class memcached{

package { 'memcached':
    ensure => present,
  }
  
  file { '/etc/sysconfig/memcached':
    ensure  => file,
    require => Package['memcached'],
  }
  
  service { 'memcached':
     ensure => running,
     require => File['/etc/sysconfig/memcached'],
  
  }


}
