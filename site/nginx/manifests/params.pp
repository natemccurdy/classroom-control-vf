class nginx::params {

  case $facts['os']['family'] {
    'redhat': {
      $service_user = 'nginx'
      $docroot      = '/var/www'
      $confdir      = '/etc/nginx'
      $conf_d_dir   = "${confdir}/conf.d"
    }
    'debian': {
      $service_user = 'www-data'
      $docroot      = '/var/www'
      $confdir      = '/etc/nginx'
      $conf_d_dir   = "${confdir}/conf.d"
    }
    default: {
      fail("The ${facts['os']['family']} OS is not supported")
    }
  }

}
