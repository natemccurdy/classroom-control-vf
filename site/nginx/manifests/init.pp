class nginx (
  String $docroot = '/var/www'
) {

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

  if $docroot {
    include ngnix::docroot
    file { $docroot:
      ensure => directory,
    }
    file { "${docroot}/index.html":
      ensure => file,
      source => 'puppet:///modules/nginx/index.html',
    }
  }

  file { "${confdir}/nginx.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { "${conf_d_dir}/default.conf":
    ensure  => file,
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}

