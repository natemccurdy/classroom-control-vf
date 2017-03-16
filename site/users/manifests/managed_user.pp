define users::managed_user (
  $username  = $title,
  $groupname = $title,
  $homedir   = "/home/${username}",
) {

  user { $username:
    ensure => present,
    gid    => $groupname,
  }
  
  group { $groupname:
    ensure => present,
  }
  
  file { $homedir:
    ensure => directory,
    owner  => $username,
    group  => $groupname,
    mode   => '0750',
  }
  
  file { "${homedir}/.ssh":
    ensure => directory,
    owner  => $username,
    group  => $groupname,
    mode   => '0750',
  }
  
  exec { "SSH key for ${username}":
    command => "ssh-keygen -C '${username}' -b 2048 -f '${homedir}/.ssh/id_rsa' -t rsa -N ''",
    creates => "${homedir}/.ssh/id_rsa",
    path    => $facts['path'],
    require => File["${homedir}/.ssh"],
  }
  
}
