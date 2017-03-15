class nginx {

  package { 'nginx':
    ensure => present,
  }

  file { 'docroot':
    ensure => directory,
    path   => '/var/www',
  }

  file { 'html':
    ensure => file,
    path   => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
  }

  file { 'nginx config':
    ensure => file,
    path   => '/etc/nginx/nginx.conf',
    source => 'puppet:///modules/nginx/nginx.conf',
  }

  file { 'default site config':
    ensure => file,
    path   => '/etc/nginx/conf.d/default.conf',
    source => 'puppet:///modules/nginx/default.conf',
  }

  service { 'nginx':
    ensure => running,
    enable => true,
  }

}
