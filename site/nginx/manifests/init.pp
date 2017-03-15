class nginx {
  
  $sp = 'nginx'
  $docr = '/var/www'
  $cdir = "/etc/${sp}"
  $conf_d = "${cdir}/conf.d"

  File {
    owner => 'root',
    group => 'root',
    mode => '0644',
  }

  package { $sp:
  ensure => present,
  }

  file { $docr:
  ensure => directory,
  mode => '0775',
  }

  file { "${docr}/index.html":
  ensure => file,
  source => 'puppet:///modules/nginx/index.html',
  }

  file { "${cdir}/nginx.conf":
  ensure => file,
  source => 'puppet:///modules/nginx/nginx.conf',
  require => Package[$sp],
  notify => Service[$sp],
  }

  file { $conf_d:
  ensure => directory,
  mode => '0775',
  }

  file { "${conf_d}i/default.conf":
  ensure => file,
  source => 'puppet:///modules/nginx/default.conf',
  require => Package[$sp],
  notify => Service[$sp],
  }

  service { $sp:
  ensure => running,
  enable => true,
  }
}
