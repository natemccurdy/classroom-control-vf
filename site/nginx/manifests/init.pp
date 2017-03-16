class nginx (
  $service_user = $nginx::params::service_user,
  $docroot      = $nginx::params::docroot,
  $confdir      = $nginx::params::confdir,
  $conf_d_dir   = $nginx::params::conf_d_dir,
) inherits nginx::params {

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
    content => epp('nginx/default.conf.epp'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}
