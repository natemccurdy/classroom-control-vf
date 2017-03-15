class memcached {

  package { 'memcached':
    ensure => present,
  }

  file { '/etc/sysconfig/memcached':
    ensure => file,
    source  => 'puppet:///modules/memcached/etc_sysconfig_memcached',
  }

  service { 'memcached':
    ensure => running,
    enable => true,
    subscribe => File['/etc/sysconfig/memcahced'],
  }

}
