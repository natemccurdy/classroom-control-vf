class nginx (
  $docroot = '/var/www',
) {

  case $facts['os']['family'] {
    'redhat': {
      $service_user = 'nginx'
    }
    'debian': {
      $service_user = 'www-data'
    }
    default: {
      fail("The $facts['os']['family'] OS is not supported")
    }
  }
  
  $confdir    = '/etc/nginx'
  $conf_d_dir = "${confdir}/conf.d"
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
  
  package { 'nginx':
    ensure => present,
  }

  file { $docroot:
    ensure => directory,
  }

  file { "${docroot}/index.html":
    ensure => file,
    source => 'puppet:///modules/nginx/index.html',
  }

  file { "${confdir}/nginx.conf":
    ensure  => file,
    content => epp('nginx/nginx.conf.epp'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "${conf_d_dir}/default.conf":
    ensure  => file,
    conten  => epp('nginx/default.conf.epp'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}
